import 'package:flutter/material.dart';
import 'package:online_shop_flutter_course/pages/shop_home_page/widgets/top_app_bar/app_bar_components/shopping_cart.dart';
import 'package:online_shop_flutter_course/util/shop_data_management/grid_item_data_holder.dart';
import 'package:online_shop_flutter_course/util/shop_data_management/data_manager.dart';

class ItemFullViewPage extends StatefulWidget {
  final GridItemDataHolder dataHolder;
  final DataManager dataManager;

  const ItemFullViewPage({
    Key? key,
    required this.dataHolder,
    required this.dataManager,
  }) : super(key: key);

  @override
  State<ItemFullViewPage> createState() => _ItemFullViewPageState();
}

class _ItemFullViewPageState extends State<ItemFullViewPage> {
  @override
  Widget build(BuildContext context) {
    var totalCost = widget.dataManager.totalPriceCount;

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.deepPurple, Colors.pink],
            ),
          ),
        ),
        title: Text(
          'Total cost: $totalCost',
          style: const TextStyle(color: Colors.white, fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ),
      backgroundColor: Colors.grey[100],
      body: Container(
        margin: const EdgeInsets.all(24),
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                Image.asset(
                  widget.dataHolder.imageDirectory,
                  fit: BoxFit.cover,
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      widget.dataHolder.isFavorite = !widget.dataHolder.isFavorite;
                    });
                  },
                  icon: Icon(
                    widget.dataHolder.isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: widget.dataHolder.isFavorite ? Colors.orange : Colors.grey,
                  ),
                ),
              ],
            ),
            Text(
              widget.dataHolder.name,
              style: const TextStyle(color: Colors.black54, fontSize: 20),
              overflow: TextOverflow.ellipsis,
              maxLines: 4,
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Price: ' + widget.dataHolder.price.toString() + ' usd',
                  style: const TextStyle(color: Colors.green, fontSize: 20),
                ),
                Text(
                  'Currently added: ' +
                      widget.dataHolder.numberOfPurchased.toString(),
                  style: const TextStyle(color: Colors.black54, fontSize: 20),
                  overflow: TextOverflow.visible,
                  maxLines: 2,
                ),
              ],
            ),
            const Divider(
              thickness: 2,
              color: Colors.black54,
            ),
            _buildButtonRow(),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              widget.dataHolder.numberOfPurchased++;
              widget.dataManager.totalPriceCount += widget.dataHolder.price;
            });
          },
          child: const Text(
            " Add ",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.green),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              if (widget.dataHolder.numberOfPurchased > 0) {
                widget.dataHolder.numberOfPurchased--;
                widget.dataManager.totalPriceCount -= widget.dataHolder.price;
              }
            });
          },
          child: const Text(
            " Remove ",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
                widget.dataHolder.numberOfPurchased > 0
                    ? Colors.red
                    : Colors.grey),
          ),
        ),
      ],
    );
  }
}
