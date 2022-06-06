import 'package:firebase_flutter_project/pages/user_account_page/user_account_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoggInHomePage extends StatefulWidget {
  const LoggInHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<LoggInHomePage> createState() => _LoggInHomePageState();
}

class _LoggInHomePageState extends State<LoggInHomePage> {
  final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);

  @override
  Widget build(BuildContext context) {
    GoogleSignInAccount? user = googleSignIn.currentUser;

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
                const Text(
                  'Logg In with Google',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    color: Colors.white,
                  ),
                ),
                Text(
                  user == null ? 'Please, logg in to continue' : 'You logged',
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
                    await googleSignIn.signIn().then((value) => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserAccountPage(
                                googleSignIn: googleSignIn),
                          ),
                        ));
                  },
                  icon: const FaIcon(
                    FontAwesomeIcons.google,
                    color: Colors.blue,
                  ),
                  label: const Text(
                    'Sign In with Google',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
