import 'package:firebase_flutter_project/pages/logg_in_home_page/logg_in_home_page.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoggInHomePage(),
    );
  }
}
