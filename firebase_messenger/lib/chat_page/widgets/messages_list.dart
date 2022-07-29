import 'package:firebase_messenger/chat_page/chat_bloc.dart';
import 'package:firebase_messenger/data_models/message_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class MessagesList extends StatelessWidget {
  final ChatState state;
  const MessagesList({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width * 0.8;
    double minWidth = MediaQuery.of(context).size.width * 0.1;
    bool isEndReached = state.readMessages == ReadMessagesState.end;
    int newMessagesLength = state.newMessages.length;
    int itemCount = isEndReached
        ? newMessagesLength + state.oldMessages.length
        : newMessagesLength + state.oldMessages.length + 1;

    return ScrollablePositionedList.builder(
      padding: const EdgeInsets.all(8),
      reverse: true,
      itemScrollController: context.read<ChatBloc>().itemScrollController,
      itemCount: itemCount,
      itemBuilder: (BuildContext context, int index) {
        if (index == newMessagesLength + state.oldMessages.length - 10 &&
            !isEndReached) {
          /*
                if index of current widget that is building is equal to
                'loadThreshold' and last of all read messages isn't reached -
                start loading next chunk of messages
                */
          context.read<ChatBloc>().add(LoadOldMessages());
        }
        if (index == itemCount - 1 && !isEndReached) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 8,
            ),
          );
        } else {
          return _buildMessage(
            index >= newMessagesLength
                ? state.oldMessages[index - newMessagesLength]
                : state.newMessages[index],
            context,
            maxWidth,
            minWidth,
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
