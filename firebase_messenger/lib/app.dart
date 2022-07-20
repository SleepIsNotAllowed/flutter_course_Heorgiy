import 'package:firebase_messenger/authorization_page/auth_page.dart';
import 'package:firebase_messenger/networking/firebase_auth_client.dart';
import 'package:firebase_messenger/users_and_chats_page/users_and_chats_page.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirebaseAuthClient().auth.currentUser == null
          ? const AuthPage()
          : const UsersAndChatsPage(),
    );
  }
}
