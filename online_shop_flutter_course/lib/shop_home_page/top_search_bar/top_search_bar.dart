import 'package:flutter/material.dart';
import 'package:online_shop_flutter_course/shop_home_page/top_search_bar/search_bar_components/search_field.dart';
import 'package:online_shop_flutter_course/shop_home_page/top_search_bar/search_bar_components/shopping_cart.dart';

class TopSearchBar extends StatefulWidget {
  final Function parentSetState;

  const TopSearchBar({Key? key, required this.parentSetState})
      : super(key: key);

  @override
  State<TopSearchBar> createState() => _TopSearchBarState();
}

class _TopSearchBarState extends State<TopSearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      color: Colors.transparent,
      padding: const EdgeInsets.fromLTRB(15, 10, 5, 5),
      child: Row(
        children: [
          Expanded(
            child: SearchField(
                parentSetState: widget.parentSetState),
          ),
          ShoppingCart(
              parentSetState: widget.parentSetState),
        ],
      ),
    );
  }
}
