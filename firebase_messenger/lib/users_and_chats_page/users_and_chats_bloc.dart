import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_messenger/data_models/chat_info.dart';
import 'package:firebase_messenger/data_models/user_contact_info.dart';
import 'package:firebase_messenger/networking/firebase_auth_client.dart';
import 'package:firebase_messenger/networking/firestore_client.dart';
import 'package:flutter/material.dart';

part 'users_and_chats_event.dart';

part 'users_and_chats_state.dart';

class UsersAndChatsBloc extends Bloc<UsersAndChatsEvent, UsersAndChatsState> {
  final FirebaseAuthClient authClient = FirebaseAuthClient();
  final FirestoreClient firestore = FirestoreClient();

  UsersAndChatsBloc() : super(const UsersAndChatsState(navigationIndex: 0)) {
    StreamSubscription usersChanges =
        firestore.availablePartakersStream().listen((snapshot) async {
      List<UserContactInfo> usersList = [];
      for (final document in snapshot.docs) {
        Map<String, dynamic> userInfo = document.data();
        usersList.add(UserContactInfo.fromDoc(userInfo));
      }
      add(RefreshUsersList(usersList: usersList));
    });

    StreamSubscription presenceUpdater =
        Stream.periodic(const Duration(minutes: 3), (timer) async {
      for (UserContactInfo info in state.usersList!) {
        info.isOffline = DateTime.now().difference(info.lastSeen).inMinutes > 2;
      }
      add(RefreshUsersPresence());
      await firestore.updateUserPresence();
    }).listen((event) {});

    StreamSubscription chatsChanges =
        firestore.availableChatsStream().listen((snapshot) async {
      List<ChatInfo> chatsList = [];
      for (final document in snapshot.docs) {
        Map<String, dynamic> chatInfo = document.data();
        chatsList.add(ChatInfo.fromDoc(chatInfo));
      }
      add(RefreshChatsList(chatsList: chatsList));
    });

    on<InitializeBloc>((event, emit) {
      firestore.updateUserPresence();
      emit(state.copyWith(
        currentUserId: authClient.auth.currentUser?.uid,
      ));
    });

    on<NavigationChanged>((event, emit) {
      emit(state.copyWith(navigationIndex: event.index));
    });

    on<RefreshUsersList>((event, emit) {
      emit(state.copyWith(
        usersList: event.usersList,
      ));
    });

    on<RefreshChatsList>((event, emit) {
      emit(state.copyWith(
        chatsList: event.chatsList,
      ));
    });

    on<RefreshUsersPresence>((event, emit) {
      emit(state.copyWith());
    });

    on<UserSignOut>((event, emit) async {
      chatsChanges.cancel();
      usersChanges.cancel();
      presenceUpdater.cancel();
      await authClient.signOut();
    });
  }

  String createChatName(String userId, String partakerId) {
    for (int i = 0; i < userId.length; i++) {
      if (userId.codeUnitAt(i) > partakerId.codeUnitAt(i)) {
        return '$userId${partakerId}chat';
      } else if (userId.codeUnitAt(i) < partakerId.codeUnitAt(i)) {
        return '$partakerId${userId}chat';
      }
    }
    return '$partakerId${userId}chat';
  }
}
