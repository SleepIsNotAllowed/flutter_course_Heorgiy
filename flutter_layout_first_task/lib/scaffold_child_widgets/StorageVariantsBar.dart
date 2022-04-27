import 'package:flutter/material.dart';

class StorageVariantsBar extends StatelessWidget {
  const StorageVariantsBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: const BoxDecoration(
          border: Border(
        bottom: BorderSide(
          width: 1,
          color: Color(0x61808080),
        ),
      )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _createStorageEntry("My disc", true),
          _createStorageEntry("Devices", false),
        ],
      ),
    );
  }

  /// Constructs entry for Storage bar.
  Widget _createStorageEntry(String text, bool isActive) {
    var _color = isActive ? Colors.blue : Colors.black54;
    var _textStyle = TextStyle(
      fontSize: 15,
      color: _color,
      fontWeight: FontWeight.bold,
    );

    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 2,
            color: isActive ? Colors.blue : Colors.transparent,
          ),
        ),
      ),
      child: Text(
        text,
        style: _textStyle,
      ),
    );
  }
}
