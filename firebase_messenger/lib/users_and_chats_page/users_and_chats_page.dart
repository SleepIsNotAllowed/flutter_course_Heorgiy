import 'package:firebase_messenger/authorization_page/auth_page.dart';
import 'package:firebase_messenger/users_and_chats_page/users_and_chats_bloc.dart';
import 'package:firebase_messenger/users_and_chats_page/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersAndChatsPage extends StatefulWidget {
  const UsersAndChatsPage({Key? key}) : super(key: key);

  @override
  State<UsersAndChatsPage> createState() => _UsersAndChatsPageState();
}

class _UsersAndChatsPageState extends State<UsersAndChatsPage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UsersAndChatsBloc(),
        ),
      ],
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
        )),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            toolbarHeight: 40,
            backgroundColor: Colors.grey.shade200,
            actions: [
              IconButton(
                onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AuthPage(),
                  ),
                ),
                icon: const Icon(
                  Icons.exit_to_app_rounded,
                  color: Colors.deepPurple,
                ),
              )
            ],
          ),
          body: Center(),
          bottomNavigationBar: const BottomBar(),
        ),
      ),
    );
  }
}
