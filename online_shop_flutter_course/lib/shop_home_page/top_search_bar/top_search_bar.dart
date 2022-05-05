import 'package:flutter/material.dart';
import 'package:online_shop_flutter_course/shop_home_page/top_search_bar/search_bar_components/search_field.dart';
import 'package:online_shop_flutter_course/shop_home_page/top_search_bar/search_bar_components/shopping_basket.dart';

class TopSearchBar extends StatefulWidget {
  const TopSearchBar({Key? key}) : super(key: key);

  @override
  State<TopSearchBar> createState() => _TopSearchBarState();
}

class _TopSearchBarState extends State<TopSearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: Colors.transparent,
      padding: const EdgeInsets.fromLTRB(15, 15, 10, 5),
      child: Row(
        children: [
          Expanded(
            child: SearchField(),
          ),
          ShoppingBasket(),
        ],
      ),
    );
  }
}
