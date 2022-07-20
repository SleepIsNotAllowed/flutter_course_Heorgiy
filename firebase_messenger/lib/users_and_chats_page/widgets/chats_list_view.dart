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
        return const Center(
          child: Text('Chats View'),
        );
      },
    );
  }
}
