import 'package:firebase_flutter_project/pages/file_view_page/file_view_page.dart';
import 'package:firebase_flutter_project/pages/file_view_page/widgets/item_grid_tile.dart';
import 'package:firebase_flutter_project/pages/file_view_page/widgets/item_list_tile.dart';
import 'package:firebase_flutter_project/util/drive_item_data.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class DownloadedDataView extends StatelessWidget {
  final List<DriveItemData> itemsData;
  final GoogleSignInAuthentication? auth;
  final bool isGridView;
  final GoogleSignIn googleSignIn;
  final VoidCallback refreshFileList;

  const DownloadedDataView({
    Key? key,
    required this.itemsData,
    required this.auth,
    required this.isGridView,
    required this.googleSignIn,
    required this.refreshFileList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    IconData listIcon = Icons.grid_view_rounded;
    IconData gridIcon = Icons.list_rounded;

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
            color: Colors.grey.shade800,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: null,
                    icon: Icon(
                      Icons.delete_rounded,
                      color: Colors.grey.shade400,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.cloud_download_rounded,
                      color: Colors.grey.shade400,
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FileViewPage(
                        googleSignIn: googleSignIn,
                        isGridView: !isGridView,
                        auth: auth,
                        itemsData: itemsData,
                      ),
                    ),
                  );
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
            onRefresh: _refresh,
          ),
        ),
      ],
    );
  }

  Widget _buildGridView() {
    List<Widget> gridItems = [];

    for (DriveItemData item in itemsData) {
      gridItems.add(
        Hero(
          tag: item.id,
          child: ItemGridTile(
            auth: auth,
            itemData: item,
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
        Hero(
          tag: item.id,
          child: ItemListTile(
            auth: auth,
            itemData: item,
          ),
        ),
      );
    }

    return ListView(
      children: listItems,
      padding: const EdgeInsets.all(16),
    );
  }

  Future<void> _refresh() async {
    refreshFileList();
  }
}
