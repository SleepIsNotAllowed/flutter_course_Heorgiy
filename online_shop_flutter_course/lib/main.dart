import 'package:flutter/material.dart';
import 'package:online_shop_flutter_course/pages/shop_home_page/shop_home_page.dart';
import 'package:online_shop_flutter_course/util/shop_data_management/data_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ShopHomePage(dataManager: DataManager()),
    );
  }
}
