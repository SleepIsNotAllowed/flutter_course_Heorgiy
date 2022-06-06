import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserAccountPage extends StatefulWidget {
  final GoogleSignIn googleSignIn;

  const UserAccountPage({
    Key? key,
    required this.googleSignIn,
  }) : super(key: key);

  @override
  State<UserAccountPage> createState() => _UserAccountPageState();
}

class _UserAccountPageState extends State<UserAccountPage> {
  @override
  Widget build(BuildContext context) {
    final GoogleSignInAccount user = widget.googleSignIn.currentUser!;

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/space-wallpaper.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            width: 320,
            height: 280,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey.shade800,
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(user.photoUrl!),
                ),
                Text(
                  'Welcome, ' + user.displayName!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Your email: ' + user.email,
                  maxLines: 2,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.white,
                  ),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.black54,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: () async {
                    await widget.googleSignIn.signOut();
                    Navigator.pop(context);
                  },
                  icon: const FaIcon(
                    FontAwesomeIcons.google,
                    color: Colors.blue,
                  ),
                  label: const Text('Sign Out'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
