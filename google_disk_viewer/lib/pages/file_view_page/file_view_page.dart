import 'dart:io';

import 'package:dio/dio.dart';
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
    print('pick file');
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      dialogTitle: 'Choose one file',
    );
    if (result == null) {
      return;
    }
    print('file picked');

    try {
      var request = http.MultipartRequest(
        "POST",
        Uri.parse(
          'https://www.googleapis.com/upload/drive/v3/files?uploadType=multipart',
        ),
      );
      print('request');
      request.headers.addAll({
        'authorization': 'Bearer ${auth?.accessToken}',
      });
      request.files.add(await http.MultipartFile.fromPath(
        'package',
        '${result.paths.first}',
        contentType: MediaType('application', 'json'), //TO DO
      ));
      request.send().then((response) async {
        print('request send');
        if (response.statusCode == 200) {
          print("Uploaded!");
        } else {
          print(response.statusCode);
          print(await response.stream.bytesToString());
        }
      });
    } catch (e) {
      print(e);
    }
  }
}
