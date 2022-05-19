import 'package:flutter/material.dart';
import 'package:online_shop_flutter_course/util/shop_data_management/grid_item_data_holder.dart';
import 'package:online_shop_flutter_course/util/shop_data_management/shop_data_manager.dart';

class ShopItemPage extends StatefulWidget {
  final GridItemDataHolder dataHolder;
  final DataManager dataManager;

  const ShopItemPage({
    Key? key,
    required this.dataHolder,
    required this.dataManager,
  }) : super(key: key);

  @override
  State<ShopItemPage> createState() => _ShopItemPageState();
}

class _ShopItemPageState extends State<ShopItemPage> {
  @override
  Widget build(BuildContext context) {
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
      ),
      backgroundColor: Colors.grey,
      body: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: widget.dataHolder.numberOfPurchased > 0
                ? Colors.deepPurple
                : Colors.transparent,
            width: 4,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(widget.dataHolder.imageDirectory,
                fit: BoxFit.cover),
            Text(
              widget.dataHolder.name,
              style: const TextStyle(color: Colors.black54),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.dataHolder.price.toString() + ' usd',
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
}
