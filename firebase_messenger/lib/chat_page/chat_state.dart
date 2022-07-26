part of 'chat_bloc.dart';

@immutable
class ChatState {
  final bool isSendButtonEnabled;
  final List<MessageInfo> oldMessages;
  final List<MessageInfo> newMessages;
  final int? lastMessageStamp;
  final ReadMessagesState readMessages;

  const ChatState({
    this.isSendButtonEnabled = false,
    required this.oldMessages,
    required this.newMessages,
    this.lastMessageStamp,
    this.readMessages = ReadMessagesState.initial,
  });

  ChatState copyWith({
    bool? isSendButtonEnabled,
    List<MessageInfo>? oldMessages,
    List<MessageInfo>? newMessages,
    int? lastMessageStamp,
    ReadMessagesState? readMessages,
  }) {
    return ChatState(
      isSendButtonEnabled: isSendButtonEnabled ?? this.isSendButtonEnabled,
      oldMessages: oldMessages ?? this.oldMessages,
      newMessages: newMessages ?? this.newMessages,
      lastMessageStamp: lastMessageStamp ?? this.lastMessageStamp,
      readMessages: readMessages ?? this.readMessages,
    );
  }
}

enum ReadMessagesState {
  initial,
  loaded,
  loading,
  end,
}
