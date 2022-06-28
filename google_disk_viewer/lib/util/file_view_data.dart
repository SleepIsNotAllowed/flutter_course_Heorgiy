import 'package:firebase_flutter_project/util/drive_item_data.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FileViewData {
  GoogleSignInAuthentication? auth;
  DriveItemData? selectedItem;
  List<DriveItemData> itemsData = [];
  bool isGridView = true;
  bool isOnDownload = false;
  bool isUploading = false;
}