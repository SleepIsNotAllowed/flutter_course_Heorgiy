import 'package:firebase_messenger/authorization_page/auth_page.dart';
import 'package:firebase_messenger/users_and_chats_page/users_and_chats_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget{
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.grey.shade200,
      actions: [
        IconButton(
          onPressed: () async {
            context.read<UsersAndChatsBloc>().add(UserSignOut());
            Navigator.pushReplacementNamed(
              context,
              'auth',
            );
          },
          icon: const Icon(
            Icons.exit_to_app_rounded,
            color: Colors.deepPurple,
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
