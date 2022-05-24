import 'package:flutter/material.dart';
import 'package:online_shop_flutter_course/pages/item_full_view_page/item_full_view_page.dart';
import 'package:online_shop_flutter_course/util/shop_data_management/grid_item_data_holder.dart';
import 'package:online_shop_flutter_course/util/shop_data_management/data_manager.dart';

class GridItem extends StatelessWidget {
  final VoidCallback parentSetState;
  final GridItemDataHolder dataHolder;
  final DataManager dataManager;

  const GridItem(
      {Key? key,
      required this.parentSetState,
      required this.dataHolder,
      required this.dataManager})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (dataManager.totalPriceCount == 0) {
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
            _buildShortItemView(context),
            const Divider(height: 2, thickness: 1),
            _buildButtonRow(),
          ],
        ),
      ),
    );
  }

  Widget _buildShortItemView(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ItemFullViewPage(
                dataHolder: dataHolder,
                dataManager: dataManager,
              ),
            ),
          ).then((value) => parentSetState());
        },
        child: Column(
          children: [
            Expanded(
              child: Image.asset(dataHolder.imageDirectory, fit: BoxFit.cover),
            ),
            Text(
              dataHolder.name,
              style: const TextStyle(color: Colors.black54),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                dataHolder.price.toString() + ' usd',
                style: const TextStyle(color: Colors.green, fontSize: 18),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
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
            dataManager.totalPriceCount += dataHolder.price;
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
              dataManager.totalPriceCount -= dataHolder.price;
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
            dataHolder.isFavorite
                ? Icons.favorite
                : Icons.favorite_border,
            color: dataHolder.isFavorite ? Colors.orange : Colors.grey,
          ),
        ),
      ],
    );
  }
}
