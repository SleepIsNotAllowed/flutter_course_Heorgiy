import 'package:firebase_flutter_project/pages/file_view_page/file_view_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart';

class LoggInHomePage extends StatefulWidget {
  const LoggInHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<LoggInHomePage> createState() => _LoggInHomePageState();
}

class _LoggInHomePageState extends State<LoggInHomePage> {
  final GoogleSignIn googleSignIn = GoogleSignIn(scopes: [
    DriveApi.driveScope,
    DriveApi.driveFileScope,
    DriveApi.driveReadonlyScope,
    DriveApi.driveMetadataReadonlyScope,
    DriveApi.driveAppdataScope,
    DriveApi.driveMetadataScope,
    DriveApi.drivePhotosReadonlyScope,
  ]);
  bool isInProgress = false;

  @override
  Widget build(BuildContext context) {
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
                Text(
                  isInProgress ? 'In progress' : 'Logg In with Google',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    color: Colors.white,
                  ),
                ),
                Text(
                  isInProgress
                      ? 'Logging In...'
                      : 'Please, logg in to continue',
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.white,
                  ),
                ),
                isInProgress
                    ? const CircularProgressIndicator()
                    : ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          onPrimary: Colors.black54,
                          minimumSize: const Size(200, 50),
                        ),
                        onPressed: () async {
                          setState(() {
                            isInProgress = true;
                          });
                          await googleSignIn.signIn();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FileViewPage(
                                googleSignIn: googleSignIn,
                              ),
                            ),
                          ).then(
                            (value) => setState(() {
                              isInProgress = false;
                            }),
                          );
                        },
                        icon: const FaIcon(
                          FontAwesomeIcons.google,
                          color: Colors.blue,
                        ),
                        label: Text(
                          googleSignIn.currentUser == null
                              ? 'Sign In with Google'
                              : 'Continue',
                          style: const TextStyle(
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
