import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messenger/data_models/message_info.dart';
import 'package:firebase_messenger/networking/firebase_auth_client.dart';
import 'package:firebase_messenger/networking/firestore_client.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

part 'chat_event.dart';

part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final FirestoreClient firestore = FirestoreClient();
  final FirebaseAuthClient authClient = FirebaseAuthClient();
  final ItemScrollController itemScrollController = ItemScrollController();
  final TextEditingController messageController = TextEditingController();
  String chatName;
  String partakerId;

  ChatBloc({required this.chatName, required this.partakerId})
      : super(const ChatState(oldMessages: [], newMessages: [])) {
    StreamSubscription newMessages = firestore
        .newMessagesStream(chatName, DateTime.now().millisecondsSinceEpoch)
        .listen((snapshot) async {
      if (snapshot.docs.length > 0) {
        List<MessageInfo> newMessages = [];
        newMessages.add(MessageInfo.fromDoc(
          snapshot.docs.last.data(),
          snapshot.docs.last.id,
        ));
        add(UpdateWithNewMessages(
          messages: newMessages..addAll(state.newMessages),
        ));
      }
    });

    StreamSubscription presenceUpdater =
        Stream.periodic(const Duration(minutes: 3), (timer) async {
      DateTime partakerLastSeen =
          DateTime.fromMillisecondsSinceEpoch(state.partakerLastSeen!);
      if (DateTime.now().difference(partakerLastSeen).inMinutes > 2) {
        add(UpdatePartakerPresence(
          lastSeen: state.partakerLastSeen!,
          isOffline: true,
        ));
      }
      await firestore.updateUserPresence();
    }).listen((event) {});

    StreamSubscription partakerPresence =
        firestore.partakerPresenceStream(partakerId).listen((snapshot) {
      DateTime lastSeen =
          DateTime.fromMillisecondsSinceEpoch(snapshot.data()['timestamp']);
      bool isOffline = DateTime.now().difference(lastSeen).inMinutes > 3;
      add(UpdatePartakerPresence(
        lastSeen: snapshot.data()['timestamp'],
        isOffline: isOffline,
      ));
    });

    on<UpdatePartakerPresence>((event, emit) {
      emit(state.copyWith(
        partakerLastSeen: event.lastSeen,
        partakerOffline: event.isOffline,
      ));
    });

    on<InitialLoad>((event, emit) async {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await firestore.initialFetchOfOldMessages(chatName);
      if (snapshot.docs.isNotEmpty) {
        List<MessageInfo> messages = [];
        for (var document in snapshot.docs) {
          Map<String, dynamic> storeMessage = document.data();
          messages.add(MessageInfo.fromDoc(storeMessage, document.id));
        }
        emit(state.copyWith(
          oldMessages: messages,
          queryCursorToOld: snapshot.docs.last['timestamp'],
          readMessages: snapshot.docs.length < firestore.queryItemsNumber
              ? ReadMessagesState.end
              : ReadMessagesState.loaded,
        ));
      } else {
        emit(state.copyWith(readMessages: ReadMessagesState.end));
      }
    });

    on<LoadOldMessages>((event, emit) async {
      QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
          .fetchOldMessagesBatch(chatName, state.queryCursorToOld!);
      if (snapshot.docs.isNotEmpty) {
        List<MessageInfo> messages = [];
        for (var document in snapshot.docs) {
          Map<String, dynamic> storeMessage = document.data();
          messages.add(MessageInfo.fromDoc(storeMessage, document.id));
        }
        emit(state.copyWith(
          oldMessages: state.oldMessages..addAll(messages),
          queryCursorToOld: snapshot.docs.last['timestamp'],
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
        await firestore.createChatAndSendMessage(
          text,
          partakerId,
          DateTime.now().millisecondsSinceEpoch,
          chatName,
        );
      } else {
        await firestore.sendMessage(
          text,
          DateTime.now().millisecondsSinceEpoch,
          chatName,
        );
      }
    });

    on<UpdateWithNewMessages>((event, emit) {
      emit(state.copyWith(newMessages: event.messages));
    });

    on<LeaveChat>((event, emit) {
      newMessages.cancel();
      presenceUpdater.cancel();
      partakerPresence.cancel();
    });
  }
}
