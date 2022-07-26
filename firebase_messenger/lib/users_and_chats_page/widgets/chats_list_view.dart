import 'package:firebase_messenger/data_models/chat_info.dart';
import 'package:firebase_messenger/data_models/user_contact_info.dart';
import 'package:firebase_messenger/users_and_chats_page/users_and_chats_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatsListView extends StatelessWidget {
  final UsersAndChatsBloc bloc;

  const ChatsListView({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersAndChatsBloc, UsersAndChatsState>(
      builder: (context, state) {
        if (state.chatsList == null) {
          return const CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 8,
          );
        } else if (state.chatsList!.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                'You have no available chats for now',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          );
        } else {
          return ListView(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            children: _buildChatsTiles(context, state),
          );
        }
      },
    );
  }

  List<Widget> _buildChatsTiles(
      BuildContext context, UsersAndChatsState state) {
    List<Widget> chatTiles = [];

    for (ChatInfo chatInfo in state.chatsList!) {
      late UserContactInfo partakerInfo;
      for (UserContactInfo info in state.usersList!) {
        if (info.userId == chatInfo.partakerId) {
          partakerInfo = info;
          break;
        }
      }

      chatTiles.add(
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, 'chat', arguments: {
              'chatName': chatInfo.chatName,
              'partakerInfo': partakerInfo,
            });
          },
          child: Card(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: ListTile(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              tileColor: Colors.grey.shade200,
              title: Text(
                partakerInfo.name,
                style: const TextStyle(
                  fontSize: 19,
                ),
              ),
              subtitle: Text(
                chatInfo.lastMessage,
              ),
              leading: CircleAvatar(
                radius: 24,
                backgroundColor: partakerInfo.thumbnailColor,
                child: Text(
                  partakerInfo.name[0].toUpperCase(),
                  style: const TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            ),
          ),
        ),
      );
    }

    return chatTiles;
  }
}
