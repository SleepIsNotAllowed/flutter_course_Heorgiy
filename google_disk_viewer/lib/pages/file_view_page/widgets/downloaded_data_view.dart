import 'package:firebase_flutter_project/pages/file_view_page/widgets/item_grid_tile.dart';
import 'package:firebase_flutter_project/pages/file_view_page/widgets/item_list_tile.dart';
import 'package:firebase_flutter_project/pages/file_view_page/widgets/user_greeting_view.dart';
import 'package:firebase_flutter_project/util/drive_item_data.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class DownloadedDataView extends StatefulWidget {
  final GoogleSignInAuthentication? auth;
  final GoogleSignIn googleSignIn;

  const DownloadedDataView({
    Key? key,
    required this.auth,
    required this.googleSignIn,
  }) : super(key: key);

  @override
  State<DownloadedDataView> createState() => _DownloadedDataViewState();
}

class _DownloadedDataViewState extends State<DownloadedDataView> {
  GoogleSignInAuthentication? auth;
  DriveItemData? selectedItem;
  List<DriveItemData> itemsData = [];
  bool isGridView = true;
  final IconData listIcon = Icons.grid_view_rounded;
  final IconData gridIcon = Icons.list_rounded;

  @override
  void initState() {
    auth = widget.auth;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return itemsData.isEmpty
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
        : _buildDataView();
  }

  Widget _buildDataView() {
    return GestureDetector(
      onTap: () => setState(() {
        selectedItem = null;
      }),
      child: Column(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey.shade500,
                  width: 2,
                ),
              ),
              color: Colors.grey.shade800,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.delete_rounded,
                        color: _isItemSelected()
                            ? Colors.transparent
                            : Colors.grey.shade400,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.cloud_download_rounded,
                        color: _isItemSelected()
                            ? Colors.transparent
                            : Colors.grey.shade400,
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      child: Text(
                        _isItemSelected() ? '' : selectedItem!.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      isGridView = !isGridView;
                    });
                  },
                  icon: Icon(
                    isGridView ? gridIcon : listIcon,
                    color: Colors.grey.shade400,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              child: isGridView ? _buildGridView() : _buildListView(),
              onRefresh: _refreshFileList,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridView() {
    List<Widget> gridItems = [];

    for (DriveItemData item in itemsData) {
      Color itemBorderColor;
      if (selectedItem != null && selectedItem!.name == item.name) {
        itemBorderColor = Colors.white;
      } else {
        itemBorderColor = Colors.grey;
      }
      gridItems.add(
        GestureDetector(
          onTap: () => _selectItem(item),
          child: ItemGridTile(
            auth: widget.auth,
            itemData: item,
            borderColor: _selectColorForItem(item),
          ),
        ),
      );
    }

    return GridView.count(
      crossAxisCount: 2,
      padding: const EdgeInsets.all(16),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      children: gridItems,
    );
  }

  Widget _buildListView() {
    List<Widget> listItems = [];

    for (DriveItemData item in itemsData) {
      listItems.add(
        GestureDetector(
          onTap: () => _selectItem(item),
          child: ItemListTile(
            auth: widget.auth,
            itemData: item,
            borderColor: _selectColorForItem(item),
          ),
        ),
      );
    }

    return ListView(
      children: listItems,
      padding: const EdgeInsets.all(16),
    );
  }

  Color _selectColorForItem(DriveItemData item) {
    Color itemBorderColor;
    if (selectedItem != null && selectedItem!.name == item.name) {
      itemBorderColor = Colors.white;
    } else {
      itemBorderColor = Colors.grey;
    }
    return itemBorderColor;
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
      headers: {'authorization': 'Bearer ${widget.auth?.accessToken}'},
    );
    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    List jsonItemsList = jsonResponse['files'];
    for (Map item in jsonItemsList) {
      itemsData.add(DriveItemData.fromJson(item));
    }
    setState(() {});
  }

  void _selectItem(DriveItemData item) {
    setState(() {
      selectedItem = item;
    });
  }

  bool _isItemSelected() {
    return selectedItem == null;
  }
}
