import 'package:flutter/material.dart';
import 'package:online_shop_flutter_course/pages/shopping_cart_page/widgets/in_cart_items_grid/in_cart_browsing_grid.dart';
import 'package:online_shop_flutter_course/util/shop_data_management/grid_item_data_holder.dart';
import 'package:online_shop_flutter_course/util/shop_data_management/data_manager.dart';

class ShoppingCartPage extends StatefulWidget {
  final List<GridItemDataHolder> itemsData;
  final DataManager dataManager;

  const ShoppingCartPage({
    Key? key,
    required this.itemsData,
    required this.dataManager,
  }) : super(key: key);

  @override
  State<ShoppingCartPage> createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  @override
  Widget build(BuildContext context) {
    var totalCost = widget.dataManager.totalPriceCount;

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
        title: Text(
          'Total cost: $totalCost',
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  widget.dataManager.totalPriceCount = 0;
                  for (GridItemDataHolder itemData in widget.itemsData) {
                    itemData.numberOfPurchased = 0;
                  }
                });
              },
              child: const Text(
                " Buy All ",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
              ),
            ),
          ),
        ],
      ),
      body: InCartBrowsingGrid(
        parentSetState: () => setState(() {}),
        itemsData: widget.itemsData,
        dataManager: widget.dataManager,
      ),
    );
  }
}
