import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messenger/authorization_page/auth_bloc.dart';
import 'package:firebase_messenger/users_and_chats_page/users_and_chats_page.dart';
import 'package:flutter/material.dart';

class AuthorizedWidget extends StatelessWidget {
  final AuthBloc bloc;

  const AuthorizedWidget({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: 250,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: 150,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              border: Border.all(
                width: 2,
                color: Colors.purple.shade800,
              )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Welcome, ${FirebaseAuth.instance.currentUser!.displayName!}!',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    color: Colors.purple.shade800,
                    fontSize: 20,
                  ),
                ),
                Text(
                  'You now registered via email: ${FirebaseAuth.instance.currentUser!.email!}',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: TextStyle(
                    color: Colors.purple.shade800,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                ),
                onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UsersAndChatsPage(),
                  ),
                ),
                child: const Text('Continue'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                ),
                onPressed: () => bloc.add(AuthSignOut()),
                child: const Text('Sign Out'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
