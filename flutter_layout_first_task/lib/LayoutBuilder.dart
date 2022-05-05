import 'package:flutter/material.dart';
import 'package:flutter_layout_first_task/scaffold_bottom_nav_bar_widgets/bottom_bar.dart';
import 'package:flutter_layout_first_task/scaffold_child_widgets/available_files_view_field.dart';
import 'package:flutter_layout_first_task/scaffold_child_widgets/search_bar.dart';
import 'package:flutter_layout_first_task/scaffold_child_widgets/storage_variants_bar.dart';

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
