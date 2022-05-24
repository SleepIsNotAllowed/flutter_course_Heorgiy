import 'package:flutter/material.dart';
import 'package:online_shop_flutter_course/pages/item_full_view_page/item_full_view_page.dart';
import 'package:online_shop_flutter_course/util/shop_data_management/grid_item_data_holder.dart';
import 'package:online_shop_flutter_course/util/shop_data_management/data_manager.dart';

class InCartGridItem extends StatefulWidget {
  final VoidCallback parentSetState;
  final GridItemDataHolder dataHolder;
  final DataManager dataManager;

  const InCartGridItem(
      {Key? key,
      required this.parentSetState,
      required this.dataHolder,
      required this.dataManager})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _InCartGridItemState();
}

class _InCartGridItemState extends State<InCartGridItem> {
  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildShortItemView(),
          const Divider(height: 2, thickness: 1),
          _buildButtonRow(),
        ],
      ),
    );
  }

  Widget _buildShortItemView() {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ItemFullViewPage(
                dataHolder: widget.dataHolder,
                dataManager: widget.dataManager,
              ),
            ),
          ).then((value) => widget.parentSetState());
        },
        child: Column(
          children: [
            Expanded(
              child: Image.asset(widget.dataHolder.imageDirectory,
                  fit: BoxFit.cover),
            ),
            Text(
              widget.dataHolder.name,
              style: const TextStyle(color: Colors.black54),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.dataHolder.price.toString() + ' usd',
                  style: const TextStyle(color: Colors.green, fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Text(
                  'Added: ' + widget.dataHolder.numberOfPurchased.toString(),
                  style: const TextStyle(color: Colors.black54, fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            )
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
              widget.dataHolder.numberOfPurchased++;
              widget.dataManager.totalPriceCount += widget.dataHolder.price;
              widget.parentSetState();
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
              widget.dataHolder.numberOfPurchased--;
              widget.dataManager.totalPriceCount -= widget.dataHolder.price;
              widget.parentSetState();
            });
          },
          child: const Text(
            "Remove",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.red),
          ),
        ),
      ],
    );
  }
}
