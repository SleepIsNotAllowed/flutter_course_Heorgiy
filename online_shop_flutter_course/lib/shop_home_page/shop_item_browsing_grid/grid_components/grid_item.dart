import 'package:flutter/material.dart';
import 'package:online_shop_flutter_course/shop_data_management/grid_item_data_holder.dart';
import 'package:online_shop_flutter_course/shop_data_management/shop_data_manager.dart';

class GridItem extends StatelessWidget {
  final String imageDirectory;
  final String itemName;
  final int price;
  final Function parentSetState;
  final GridItemDataHolder dataHolder;

  const GridItem(
      {Key? key,
      required this.imageDirectory,
      required this.itemName,
      required this.price,
      required this.parentSetState,
      required this.dataHolder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (DataManager.totalPriceCount == 0) {
      dataHolder.numberOfPurchased = 0;
    }

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: dataHolder.numberOfPurchased > 0
              ? Colors.deepPurple
              : Colors.transparent,
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
              child: Image.asset(imageDirectory, fit: BoxFit.cover),
            ),
            Text(
              itemName,
              style: const TextStyle(color: Colors.black54),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                price.toString() + ' usd',
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
            dataHolder.numberOfPurchased++;
            DataManager.totalPriceCount += price;
            parentSetState();
          },
          child: const Text(
            "   Buy   ",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.green),
          ),
        ),
        GestureDetector(
          onTap: () {
            if (dataHolder.numberOfPurchased > 0) {
              dataHolder.numberOfPurchased--;
              DataManager.totalPriceCount -= price;
              parentSetState();
            }
          },
          child: Text(
            dataHolder.numberOfPurchased.toString(),
            style: TextStyle(
                color: dataHolder.numberOfPurchased > 0
                    ? Colors.black54
                    : Colors.transparent),
          ),
        ),
        IconButton(
            onPressed: () {
              dataHolder.isFavorite = !dataHolder.isFavorite;
              parentSetState();
            },
            icon: Icon(
              dataHolder.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: dataHolder.isFavorite ? Colors.orange : Colors.grey,
            )),
      ],
    );
  }
}
