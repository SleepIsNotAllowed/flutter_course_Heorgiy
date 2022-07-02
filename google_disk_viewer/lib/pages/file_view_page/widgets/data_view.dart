import 'dart:io';

import 'package:firebase_flutter_project/pages/file_view_page/widgets/item_grid_tile.dart';
import 'package:firebase_flutter_project/pages/file_view_page/widgets/item_list_tile.dart';
import 'package:firebase_flutter_project/util/colors.dart';
import 'package:firebase_flutter_project/util/drive_item_data.dart';
import 'package:firebase_flutter_project/util/file_view_data.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class DataView extends StatelessWidget {
  final FileViewData data;
  final VoidCallback setState;
  final Future<void> Function() refreshFileList;
  final IconData listIcon = Icons.grid_view_rounded;
  final IconData gridIcon = Icons.list_rounded;

  const DataView({
    Key? key,
    required this.data,
    required this.setState,
    required this.refreshFileList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        data.selectedItem = null;
        setState();
      },
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
              color: AppColors.backgroundSecondary,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                data.isOnDownload
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: SizedBox(
                          width: 250,
                          child: Column(
                            children: [
                              const LinearProgressIndicator(),
                              Text(
                                'Downloading...',
                                style: TextStyle(
                                  color: Colors.grey.shade400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            onPressed: _isItemSelected()
                                ? () => _deleteSelectedFile()
                                : null,
                            icon: Icon(
                              Icons.delete_rounded,
                              color: _isItemSelected()
                                  ? AppColors.iconsMain
                                  : Colors.transparent,
                            ),
                          ),
                          IconButton(
                            onPressed: _isItemSelected()
                                ? () => _downloadSelectedFile()
                                : null,
                            icon: Icon(
                              Icons.download_rounded,
                              color: _isItemSelected()
                                  ? AppColors.iconsMain
                                  : Colors.transparent,
                            ),
                          ),
                          SizedBox(
                            width: 150,
                            child: Text(
                              _isItemSelected() ? data.selectedItem!.name : '',
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
                    data.isGridView = !data.isGridView;
                    setState();
                  },
                  icon: Icon(
                    data.isGridView ? gridIcon : listIcon,
                    color: AppColors.iconsMain,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              child: data.isGridView ? _buildGridView() : _buildListView(),
              onRefresh: refreshFileList,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridView() {
    List<Widget> gridItems = [];

    for (DriveItemData item in data.itemsData) {
      gridItems.add(
        GestureDetector(
          onTap: () {
            data.selectedItem = item;
            setState();
          },
          child: ItemGridTile(
            auth: data.auth,
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

    for (DriveItemData item in data.itemsData) {
      listItems.add(
        GestureDetector(
          onTap: () {
            data.selectedItem = item;
            setState();
          },
          child: ItemListTile(
            auth: data.auth,
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
    if (data.selectedItem != null && data.selectedItem!.name == item.name) {
      itemBorderColor = Colors.white;
    } else {
      itemBorderColor = Colors.grey;
    }
    return itemBorderColor;
  }

  bool _isItemSelected() {
    return data.selectedItem != null;
  }

  Future<void> _deleteSelectedFile() async {
    String fileId = data.selectedItem!.id;
    data.selectedItem = null;
    setState();

    await http.delete(
      Uri.https(
        'www.googleapis.com',
        '/drive/v3/files/' + fileId,
      ),
      headers: {'authorization': 'Bearer ${data.auth?.accessToken}'},
    );

    refreshFileList();
  }

  Future<void> _downloadSelectedFile() async {
    String fileId = data.selectedItem!.id;
    String name = data.selectedItem!.name;

    data.selectedItem = null;
    data.isOnDownload = true;
    setState();

    await Permission.storage.request();
    if (data.downloadPath == null) await _defineDownloadPath();
    File file = File('${data.downloadPath}/$name');

    Uri url = Uri.parse(
      'https://www.googleapis.com/drive/v3/files/$fileId?alt=media',
    );
    final http.Response response = await http.Client().get(
      url,
      headers: {'authorization': 'Bearer ${data.auth?.accessToken}'},
    );
    await file.writeAsBytes(response.bodyBytes);

    data.isOnDownload = false;
    setState();
  }

  Future<void> _defineDownloadPath() async {
    Directory? externalStorage = await getExternalStorageDirectory();
    Directory appStorage = await getApplicationDocumentsDirectory();
    data.downloadPath =
        externalStorage == null ? appStorage.path : externalStorage.path;
  }
}
