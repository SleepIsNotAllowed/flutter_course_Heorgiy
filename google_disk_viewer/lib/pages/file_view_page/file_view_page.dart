import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_flutter_project/pages/file_view_page/widgets/data_view.dart';
import 'package:firebase_flutter_project/pages/file_view_page/widgets/user_greeting_view.dart';
import 'package:firebase_flutter_project/util/colors.dart';
import 'package:firebase_flutter_project/util/drive_item_data.dart';
import 'package:firebase_flutter_project/util/file_view_data.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class FileViewPage extends StatefulWidget {
  final GoogleSignIn googleSignIn;

  const FileViewPage({
    Key? key,
    required this.googleSignIn,
  }) : super(key: key);

  @override
  State<FileViewPage> createState() => _FileViewPageState();
}

class _FileViewPageState extends State<FileViewPage> {
  FileViewData data = FileViewData();

  @override
  Widget build(BuildContext context) {
    final GoogleSignInAccount user = widget.googleSignIn.currentUser!;

    return Scaffold(
      backgroundColor: AppColors.backgroundMain,
      appBar: AppBar(
        backgroundColor: AppColors.appBarMain,
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
            onPressed: () async {
              await widget.googleSignIn.signOut();
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.exit_to_app_rounded,
              color: AppColors.iconsMain,
            ),
            tooltip: "Logg out",
          ),
        ],
      ),
      body: data.itemsData.isEmpty
          ? FutureBuilder(
              future: _fetchFileList(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return _buildDataView();
                } else {
                  return UserGreetingView(
                    googleSignIn: widget.googleSignIn,
                  );
                }
              },
            )
          : _buildDataView(),
      floatingActionButton: FloatingActionButton(
        onPressed: data.isUploading ? null : _uploadFile,
        backgroundColor: Colors.grey,
        child: data.isUploading
            ? const CircularProgressIndicator()
            : const Icon(
                Icons.add,
                color: Colors.white,
                size: 42,
              ),
      ),
    );
  }

  Future<void> _fetchFileList() async {
    data.auth = await widget.googleSignIn.currentUser?.authentication;
    var response = await http.get(
      Uri.https(
        'www.googleapis.com',
        '/drive/v3/files',
        {'fields': 'files(id,iconLink,name,createdTime,size,thumbnailLink)'},
      ),
      headers: {'authorization': 'Bearer ${data.auth?.accessToken}'},
    );

    List jsonItemsList =
        (convert.jsonDecode(response.body) as Map<String, dynamic>)['files'];
    for (Map item in jsonItemsList) {
      data.itemsData.add(DriveItemData.fromJson(item));
    }
  }

  Future<void> _refreshFileList() async {
    List<DriveItemData> newItemsData = [];

    if (widget.googleSignIn.currentUser == null) {
      await widget.googleSignIn.signInSilently(reAuthenticate: true);
      data.auth = await widget.googleSignIn.currentUser?.authentication;
    }

    var response = await http.get(
      Uri.https(
        'www.googleapis.com',
        '/drive/v3/files',
        {'fields': 'files(id,iconLink,name,createdTime,size,thumbnailLink)'},
      ),
      headers: {'authorization': 'Bearer ${data.auth?.accessToken}'},
    );

    List jsonItemsList =
        (convert.jsonDecode(response.body) as Map<String, dynamic>)['files'];
    for (Map item in jsonItemsList) {
      DriveItemData? oldItem = _findAlreadyCreatedItem(item);
      if (oldItem != null) {
        newItemsData.add(oldItem);
      } else {
        newItemsData.add(DriveItemData.fromJson(item));
      }
    }

    setState(() {
      data.itemsData = newItemsData;
    });
  }

  DriveItemData? _findAlreadyCreatedItem(Map item) {
    for (DriveItemData itemData in data.itemsData) {
      if (itemData.id == item['id']) {
        return itemData;
      }
    }

    return null;
  }

  Widget _buildDataView() {
    return DataView(
      data: data,
      setState: () => setState(() {}),
      googleSignIn: widget.googleSignIn,
      refreshFileList: _refreshFileList,
    );
  }

  Future<void> _uploadFile() async {
    setState(() {
      data.isUploading = true;
    });

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      dialogTitle: 'Choose one file',
    );
    if (result == null) {
      setState(() {
        data.isUploading = false;
      });
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
        'Authorization': 'Bearer ${data.auth?.accessToken}',
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

    data.isUploading = false;
    _refreshFileList();
  }
}
