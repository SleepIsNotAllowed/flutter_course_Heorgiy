import 'package:flutter/material.dart';
import 'package:flutter_layout_first_task/scaffold_bottomNavBar_widgets/BottomBar.dart';
import 'package:flutter_layout_first_task/scaffold_child_widgets/AvailableFilesViewField.dart';
import 'package:flutter_layout_first_task/scaffold_child_widgets/SearchBar.dart';
import 'package:flutter_layout_first_task/scaffold_child_widgets/StorageVariantsBar.dart';

class MyLayout extends StatelessWidget {
  const MyLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // to display correctly on any device.
        child: Column(
          children: const [
            SearchBar(),
            StorageVariantsBar(),
            AvailableFilesViewField(),
          ],
        ),
      ),
      floatingActionButton: _floatingActionButton(),
      bottomNavigationBar: const BottomBar(),
    );
  }

  Widget _floatingActionButton() {
    return const FloatingActionButton(
      child: Icon(
        Icons.add,
        color: Colors.blue,
        size: 35,
      ),
      backgroundColor: Colors.white,
      onPressed: null,
    );
  }
}
