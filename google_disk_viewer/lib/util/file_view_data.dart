import 'package:firebase_flutter_project/util/drive_item_data.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart';

class FileViewData {
  GoogleSignInAuthentication? auth;
  DriveItemData? selectedItem;
  List<DriveItemData> itemsData = [];
  bool isGridView = true;
  bool isOnDownload = false;
  bool isUploading = false;
  String? downloadPath;
  GoogleSignIn googleSignIn = GoogleSignIn(scopes: [
    DriveApi.driveScope,
    DriveApi.driveFileScope,
    DriveApi.driveReadonlyScope,
    DriveApi.driveMetadataReadonlyScope,
    DriveApi.driveAppdataScope,
    DriveApi.driveMetadataScope,
    DriveApi.drivePhotosReadonlyScope,
  ]);
}