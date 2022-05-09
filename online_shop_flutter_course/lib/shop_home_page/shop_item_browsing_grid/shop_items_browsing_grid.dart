import 'package:flutter/material.dart';
import 'package:online_shop_flutter_course/shop_data_manager/shop_data_manager.dart';
import 'package:online_shop_flutter_course/shop_item_list/shop_item_list.dart';

import 'grid_components/grid_item.dart';

class ItemsBrowsingGrid extends StatefulWidget {
  final Function parentSetState;
  final ShopItemsList itemsList;

  const ItemsBrowsingGrid(
      {Key? key, required this.parentSetState, required this.itemsList})
      : super(key: key);

  @override
  State<ItemsBrowsingGrid> createState() => _ItemsBrowsingGridState();
}

class _ItemsBrowsingGridState extends State<ItemsBrowsingGrid> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          childAspectRatio: 0.6,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          children: buildGridItems(DataManager.searched)),
    );
  }

  List<GridItem> buildGridItems(String searched) {
    List<GridItem> listItems = [];

    if (searched.isEmpty) {
      listItems = widget.itemsList.getFullItemsList();
    } else {
      for (int i = 0; i < ShopItemsList.names.length; i++) {
        String currentName = ShopItemsList.names[i];
        if (currentName.contains(searched)) {
          listItems.add(widget.itemsList.itemsList[i]);
        }
      }
    }

    return listItems;
  }
}
