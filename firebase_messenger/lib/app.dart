import 'package:firebase_messenger/authorization_page/auth_bloc.dart';
import 'package:firebase_messenger/authorization_page/auth_page.dart';
import 'package:firebase_messenger/chat_page/chat_page.dart';
import 'package:firebase_messenger/networking/firebase_auth_client.dart';
import 'package:firebase_messenger/users_and_chats_page/users_and_chats_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        'auth': (context) => const AuthPage(),
        'usersAndChats': (context) => const UsersAndChatsPage(),
        'chat': (context) => const ChatPage(),
      },
      initialRoute: FirebaseAuthClient().auth.currentUser == null
          ? 'auth'
          : 'usersAndChats',
    );
  }
}
