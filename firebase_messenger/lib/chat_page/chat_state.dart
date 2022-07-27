part of 'chat_bloc.dart';

@immutable
class ChatState {
  final bool isSendButtonEnabled;
  final List<MessageInfo> oldMessages;
  final List<MessageInfo> newMessages;
  final int? queryCursorToOld;
  final ReadMessagesState readMessages;
  final int? partakerLastSeen;

  const ChatState({
    this.isSendButtonEnabled = false,
    required this.oldMessages,
    required this.newMessages,
    this.queryCursorToOld,
    this.readMessages = ReadMessagesState.initial,
    this.partakerLastSeen,
  });

  ChatState copyWith({
    bool? isSendButtonEnabled,
    List<MessageInfo>? oldMessages,
    List<MessageInfo>? newMessages,
    int? queryCursorToOld,
    ReadMessagesState? readMessages,
    int? partakerLastSeen,
  }) {
    return ChatState(
      isSendButtonEnabled: isSendButtonEnabled ?? this.isSendButtonEnabled,
      oldMessages: oldMessages ?? this.oldMessages,
      newMessages: newMessages ?? this.newMessages,
      queryCursorToOld: queryCursorToOld ?? this.queryCursorToOld,
      readMessages: readMessages ?? this.readMessages,
      partakerLastSeen: partakerLastSeen ?? this.partakerLastSeen,
    );
  }
}

enum ReadMessagesState {
  initial,
  loaded,
  loading,
  end,
}
