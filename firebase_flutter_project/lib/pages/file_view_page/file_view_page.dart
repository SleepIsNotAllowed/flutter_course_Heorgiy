import 'package:firebase_flutter_project/pages/file_view_page/widgets/downloaded_data_view.dart';
import 'package:firebase_flutter_project/pages/file_view_page/widgets/user_greeting_view.dart';
import 'package:firebase_flutter_project/util/drive_item_data.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class FileViewPage extends StatefulWidget {
  final GoogleSignIn googleSignIn;
  final GoogleSignInAuthentication? auth;

  const FileViewPage({
    Key? key,
    required this.googleSignIn,
    required this.auth,
  }) : super(key: key);

  @override
  State<FileViewPage> createState() => _FileViewPageState();
}

class _FileViewPageState extends State<FileViewPage> {
  List<DriveItemData> itemsData = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
      ),
      backgroundColor: Colors.grey.shade800,
      body: FutureBuilder(
        future: fetchFileList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return DownloadedDataView(
              itemsData: itemsData,
              auth: widget.auth,
            );
          } else {
            return UserGreetingView(
              googleSignIn: widget.googleSignIn,
            );
          }
        },
      ),
    );
  }

  Future<void> fetchFileList() async {
    itemsData = [];
    var response = await http.get(
      Uri.https(
        'www.googleapis.com',
        '/drive/v3/files',
        {'fields': 'files(id,iconLink,name,createdTime,size,thumbnailLink)'},
      ),
      headers: {'authorization': 'Bearer ${widget.auth?.accessToken}'},
    );
    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    List jsonItemsList = jsonResponse['files'];
    for (Map item in jsonItemsList) {
      itemsData.add(DriveItemData.fromJson(item));
    }
  }
}
