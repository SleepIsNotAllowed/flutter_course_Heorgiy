import 'package:firebase_flutter_project/pages/file_view_page/widgets/downloaded_data_view.dart';
import 'package:firebase_flutter_project/pages/file_view_page/widgets/user_greeting_view.dart';
import 'package:firebase_flutter_project/pages/logg_in_home_page/logg_in_home_page.dart';
import 'package:firebase_flutter_project/util/drive_item_data.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class FileViewPage extends StatefulWidget {
  final GoogleSignIn googleSignIn;
  final bool isGridView;
  final GoogleSignInAuthentication? auth;
  final List<DriveItemData>? itemsData;

  const FileViewPage({
    Key? key,
    required this.googleSignIn,
    required this.isGridView,
    this.itemsData,
    required this.auth,
  }) : super(key: key);

  @override
  State<FileViewPage> createState() => _FileViewPageState();
}

class _FileViewPageState extends State<FileViewPage> {
  GoogleSignInAuthentication? auth;
  late List<DriveItemData> itemsData;

  @override
  void initState() {
    auth = widget.auth;
    itemsData = widget.itemsData == null ? [] : widget.itemsData!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final GoogleSignInAccount user = widget.googleSignIn.currentUser!;

    return Scaffold(
      backgroundColor: Colors.grey.shade700,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        leading: Container(
          width: 30,
          height: 30,
          margin: const EdgeInsets.all(8),
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
              widget.googleSignIn.signOut().then(
                    (value) => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoggInHomePage(),
                      ),
                    ),
                  );
            },
            icon: Icon(
              Icons.exit_to_app_rounded,
              color: Colors.grey.shade400,
            ),
            tooltip: "Logg out",
          ),
        ],
      ),
      body: itemsData.isEmpty
          ? FutureBuilder(
              future: _fetchFileList(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return DownloadedDataView(
                    itemsData: itemsData,
                    auth: auth,
                    isGridView: widget.isGridView,
                    googleSignIn: widget.googleSignIn,
                    refreshFileList: _refreshFileList,
                  );
                } else {
                  return UserGreetingView(
                    googleSignIn: widget.googleSignIn,
                  );
                }
              },
            )
          : DownloadedDataView(
              itemsData: itemsData,
              auth: auth,
              isGridView: widget.isGridView,
              googleSignIn: widget.googleSignIn,
              refreshFileList: _refreshFileList,
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

  Future<void> _fetchFileList() async {
    itemsData = [];
    var response = await http.get(
      Uri.https(
        'www.googleapis.com',
        '/drive/v3/files',
        {'fields': 'files(id,iconLink,name,createdTime,size,thumbnailLink)'},
      ),
      headers: {'authorization': 'Bearer ${auth?.accessToken}'},
    );
    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    List jsonItemsList = jsonResponse['files'];
    for (Map item in jsonItemsList) {
      itemsData.add(DriveItemData.fromJson(item));
    }
  }

  Future<void> _refreshFileList() async {
    if (widget.googleSignIn.currentUser == null) {
      GoogleSignInAccount? user = await widget.googleSignIn.signIn();
      auth = await user?.authentication;
    }
    itemsData.clear();
    var response = await http.get(
      Uri.https(
        'www.googleapis.com',
        '/drive/v3/files',
        {'fields': 'files(id,iconLink,name,createdTime,size,thumbnailLink)'},
      ),
      headers: {'authorization': 'Bearer ${auth?.accessToken}'},
    );
    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    List jsonItemsList = jsonResponse['files'];
    for (Map item in jsonItemsList) {
      itemsData.add(DriveItemData.fromJson(item));
    }
    setState(() {});
  }
}
