import 'package:firebase_flutter_project/util/drive_item_data.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class DownloadedDataView extends StatefulWidget {
  final List<DriveItemData> itemsData;
  final GoogleSignInAuthentication? auth;

  const DownloadedDataView({
    Key? key,
    required this.itemsData,
    required this.auth,
  }) : super(key: key);

  @override
  State<DownloadedDataView> createState() => _DownloadedDataViewState();
}

class _DownloadedDataViewState extends State<DownloadedDataView> {
  IconData reservedIcon = Icons.list_rounded;
  IconData currentIcon = Icons.grid_view_rounded;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey.shade500,
                width: 2,
              ),
            ),
            color: Colors.grey.shade700,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () => setState(() {
                  IconData holder = currentIcon;
                  currentIcon = reservedIcon;
                  reservedIcon = holder;
                }),
                icon: Icon(
                  currentIcon,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            child: GridView.count(
              crossAxisCount: 3,
              padding: const EdgeInsets.all(8),
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              children: _buildGridItems(),
            ),
            onRefresh: refreshFileList,
          ),
        ),
      ],
    );
  }

  List<Widget> _buildGridItems() {
    List<Widget> gridItems = [];

    for (DriveItemData item in widget.itemsData) {
      gridItems.add(GridTile(
        child: Image(
          image: NetworkImage(item.iconLink),
          fit: BoxFit.cover,
        ),
        footer: GridTileBar(
          backgroundColor: Colors.grey.shade700,
          trailing: Image.network(item.iconLink),
          title: Text(item.name, overflow: TextOverflow.ellipsis),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'size: ' + item.size,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
              ),
              Text(
                'date: ' + item.createdTime,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ),
      ));
    }

    return gridItems;
  }

  Future<void> refreshFileList() async {
    widget.itemsData.clear();
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
      widget.itemsData.add(DriveItemData.fromJson(item));
    }
    setState(() {});
  }
}
