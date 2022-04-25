import 'package:flutter/material.dart';

class MyLayout extends StatelessWidget {
  const MyLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Layout imitation',
      home: Scaffold(
        body: SafeArea(
          // to display correctly on any device.
          child: Column(
            children: [
              _searchBar(),
              _storageVariantsBar(),
              _availableFileView(),
            ],
          ),
        ),
        floatingActionButton: const FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.blue,
            size: 35,
          ),
          backgroundColor: Colors.white,
          onPressed: null,
        ),
        bottomNavigationBar: _bottomBar(),
      ),
    );
  }

  Widget _searchBar() {
    return Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.all(4),
      height: 60,
      child: PhysicalModel(
        color: Colors.white,
        elevation: 2,
        borderRadius: BorderRadius.circular(8),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              child: const Icon(
                Icons.menu,
                color: Colors.black54,
              ),
            ),
            const Expanded(
                child: Text(
              "Search on Google Disc",
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            )),
            _userIcon(),
          ],
        ),
      ),
    );
  }

  /// Uses BoxDecoration widget and Text widget to imitate
  /// Google user icon.
  Widget _userIcon() {
    return Container(
        margin: const EdgeInsets.all(10),
        height: 30,
        width: 30,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(-720281999),
        ),
        child: const Center(
          child: Text(
            "G",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ));
  }

  Widget _storageVariantsBar() {
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

  Widget _availableFileView() {
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

  Widget _bottomBar() {
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
