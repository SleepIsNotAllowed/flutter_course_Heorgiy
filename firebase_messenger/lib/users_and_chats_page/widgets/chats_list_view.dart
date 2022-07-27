import 'package:firebase_messenger/data_models/chat_info.dart';
import 'package:firebase_messenger/data_models/user_contact_info.dart';
import 'package:firebase_messenger/users_and_chats_page/users_and_chats_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatsListView extends StatelessWidget {
  const ChatsListView({Key? key}) : super(key: key);

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
      bool isOffline =
          DateTime.now().difference(partakerInfo.lastUpdated).inMinutes > 3;

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
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 19,
                ),
              ),
              subtitle: Text(
                chatInfo.lastMessage,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              leading: SizedBox(
                height: 48,
                width: 50,
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: partakerInfo.thumbnailColor,
                      child: Text(
                        partakerInfo.name[0].toUpperCase(),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: CircleAvatar(
                        radius: 8,
                        backgroundColor: isOffline
                            ? Colors.transparent
                            : Colors.grey.shade200,
                        child: CircleAvatar(
                          radius: 6,
                          backgroundColor: isOffline
                              ? Colors.transparent
                              : Colors.greenAccent.shade400,
                        ),
                      ),
                    )
                  ],
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
