import 'package:flutter/material.dart';

class ShoppingBasket extends StatefulWidget {
  const ShoppingBasket({Key? key}) : super(key: key);

  @override
  State<ShoppingBasket> createState() => _ShoppingBasketState();
}

class _ShoppingBasketState extends State<ShoppingBasket> {
  int currentTotalPrice = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      child: Column(
        children: [
          const Icon(
            Icons.shopping_cart_outlined,
            color: Colors.white,
          ),
          Text(
            currentTotalPrice.toString(),
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
