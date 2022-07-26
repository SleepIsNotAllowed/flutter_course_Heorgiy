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
  FirebaseAuthClient authClient = FirebaseAuthClient();
  FirestoreClient firestoreClient = FirestoreClient();

  UsersAndChatsBloc() : super(const UsersAndChatsState(navigationIndex: 0)) {
    StreamSubscription usersChanges =
        firestoreClient.availableUsersStream().listen((snapshot) async {
      List<UserContactInfo> usersList = [];
      for (final document in snapshot.docs) {
        Map<String, dynamic> userInfo = document.data();
        usersList.add(UserContactInfo.fromDoc(userInfo));
      }
      add(RefreshUsersList(usersList: usersList));
    });

    StreamSubscription chatsChanges =
        firestoreClient.availableChatsStream().listen((snapshot) async {
      List<ChatInfo> chatsList = [];
      for (final document in snapshot.docs) {
        Map<String, dynamic> chatInfo = document.data();
        chatsList.add(ChatInfo.fromDoc(chatInfo));
      }
      add(RefreshChatsList(chatsList: chatsList));
    });

    on<NavigationChanged>((event, emit) {
      emit(state.copyWith(navigationIndex: event.index));
    });

    on<UserSignOut>((event, emit) async {
      chatsChanges.cancel();
      usersChanges.cancel();
      await authClient.signOut();
    });

    on<RefreshUsersList>((event, emit) {
      emit(state.copyWith(
        usersList: event.usersList,
        currentUserId: authClient.auth.currentUser?.uid,
      ));
    });

    on<RefreshChatsList>((event, emit) {
      emit(state.copyWith(
        chatsList: event.chatsList,
      ));
    });
  }
}
