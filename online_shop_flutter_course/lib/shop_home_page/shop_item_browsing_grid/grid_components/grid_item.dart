import 'package:flutter/material.dart';

class GridItem extends StatefulWidget {
  final String imageDirectory;
  final String itemName;
  final int price;

  const GridItem(
      {Key? key,
      required this.imageDirectory,
      required this.itemName,
      required this.price})
      : super(key: key);

  @override
  State<GridItem> createState() => _GridItemState();
}

class _GridItemState extends State<GridItem> {
  bool forPurchase = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: forPurchase ? Colors.deepPurple : Colors.transparent,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Image.asset(
                widget.imageDirectory,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              widget.itemName,
              style: const TextStyle(
                color: Colors.black54,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Text(
                widget.price.toString() + ' usd',
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 18,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ]),
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
          onPressed: null,
          child: const Text(
            "   Buy   ",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.green),
          ),
        ),
        const Icon(
          Icons.favorite_border,
          color: Colors.grey,
        )
      ],
    );
  }
}
