import 'package:flutter/material.dart';

class AvailableFilesViewField extends StatelessWidget {
  const AvailableFilesViewField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          _sortingBar(),
          _listTile("artsciencejava.pdf", "16 sep. 2021 y."),
          _listTile("java_8_rukovodstvo_dlya_nachinayshih", "4 dec. 2021 y.")
        ],
      ),
    );
  }

  Widget _sortingBar() {
    const _color = Colors.black54;

    return Container(
      height: 40,
      margin: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: const [
              Text(
                "By name",
                style: TextStyle(color: _color),
              ),
              Icon(
                Icons.arrow_upward_rounded,
                color: _color,
              ),
            ],
          ),
          const Icon(
            Icons.view_module_sharp,
            color: _color,
          ),
        ],
      ),
    );
  }

  Widget _listTile(String textMain, String textInfo) {
    return ListTile(
      leading: const Icon(
        Icons.picture_as_pdf,
        color: Colors.red,
      ),
      title: Text(
        textMain,
      ),
      subtitle: _subtitleRow(textInfo),
      trailing: const Icon(
        Icons.more_horiz,
        color: Colors.black54,
      ),
    );
  }

  Widget _subtitleRow(String textInfo) {
    return Row(
      children: [
        const Icon(
          Icons.offline_pin,
          color: Colors.black54,
          size: 11,
        ),
        Text(
          " Changed: " + textInfo,
        ),
      ],
    );
  }
}
