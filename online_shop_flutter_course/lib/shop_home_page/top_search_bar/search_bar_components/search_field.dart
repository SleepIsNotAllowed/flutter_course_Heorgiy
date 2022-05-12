import 'package:flutter/material.dart';
import 'package:online_shop_flutter_course/shop_data_management/shop_data_manager.dart';

class SearchField extends StatelessWidget {
  final Function parentSetState;

  const SearchField({Key? key, required this.parentSetState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (String value) {
        DataManager.searched = value;
        parentSetState();
      },
      decoration: const InputDecoration(
        hintText: "Type to search",
        contentPadding: EdgeInsets.symmetric(horizontal: 8),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(
            style: BorderStyle.none,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(
            style: BorderStyle.none,
          ),
        ),
        enabled: true,
        suffixIcon: Icon(Icons.search),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}