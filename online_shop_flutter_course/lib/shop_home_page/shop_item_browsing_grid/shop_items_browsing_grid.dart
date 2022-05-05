import 'package:flutter/material.dart';

class ItemsBrowsingGrid extends StatefulWidget {
  const ItemsBrowsingGrid({Key? key}) : super(key: key);

  @override
  State<ItemsBrowsingGrid> createState() => _ItemsBrowsingGridState();
}

class _ItemsBrowsingGridState extends State<ItemsBrowsingGrid> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: GridView.count(
        crossAxisCount: 2,
      ),
    );
  }
}
