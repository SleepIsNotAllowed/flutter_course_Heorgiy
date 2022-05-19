import 'package:flutter/material.dart';
import 'package:online_shop_flutter_course/shop_item_page/shop_item_page.dart';
import '../../../util/shop_data_management/grid_item_data_holder.dart';
import '../../../util/shop_data_management/shop_data_manager.dart';

class GridItem extends StatefulWidget {
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
  State<StatefulWidget> createState() => _GridItemState();
}

class _GridItemState extends State<GridItem> {
  @override
  Widget build(BuildContext context) {
    if (widget.dataManager.totalPriceCount == 0) {
      widget.dataHolder.numberOfPurchased = 0;
    }

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: widget.dataHolder.numberOfPurchased > 0
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
            _buildShortItemView(),
            const Divider(height: 2, thickness: 1),
            _buildButtonRow(),
          ],
        ),
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
            "   Buy   ",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.green),
          ),
        ),
        GestureDetector(
          onTap: () {
            if (widget.dataHolder.numberOfPurchased > 0) {
              setState(() {
                widget.dataHolder.numberOfPurchased--;
                widget.dataManager.totalPriceCount -= widget.dataHolder.price;
                widget.parentSetState();
              });
            }
          },
          child: Text(
            widget.dataHolder.numberOfPurchased.toString(),
            style: TextStyle(
                color: widget.dataHolder.numberOfPurchased > 0
                    ? Colors.black54
                    : Colors.transparent),
          ),
        ),
        IconButton(
          onPressed: () {
            setState(() {
              widget.dataHolder.isFavorite = !widget.dataHolder.isFavorite;
              widget.parentSetState();
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
    );
  }
}
