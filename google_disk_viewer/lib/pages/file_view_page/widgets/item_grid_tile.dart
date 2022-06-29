import 'package:firebase_flutter_project/util/colors.dart';
import 'package:firebase_flutter_project/util/drive_item_data.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ItemGridTile extends StatelessWidget {
  final GoogleSignInAuthentication? auth;
  final DriveItemData itemData;
  final Color borderColor;

  const ItemGridTile({
    Key? key,
    required this.auth,
    required this.itemData,
    required this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        color: AppColors.backgroundSecondary,
      ),
      child: Column(
        children: [
          _buildThumbnail(),
          _buildInfoSection(),
        ],
      ),
    );
  }

  Widget _buildInfoSection() {
    return Container(
      height: 40,
      padding: const EdgeInsets.all(4),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 4, 12, 4),
            child: Image.network(itemData.iconLink, fit: BoxFit.cover),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  itemData.name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  itemData.size,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThumbnail() {
    String iconLink = itemData.iconLink.replaceAll('16', '256');
    return itemData.thumbnail == null
        ? Expanded(
            child: Container(
              padding: const EdgeInsets.all(25),
              margin: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.grey.shade700,
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              child: Image.network(
                iconLink,
                fit: BoxFit.fill,
              ),
            ),
          )
        : Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                image: DecorationImage(
                  image: NetworkImage(
                    itemData.thumbnail!,
                    headers: {'authorization': 'Bearer ${auth?.accessToken}'},
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
  }
}
