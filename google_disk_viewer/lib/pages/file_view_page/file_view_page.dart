import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_flutter_project/pages/file_view_page/widgets/downloaded_data_view.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

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
        onPressed: _uploadFile,
        backgroundColor: Colors.grey,
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 42,
        ),
      ),
    );
  }

  Future<void> _uploadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      dialogTitle: 'Choose one file',
    );
    if (result == null) {
      return;
    }

    final file = File(result.paths.first!);
    final fileLength = file.lengthSync().toString();
    String sessionUri;

    Uri uri = Uri.parse(
        'https://www.googleapis.com/upload/drive/v3/files?uploadType=resumable');
    String body = json.encode({'name': result.names.first});

    final initialStreamedRequest = http.StreamedRequest('POST', uri)
      ..headers.addAll({
        'Authorization': 'Bearer ${auth?.accessToken}',
        'Content-Length': utf8.encode(body).length.toString(),
        'Content-Type': 'application/json; charset=UTF-8',
        'X-Upload-Content-Length': fileLength
      });

    initialStreamedRequest.sink.add(utf8.encode(body));
    initialStreamedRequest.sink.close();
    http.StreamedResponse response = await initialStreamedRequest.send();

    sessionUri = response.headers['location']!;
    Uri sessionURI = Uri.parse(sessionUri);
    final fileStreamedRequest = http.StreamedRequest('PUT', sessionURI)
      ..headers.addAll({
        'Content-Length': fileLength,
      });

    fileStreamedRequest.sink.add(file.readAsBytesSync());
    fileStreamedRequest.sink.close();
    await fileStreamedRequest.send();
  }
}
