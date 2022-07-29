import 'package:firebase_messenger/data_models/user_contact_info.dart';
import 'package:firebase_messenger/users_and_chats_page/users_and_chats_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersListView extends StatefulWidget {
  const UsersListView({
    Key? key,
  }) : super(key: key);

  @override
  State<UsersListView> createState() => _UsersListViewState();
}

class _UsersListViewState extends State<UsersListView> {
  late UsersAndChatsBloc bloc;

  @override
  void initState() {
    Future.microtask(() {
      bloc = context.read<UsersAndChatsBloc>();
      bloc.add(InitializeBloc());
    });
    super.initState();
  }

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
            children: _buildContactsTiles(context, state),
          );
        }
      },
    );
  }

  List<Widget> _buildContactsTiles(
      BuildContext context, UsersAndChatsState state) {
    List<Widget> contactTiles = [];
    String userId = state.currentUserId!;

    for (UserContactInfo partakerInfo in state.usersList!) {
      contactTiles.add(
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, 'chat', arguments: {
              'chatName': bloc.createChatName(userId, partakerInfo.userId),
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
              leading: CircleAvatar(
                radius: 24,
                backgroundColor: partakerInfo.thumbnailColor,
                child: Text(
                  partakerInfo.name[0].toUpperCase(),
                  style: const TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
              title: Text(
                partakerInfo.name,
                style: const TextStyle(
                  fontSize: 19,
                ),
              ),
              subtitle: Text(
                partakerInfo.isOffline ? 'offline' : 'online',
              ),
            ),
          ),
        ),
      );
    }

    return contactTiles;
  }
}
