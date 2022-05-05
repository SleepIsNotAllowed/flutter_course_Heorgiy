import 'package:flutter/material.dart';
import 'package:online_shop_flutter_course/shop_home_page/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:online_shop_flutter_course/shop_home_page/shop_item_browsing_grid/shop_items_browsing_grid.dart';
import 'package:online_shop_flutter_course/shop_home_page/top_search_bar/top_search_bar.dart';

class ShopHomePage extends StatelessWidget {
  const ShopHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.deepPurple,
              Colors.pink,
            ],
          )
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              TopSearchBar(),
              Expanded(child: ItemsBrowsingGrid()),
            ],
          ),
          bottomNavigationBar: BottomBar(),
        ),
      ),
    );
  }
}
