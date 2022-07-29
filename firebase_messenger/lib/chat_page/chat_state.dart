part of 'chat_bloc.dart';

@immutable
class ChatState {
  final bool isSendButtonEnabled;
  final List<MessageInfo> oldMessages;
  final List<MessageInfo> newMessages;
  final int? queryCursorToOld;
  final ReadMessagesState readMessages;
  final int? partakerLastSeen;
  final bool? partakerOffline;

  const ChatState({
    this.isSendButtonEnabled = false,
    required this.oldMessages,
    required this.newMessages,
    this.queryCursorToOld,
    this.readMessages = ReadMessagesState.initial,
    this.partakerLastSeen,
    this.partakerOffline = true,
  });

  ChatState copyWith({
    bool? isSendButtonEnabled,
    List<MessageInfo>? oldMessages,
    List<MessageInfo>? newMessages,
    int? queryCursorToOld,
    ReadMessagesState? readMessages,
    int? partakerLastSeen,
    bool? partakerOffline,
  }) {
    return ChatState(
      isSendButtonEnabled: isSendButtonEnabled ?? this.isSendButtonEnabled,
      oldMessages: oldMessages ?? this.oldMessages,
      newMessages: newMessages ?? this.newMessages,
      queryCursorToOld: queryCursorToOld ?? this.queryCursorToOld,
      readMessages: readMessages ?? this.readMessages,
      partakerLastSeen: partakerLastSeen ?? this.partakerLastSeen,
      partakerOffline: partakerOffline ?? this.partakerOffline,
    );
  }
}

enum ReadMessagesState {
  initial,
  loaded,
  loading,
  end,
}
