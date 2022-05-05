import 'package:flutter/material.dart';
import 'package:online_shop_flutter_course/shop_home_page/bottom_navigation_bar/bottom_Button.dart';

class BottomBar extends StatelessWidget {
  BottomBar({Key? key}) : super(key: key);

  BottomButtonState? selectedButton;

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
            ),
            BottomButton(
              function: _changeSelected,
              icon: Icons.grid_view,
              text: "Browse",
            ),
            BottomButton(
              function: _changeSelected,
              icon: Icons.favorite_border,
              text: "Favorite",
            ),
            BottomButton(
                function: _changeSelected, icon: Icons.more_horiz, text: "More"),
          ],
        ),
      ),
    );
  }

  _changeSelected(BottomButtonState button) {

    if(selectedButton != null) {
      selectedButton!.setSelected(false);
    }
    button.setSelected(true);
    selectedButton = button;
  }
}
