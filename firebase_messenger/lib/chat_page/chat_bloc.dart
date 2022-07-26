import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messenger/data_models/message_info.dart';
import 'package:firebase_messenger/networking/firebase_auth_client.dart';
import 'package:firebase_messenger/networking/firestore_client.dart';
import 'package:flutter/material.dart';

part 'chat_event.dart';

part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  String chatName;
  String partakerId;
  FirestoreClient firestore = FirestoreClient();
  FirebaseAuthClient authClient = FirebaseAuthClient();
  TextEditingController messageController = TextEditingController();

  ChatBloc({required this.chatName, required this.partakerId})
      : super(const ChatState(oldMessages: [], newMessages: [])) {
    StreamSubscription newMessages = firestore
        .newMessagesStream(chatName, DateTime.now().millisecondsSinceEpoch)
        .listen((snapshot) async {
      List<MessageInfo> newMessages = [];
      for (final document in snapshot.docs) {
        Map<String, dynamic> storeMessage = document.data();
        newMessages.add(MessageInfo.fromDoc(storeMessage));
        add(UpdateWithNewMessages(
            messages: newMessages..addAll(state.newMessages)));
      }
    });

    on<InitialLoad>((event, emit) async {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await firestore.fetchInitialBatchOfMessages(chatName);
      if (snapshot.docs.isNotEmpty) {
        List<MessageInfo> messages = [];
        for (var document in snapshot.docs) {
          Map<String, dynamic> storeMessage = document.data();
          messages.add(MessageInfo.fromDoc(storeMessage));
        }
        emit(state.copyWith(
          oldMessages: messages,
          lastMessageStamp: snapshot.docs.last['timestamp'],
          readMessages: ReadMessagesState.loaded,
        ));
      } else {
        emit(state.copyWith(readMessages: ReadMessagesState.loaded));
      }
    });

    on<LoadOldMessages>((event, emit) async {
      QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
          .fetchOldMessagesBatch(chatName, state.lastMessageStamp!);
      if (snapshot.docs.isNotEmpty) {
        List<MessageInfo> messages = [];
        for (var document in snapshot.docs) {
          Map<String, dynamic> storeMessage = document.data();
          messages.add(MessageInfo.fromDoc(storeMessage));
        }
        emit(state.copyWith(
          oldMessages: state.oldMessages..addAll(messages),
          lastMessageStamp: snapshot.docs.last['timestamp'],
          readMessages: snapshot.docs.length < firestore.queryItemsNumber
              ? ReadMessagesState.end
              : ReadMessagesState.loaded,
        ));
      } else {
        emit(state.copyWith(readMessages: ReadMessagesState.end));
      }
    });

    on<TextChanged>((event, emit) {
      bool isButtonEnabled = messageController.text.isNotEmpty;
      if (state.isSendButtonEnabled != isButtonEnabled) {
        emit(state.copyWith(
          isSendButtonEnabled: isButtonEnabled,
        ));
      }
    });

    on<SendMessage>((event, emit) async {
      String text = messageController.text.trim();
      messageController.clear();
      emit(state.copyWith(isSendButtonEnabled: false));
      if (state.oldMessages.isEmpty) {
        await firestore.createChatReferences(
          partakerId,
          chatName,
        );
      }
      await firestore.sendMessage(
        text,
        authClient.auth.currentUser!.uid,
        DateTime.now().millisecondsSinceEpoch,
        chatName,
      );
    });

    on<UpdateWithNewMessages>((event, emit) {
      emit(state.copyWith(newMessages: event.messages));
    });

    on<LeaveChat>((event, emit) {
      newMessages.cancel();
    });
  }
}
