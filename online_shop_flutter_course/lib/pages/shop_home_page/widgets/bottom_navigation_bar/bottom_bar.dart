import 'package:flutter/material.dart';
import 'package:online_shop_flutter_course/pages/shop_home_page/widgets/bottom_navigation_bar/bottom_button.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int indexOfActiveButton = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: PhysicalModel(
        color: Colors.white,
        elevation: 4,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BottomButton(
              function: _changeSelected,
              icon: Icons.reviews_outlined,
              text: "Reviews",
              indexOfButton: 1,
              indexOfChosen: indexOfActiveButton,
            ),
            BottomButton(
              function: _changeSelected,
              icon: Icons.grid_view,
              text: "Browse",
              indexOfButton: 2,
              indexOfChosen: indexOfActiveButton,
            ),
            BottomButton(
              function: _changeSelected,
              icon: Icons.favorite_border,
              text: "Favorite",
              indexOfButton: 3,
              indexOfChosen: indexOfActiveButton,
            ),
            BottomButton(
              function: _changeSelected,
              icon: Icons.more_horiz,
              text: "More",
              indexOfButton: 4,
              indexOfChosen: indexOfActiveButton,
            ),
          ],
        ),
      ),
    );
  }

  _changeSelected(int buttonIndex) {
    setState(() {
      indexOfActiveButton = buttonIndex;
    });
  }
}
