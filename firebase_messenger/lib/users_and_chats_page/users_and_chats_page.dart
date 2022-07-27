import 'package:firebase_messenger/users_and_chats_page/users_and_chats_bloc.dart';
import 'package:firebase_messenger/users_and_chats_page/widgets/bottom_bar.dart';
import 'package:firebase_messenger/users_and_chats_page/widgets/chats_list_view.dart';
import 'package:firebase_messenger/users_and_chats_page/widgets/top_bar.dart';
import 'package:firebase_messenger/users_and_chats_page/widgets/users_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersAndChatsPage extends StatelessWidget {
  const UsersAndChatsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UsersAndChatsBloc>(
      create: (context) => UsersAndChatsBloc(),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.purple.shade800,
              Colors.deepPurple,
              Colors.blue.shade800,
            ],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: const TopBar(),
          body: BlocBuilder<UsersAndChatsBloc, UsersAndChatsState>(
            buildWhen: (prevState, newState) {
              return prevState.navigationIndex != newState.navigationIndex;
            },
            builder: (context, state) {
              return state.navigationIndex == 0
                  ? const UsersListView()
                  : const ChatsListView();
            },
          ),
          bottomNavigationBar: const BottomBar(),
        ),
      ),
    );
  }
}
