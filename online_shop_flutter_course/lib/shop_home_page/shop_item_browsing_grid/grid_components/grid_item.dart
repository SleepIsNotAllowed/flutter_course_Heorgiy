import 'package:flutter/material.dart';
import 'package:online_shop_flutter_course/shop_data_manager/shop_data_manager.dart';
import 'package:online_shop_flutter_course/shop_home_page/top_search_bar/search_bar_components/shopping_cart.dart';

class GridItem extends StatefulWidget {
  final String imageDirectory;
  final String itemName;
  final int price;
  final Function parentSetState;

  const GridItem(
      {Key? key,
      required this.imageDirectory,
      required this.itemName,
      required this.price,
      required this.parentSetState})
      : super(key: key);

  @override
  State<GridItem> createState() => GridItemState();
}

class GridItemState extends State<GridItem> {
  bool forPurchase = false;
  bool isFavorite = false;
  int numberOfPurchased = 0;

  @override
  Widget build(BuildContext context) {
    if(DataManager.totalPriceCount == 0) {
      forPurchase = false;
      numberOfPurchased = 0;
    }

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: forPurchase ? Colors.deepPurple : Colors.transparent,
          width: 2,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Image.asset(widget.imageDirectory, fit: BoxFit.cover),
            ),
            Text(
              widget.itemName,
              style: const TextStyle(color: Colors.black54),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.price.toString() + ' usd',
                style: const TextStyle(color: Colors.green, fontSize: 18),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            const Divider(height: 2, thickness: 1),
            _buildButtonRow(),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              numberOfPurchased++;
              forPurchase = true;
              DataManager.totalPriceCount += widget.price;
              widget.parentSetState();
            });
          },
          child: const Text(
            "   Buy   ",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.green),
          ),
        ),
        Text(
          numberOfPurchased.toString(),
          style: TextStyle(
              color:
                  numberOfPurchased > 0 ? Colors.black54 : Colors.transparent),
        ),
        IconButton(
            onPressed: () {
              setState(() {
                isFavorite = !isFavorite;
              });
            },
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.orange : Colors.grey,
            )),
      ],
    );
  }
}
