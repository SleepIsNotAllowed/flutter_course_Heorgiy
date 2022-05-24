import 'package:flutter/material.dart';
import 'package:online_shop_flutter_course/pages/shopping_cart_page/shopping_cart_page.dart';
import 'package:online_shop_flutter_course/util/shop_data_management/grid_item_data_holder.dart';

import 'package:online_shop_flutter_course/util/shop_data_management/data_manager.dart';

class ShoppingCart extends StatelessWidget {
  final DataManager dataManager;
  final VoidCallback parentSetState;
  final List<GridItemDataHolder> itemsData;

  const ShoppingCart({
    Key? key,
    required this.parentSetState,
    required this.dataManager,
    required this.itemsData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      child: _buildIconWithTotalPrice(context),
    );
  }

  Widget _buildIconWithTotalPrice(BuildContext context) {
    return dataManager.totalPriceCount > 0
        ? Column(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShoppingCartPage(
                        itemsData: itemsData,
                        dataManager: dataManager,
                      ),
                    ),
                  ).then((value) => parentSetState());
                },
                alignment: Alignment.center,
                padding: const EdgeInsets.all(0),
                visualDensity: const VisualDensity(vertical: -4),
                icon: const Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.white,
                ),
              ),
              Text(
                dataManager.totalPriceCount.toString(),
                style: TextStyle(
                  color: dataManager.totalPriceCount > 0
                      ? Colors.white
                      : Colors.transparent,
                ),
              ),
            ],
          )
        : IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShoppingCartPage(
                    itemsData: itemsData,
                    dataManager: dataManager,
                  ),
                ),
              ).then((value) => parentSetState());
            },
            alignment: Alignment.center,
            padding: const EdgeInsets.all(0),
            visualDensity: const VisualDensity(vertical: -4),
            icon: const Icon(
              Icons.shopping_cart_outlined,
              color: Colors.white,
            ),
          );
  }
}
