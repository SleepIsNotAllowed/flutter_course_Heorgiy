import 'package:firebase_messenger/users_and_chats_page/users_and_chats_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersAndChatsBloc, UsersAndChatsState>(
      builder: (context, state) {
        return BottomNavigationBar(
          currentIndex: 0,
          items: const [
            BottomNavigationBarItem(
              label: 'Contacts',
              icon: Icon(Icons.people_alt_outlined),
            ),
            BottomNavigationBarItem(
              label: 'Chats',
              icon: Icon(Icons.chat_outlined),
            ),
          ],
          selectedItemColor: Colors.deepPurple,
          selectedLabelStyle: const TextStyle(color: Colors.deepPurple),
          backgroundColor: Colors.grey.shade200,
          onTap: (index) => context.read<UsersAndChatsBloc>().add(
                NavigationChanged(index: index),
              ),
        );
      },
    );
  }
}