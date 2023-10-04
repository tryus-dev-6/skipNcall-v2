
import 'package:permission_handler/permission_handler.dart';

class UsesPermission{

  static Future<bool> checkStoragePermission(PermissionStatus status) async {

    //PermissionStatus status = await Permission.location.request();

    if (status.isPermanentlyDenied) {
      // Permission is permanently denied
      // Open app settings to allow permissions
      openAppSettings();

      return false;
    }
    else if (status.isGranted) {
      return true;
    } else if (status.isDenied) {
      return false;
    }
    else{
      return false;
    }

  }

}