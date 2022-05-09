import 'package:flutter/material.dart';
import 'package:online_shop_flutter_course/shop_data_management/grid_item_data_holder.dart';
import 'package:online_shop_flutter_course/shop_data_management/shop_data_manager.dart';
import 'package:online_shop_flutter_course/shop_item_list/shop_item_list.dart';

import 'grid_components/grid_item.dart';

class ItemsBrowsingGrid extends StatefulWidget {
  final Function parentSetState;

  const ItemsBrowsingGrid({
    Key? key,
    required this.parentSetState,
  }) : super(key: key);

  @override
  State<ItemsBrowsingGrid> createState() => _ItemsBrowsingGridState();
}

class _ItemsBrowsingGridState extends State<ItemsBrowsingGrid> {
  late List<GridItem> itemsList;
  late List<GridItemDataHolder> itemsData;

  @override
  void initState() {
    itemsData = List.generate(9, (index) => GridItemDataHolder());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    itemsList = List.generate(
        9,
        (i) => GridItem(
              parentSetState: widget.parentSetState,
              imageDirectory: ShopItemsList.images[i],
              itemName: ShopItemsList.names[i],
              price: ShopItemsList.prices[i],
              dataHolder: itemsData[i],
            ));

    return Container(
      color: Colors.grey[100],
      child: GridView.count(
          addAutomaticKeepAlives: true,
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
      listItems = itemsList;
    } else {
      for (int i = 0; i < ShopItemsList.names.length; i++) {
        String currentName = ShopItemsList.names[i];
        if (currentName.contains(searched)) {
          listItems.add(itemsList[i]);
        }
      }
    }

    return listItems;
  }
}
