import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserGreetingView extends StatelessWidget {
  final GoogleSignIn googleSignIn;

  const UserGreetingView({
    Key? key,
    required this.googleSignIn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GoogleSignInAccount user = googleSignIn.currentUser!;

    return Center(
      child: Container(
        width: 320,
        height: 280,
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GoogleUserCircleAvatar(identity: user),
            Text(
              'Welcome, ' + user.displayName!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
                color: Colors.white,
              ),
            ),
            const CircularProgressIndicator(
              strokeWidth: 6,
            ),
            const Text(
              'Preparing your files...',
              textAlign: TextAlign.center,
              maxLines: 2,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
