part of 'chat_bloc.dart';

@immutable
abstract class ChatEvent {}

class InitialLoad extends ChatEvent {}

class UpdatePartakerPresence extends ChatEvent{
  final int lastSeen;

  UpdatePartakerPresence({required this.lastSeen});
}

class UpdateWithNewMessages extends ChatEvent {
  final List<MessageInfo> messages;

  UpdateWithNewMessages({required this.messages});
}

class LoadOldMessages extends ChatEvent {}

class TextChanged extends ChatEvent {}

class SendMessage extends ChatEvent {}

class LeaveChat extends ChatEvent {}
