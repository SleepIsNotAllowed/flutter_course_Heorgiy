
import 'package:firebase_messenger/data_models/user_contact_info.dart';
import 'package:firebase_messenger/users_and_chats_page/users_and_chats_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersListView extends StatelessWidget {
  final UsersAndChatsBloc bloc;

  const UsersListView({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersAndChatsBloc, UsersAndChatsState>(
      builder: (context, state) {
        if (state.usersList == null) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.purple,
              strokeWidth: 6,
            ),
          );
        } else {
          return ListView(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            children: buildContactsTiles(context, state),
          );
        }
      },
    );
  }

  List<Widget> buildContactsTiles(
      BuildContext context, UsersAndChatsState state) {
    List<Widget> contactTiles = [];
    String userId = state.currentUserId!;

    for (UserContactInfo partakerInfo in state.usersList!) {
      contactTiles.add(
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, 'chat', arguments: {
              'chatName': _createChatName(userId, partakerInfo.userId),
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

    return contactTiles;
  }

  String _createChatName(String userId, String partakerId) {
    for (int i = 0; i < userId.length; i++) {
      if (userId.codeUnitAt(i) > partakerId.codeUnitAt(i)) {
        return '$userId${partakerId}chat';
      } else if (userId.codeUnitAt(i) < partakerId.codeUnitAt(i)) {
        return '$partakerId${userId}chat';
      }
    }
    return '$partakerId${userId}chat';
  }
}
