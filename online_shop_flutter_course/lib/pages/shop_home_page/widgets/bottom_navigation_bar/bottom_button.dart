import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget {
  final void Function(int) function;
  final IconData icon;
  final String text;
  final int indexOfButton;
  final int indexOfChosen;

  const BottomButton(
      {Key? key,
      required this.function,
      required this.icon,
      required this.text,
      required this.indexOfButton,
      required this.indexOfChosen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = indexOfChosen == indexOfButton
        ? Colors.deepPurple
        : Colors.black54;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          padding: const EdgeInsets.all(4),
          onPressed: () => function(indexOfButton),
          visualDensity: const VisualDensity(vertical: -4),
          icon: Icon(
            icon,
            color: color,
          ),
        ),
        Text(
          text,
          style: TextStyle(color: color),
        ),
      ],
    );
  }
}
