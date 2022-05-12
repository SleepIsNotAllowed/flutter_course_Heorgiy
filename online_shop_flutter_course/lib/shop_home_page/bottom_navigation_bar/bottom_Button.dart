import 'package:flutter/material.dart';

class BottomButton extends StatefulWidget {
  final Function function;
  final IconData icon;
  final String text;

  const BottomButton(
      {Key? key,
      required this.function,
      required this.icon,
      required this.text})
      : super(key: key);

  @override
  State<BottomButton> createState() => BottomButtonState();
}

class BottomButtonState extends State<BottomButton> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    Color color = isSelected ? Colors.deepPurple : Colors.black54;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          padding: const EdgeInsets.all(4),
          onPressed: () => widget.function(this),
          visualDensity: const VisualDensity(vertical: -4),
          icon: Icon(
            widget.icon,
            color: color,
          ),
        ),
        Text(
          widget.text,
          style: TextStyle(color: color),
        ),
      ],
    );
  }

  setSelected(bool isSelected) {
    this.isSelected = isSelected;
  }
}
