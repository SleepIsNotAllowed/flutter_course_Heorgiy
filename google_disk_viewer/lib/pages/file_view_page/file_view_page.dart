import 'package:firebase_flutter_project/pages/file_view_page/widgets/downloaded_data_view.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FileViewPage extends StatelessWidget {
  final GoogleSignIn googleSignIn;
  final GoogleSignInAuthentication? auth;

  const FileViewPage({
    Key? key,
    required this.googleSignIn,
    required this.auth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GoogleSignInAccount user = googleSignIn.currentUser!;

    return Scaffold(
      backgroundColor: Colors.grey.shade700,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        leading: Container(
          width: 30,
          height: 30,
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(user.photoUrl!),
            ),
            border: Border.all(color: Colors.grey),
          ),
        ),
        title: Text(
          user.displayName!,
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              googleSignIn.signOut().then((value) => Navigator.pop(context));
            },
            icon: Icon(
              Icons.exit_to_app_rounded,
              color: Colors.grey.shade400,
            ),
            tooltip: "Logg out",
          ),
        ],
      ),
      body: DownloadedDataView(
        auth: auth,
        googleSignIn: googleSignIn,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.grey,
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 42,
        ),
      ),
    );
  }
}
