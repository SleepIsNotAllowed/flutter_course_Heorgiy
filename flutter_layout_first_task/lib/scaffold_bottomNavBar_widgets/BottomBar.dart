import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.white,
      elevation: 4,
      child: SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _createBottomButton(Icons.home_filled, "Home", false),
            _createBottomButton(Icons.star_border, "Favorites", false),
            _createBottomButton(Icons.people_alt_outlined, "Available", false),
            _createBottomButton(Icons.folder, "Files", true),
          ],
        ),
      ),
    );
  }

  Widget _createBottomButton(IconData icon, String text, bool isActive) {
    var _color = isActive ? Colors.blueAccent : Colors.grey;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: _color,
        ),
        Text(
          text,
          style: TextStyle(color: _color),
        ),
      ],
    );
  }
}
