import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}
