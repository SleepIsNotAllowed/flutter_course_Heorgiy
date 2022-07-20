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
        if (state.usersData == null) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.purple,
              strokeWidth: 6,
            ),
          );
        } else {
          return ListView(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            children: buildContactsTiles(state.usersData!),
          );
        }
      },
    );
  }

  List<Widget> buildContactsTiles(List<UserContactInfo> usersData) {
    List<Widget> contactTiles = [];

    for (UserContactInfo userInfo in usersData) {
      contactTiles.add(
        Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: ListTile(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            tileColor: Colors.grey.shade200,
            title: Text(userInfo.name),
            leading: CircleAvatar(
              backgroundColor: userInfo.thumbnailColor,
              child: Text(
                userInfo.name[0].toUpperCase(),
                style: const TextStyle(color: Colors.white, fontSize: 19),
              ),
            ),
          ),
        ),
      );
    }

    return contactTiles;
  }
}
