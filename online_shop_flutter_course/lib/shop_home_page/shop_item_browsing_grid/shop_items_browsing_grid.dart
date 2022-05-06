import 'package:flutter/material.dart';
import 'package:online_shop_flutter_course/shop_home_page/shop_item_browsing_grid/grid_components/grid_item.dart';

class ItemsBrowsingGrid extends StatelessWidget {
  ItemsBrowsingGrid({Key? key}) : super(key: key);

  final List names = [
    "Mens Citizen Navihawk AT Alarm Chronograph Radio Controlled Eco-Drive Watch",
    "Mens Citizen Endeavour Watch",
    "Polar Ignite 2 Fitness Smartwatch",
    "Polar Unite Fitness Smartwatch",
    "Polar Vantage M2 Running Smartwatch",
    "Gents Tommy Hilfiger Cooper Watch 1791513",
    "Gents Jack Wills Overland Watch JW012TNS",
    "Slipstream Aero Chronograph SL107521",
    "Armani Exchange Watch AX1335",
  ];

  final images = List.generate(
    9,
    (i) => 'assets/shop_items_images/image$i.jpg',
  );

  final List prices = [100, 150, 200, 100, 70, 300, 120, 130, 350];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white70,
      child: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        childAspectRatio: 0.6,
        padding: const EdgeInsets.symmetric(horizontal: 5),
        children: List.generate(
          9,
          (i) => GridItem(
              imageDirectory: images[i], itemName: names[i], price: prices[i]),
        ),
      ),
    );
  }
}
