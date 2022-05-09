import 'package:flutter/material.dart';
import 'package:online_shop_flutter_course/shop_data_management/shop_data_manager.dart';

class ShoppingCart extends StatefulWidget {
  final Function parentSetState;

  const ShoppingCart({Key? key, required this.parentSetState})
      : super(key: key);

  @override
  State<ShoppingCart> createState() => ShoppingCartState();
}

class ShoppingCartState extends State<ShoppingCart> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      child: buildCartIcon(),
    );
  }

  Widget buildCartIcon() {
    return Column(
      children: [
        IconButton(
          onPressed: () {
            DataManager.totalPriceCount = 0;
            widget.parentSetState();
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
          DataManager.totalPriceCount.toString(),
          style: TextStyle(
            color: DataManager.totalPriceCount > 0
                ? Colors.white
                : Colors.transparent,
          ),
        ),
      ],
    );
  }
}
