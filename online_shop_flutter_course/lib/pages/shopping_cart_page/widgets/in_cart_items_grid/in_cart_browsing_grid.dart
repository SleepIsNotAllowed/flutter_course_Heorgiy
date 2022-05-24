import 'package:flutter/material.dart';
import 'package:online_shop_flutter_course/pages/shopping_cart_page/widgets/in_cart_items_grid/in_cart_grid_item.dart';
import 'package:online_shop_flutter_course/util/shop_data_management/grid_item_data_holder.dart';
import 'package:online_shop_flutter_course/util/shop_data_management/data_manager.dart';

class InCartBrowsingGrid extends StatelessWidget {
  final VoidCallback parentSetState;
  final List<GridItemDataHolder> itemsData;
  final DataManager dataManager;

  const InCartBrowsingGrid({
    Key? key,
    required this.parentSetState,
    required this.itemsData,
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
        children: _buildItemsGrid(),
      ),
    );
  }

  List<InCartGridItem> _buildItemsGrid() {
    List<InCartGridItem> chosenItems = [];

    for (int i = 0; i < itemsData.length; i++) {
      GridItemDataHolder currentItemData = itemsData[i];
      if (currentItemData.numberOfPurchased > 0) {
        chosenItems.add(
          InCartGridItem(
            parentSetState: parentSetState,
            dataHolder: currentItemData,
            dataManager: dataManager,
          ),
        );
      }
    }

    return chosenItems;
  }
}
