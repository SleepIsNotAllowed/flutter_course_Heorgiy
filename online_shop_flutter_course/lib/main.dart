import 'package:flutter/material.dart';
import 'package:online_shop_flutter_course/shop_home_page/shop_home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ShopHomePage(),
    );
  }
}
