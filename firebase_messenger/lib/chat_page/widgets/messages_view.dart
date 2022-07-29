import 'package:firebase_messenger/chat_page/chat_bloc.dart';
import 'package:firebase_messenger/chat_page/widgets/messages_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessagesView extends StatelessWidget {
  final String partakerName;

  const MessagesView({Key? key, required this.partakerName}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        if (_isChatHistoryEmpty(state)) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Start a chat with $partakerName by sending a message',
                style: const TextStyle(color: Colors.white, fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
          );
        } else if (state.readMessages == ReadMessagesState.initial) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 8,
            ),
          );
        } else {
          return MessagesList(state: state);
        }
      },
    );
  }

  bool _isChatHistoryEmpty(ChatState state) {
    return state.oldMessages.isEmpty &&
        state.newMessages.isEmpty &&
        (state.readMessages == ReadMessagesState.loaded ||
            state.readMessages == ReadMessagesState.end);
  }
}
