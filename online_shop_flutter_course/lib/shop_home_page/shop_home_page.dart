import 'package:flutter/material.dart';
import 'package:online_shop_flutter_course/shop_home_page/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:online_shop_flutter_course/shop_home_page/shop_item_browsing_grid/grid_components/grid_item.dart';
import 'package:online_shop_flutter_course/shop_home_page/shop_item_browsing_grid/shop_items_browsing_grid.dart';
import 'package:online_shop_flutter_course/shop_home_page/top_app_bar/app_bar_components/search_field.dart';
import 'package:online_shop_flutter_course/shop_home_page/top_app_bar/app_bar_components/shopping_cart.dart';
import 'package:online_shop_flutter_course/util/shop_data_management/shop_data_manager.dart';

import '../util/shop_data_management/grid_item_data_holder.dart';
import '../util/shop_item_list/shop_items_predefined_data.dart';

class ShopHomePage extends StatefulWidget {
  final DataManager dataManager;

  const ShopHomePage({Key? key, required this.dataManager}) : super(key: key);

  @override
  State<ShopHomePage> createState() => _ShopHomePageState();
}

class _ShopHomePageState extends State<ShopHomePage> {
  late List<GridItemDataHolder> itemsData = [];
  late List<GridItem> itemsList;

  @override
  void initState() {
    for (int i = 0; i < ShopItemsList.length; i++) {
      GridItemDataHolder itemData = GridItemDataHolder();
      itemData.name = ShopItemsList.names[i];
      itemData.imageDirectory = ShopItemsList.images[i];
      itemData.price = ShopItemsList.prices[i];
      itemsData.add(itemData);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    itemsList = List.generate(
      9,
      (i) => GridItem(
        parentSetState: () => setState(() {}),
        dataHolder: itemsData[i],
        dataManager: widget.dataManager,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.deepPurple, Colors.pink],
            ),
          ),
        ),
        title: SearchField(
          parentSetState: () => setState(() {}),
          dataManager: widget.dataManager,
        ),
        actions: [
          ShoppingCart(
            parentSetState: () => setState(() {}),
            dataManager: widget.dataManager,
            itemsData: itemsData,
          ),
        ],
      ),
      body: ItemsBrowsingGrid(
        dataManager: widget.dataManager,
        itemsList: itemsList,
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
