import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_messenger/data_models/user_contact_info.dart';
import 'package:firebase_messenger/networking/firebase_auth_client.dart';
import 'package:firebase_messenger/networking/firestore_client.dart';
import 'package:flutter/material.dart';

part 'users_and_chats_event.dart';

part 'users_and_chats_state.dart';

class UsersAndChatsBloc extends Bloc<UsersAndChatsEvent, UsersAndChatsState> {
  FirebaseAuthClient authClient = FirebaseAuthClient();
  FirestoreClient firestoreClient = FirestoreClient();

  UsersAndChatsBloc() : super(const UsersAndChatsState()) {
    firestoreClient.getUsersListStream().listen((snapshot) async {
      List<UserContactInfo> usersInfo = [];
      for (final document in snapshot.docs) {
        Map userInfo = document.data();
        if (userInfo['userId'] != authClient.auth.currentUser?.uid) {
          usersInfo.add(
            UserContactInfo(
              name: userInfo['name'],
              userId: userInfo['userId'],
              thumbnailColor: Colors.primaries[userInfo['thumbnailColor']],
            ),
          );
        }
      }
      add(RefreshUsersList(usersInfo: usersInfo));
    });

    on<NavigationChanged>((event, emit) {
      emit(state.copyWith(navigationIndex: event.index));
    });

    on<UserSignOut>((event, emit) async {
      await authClient.signOut();
      await close();
    });

    on<RefreshUsersList>((event, emit) {
      emit(state.copyWith(usersData: event.usersInfo));
    });
  }
}
