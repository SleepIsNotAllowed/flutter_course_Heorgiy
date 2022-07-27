import 'package:firebase_messenger/chat_page/chat_bloc.dart';
import 'package:firebase_messenger/data_models/message_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class MessagesView extends StatelessWidget {
  final String partakerName;

  const MessagesView({Key? key, required this.partakerName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width * 0.8;
    double minWidth = MediaQuery.of(context).size.width * 0.1;
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        if (state.oldMessages.isEmpty &&
            state.newMessages.isEmpty &&
            state.readMessages == ReadMessagesState.loaded) {
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
          int newMessagesLength = state.newMessages.length;
          int oldMessagesLength = state.oldMessages.length;
          int loadThreshold = newMessagesLength + oldMessagesLength - 10;
          return ScrollablePositionedList.builder(
            padding: const EdgeInsets.all(8),
            reverse: true,
            itemScrollController: context.read<ChatBloc>().itemScrollController,
            itemCount: newMessagesLength + oldMessagesLength,
            itemBuilder: (BuildContext context, int index) {
              if (index == loadThreshold &&
                  state.readMessages != ReadMessagesState.end) {
                /*
                if index of current widget that is building is equal to
                'loadThreshold' and last of all read messages isn't reached -
                start loading next chunk of messages
                */
                context.read<ChatBloc>().add(LoadOldMessages());
              }
              return _buildMessage(
                index >= newMessagesLength
                    ? state.oldMessages[index - newMessagesLength]
                    : state.newMessages[index],
                context,
                maxWidth,
                minWidth,
              );
            },
          );
        }
      },
    );
  }

  Widget _buildMessage(MessageInfo messageInfo, BuildContext context,
      double maxWidth, double minWidth) {
    return Align(
      alignment: messageInfo.fromCurrentUser
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(maxWidth: maxWidth, minWidth: minWidth),
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: messageInfo.fromCurrentUser
              ? Colors.deepPurpleAccent
              : Colors.grey.shade200,
          borderRadius: messageInfo.fromCurrentUser
              ? const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                )
              : const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
        ),
        child: Text(
          messageInfo.text,
          style: TextStyle(
            color: messageInfo.fromCurrentUser ? Colors.white : Colors.black,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
