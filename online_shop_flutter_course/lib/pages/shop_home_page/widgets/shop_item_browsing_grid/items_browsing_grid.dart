import 'package:flutter/material.dart';
import 'package:online_shop_flutter_course/util/shop_data_management/data_manager.dart';

import 'grid_components/grid_item.dart';

class ItemsBrowsingGrid extends StatelessWidget {
  final DataManager dataManager;

  const ItemsBrowsingGrid({
    Key? key,
    required this.dataManager,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: GridView.count(
        addAutomaticKeepAlives: true,
        crossAxisCount: 2,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        childAspectRatio: 0.6,
        padding: const EdgeInsets.symmetric(horizontal: 5),
        children: _buildGridItems(dataManager.searched),
      ),
    );
  }

  List<GridItem> _buildGridItems(String searched) {
    List<GridItem> itemsList = [];

    if (searched.isEmpty) {
      itemsList = dataManager.itemsList;
    } else {
      for (int i = 0; i < dataManager.itemsList.length; i++) {
        String currentName = dataManager.itemsList[i].dataHolder.name;
        if (currentName.toLowerCase().contains(searched.toLowerCase())) {
          itemsList.add(dataManager.itemsList[i]);
        }
      }
    }

    return itemsList;
  }
}
