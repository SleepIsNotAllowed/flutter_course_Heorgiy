import 'package:firebase_messenger/chat_page/chat_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatBottomBar extends StatelessWidget {
  const ChatBottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ChatBloc bloc = context.read<ChatBloc>();
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(8),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: (text) => bloc.add(TextChanged()),
              controller: bloc.messageController,
              minLines: 1,
              maxLines: 3,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Message',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 12,
                ),
              ),
            ),
          ),
          BlocBuilder<ChatBloc, ChatState>(
            buildWhen: (prevState, newState) {
              return prevState.isSendButtonEnabled !=
                  newState.isSendButtonEnabled;
            },
            builder: (context, state) {
              return ElevatedButton(
                onPressed: state.isSendButtonEnabled
                    ? () => bloc.add(SendMessage())
                    : null,
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  backgroundColor: Colors.blue.shade800,
                ),
                child: const Icon(Icons.arrow_upward_rounded),
              );
            },
          )
        ],
      ),
    );
  }
}
