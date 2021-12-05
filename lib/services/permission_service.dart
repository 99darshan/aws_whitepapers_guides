import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  static Future storagePermission() async {
    var storagePermission = await Permission.storage.status;

    print("current permission " + storagePermission.toString());

    if (storagePermission != PermissionStatus.granted) {
      Map<Permission, PermissionStatus> permissions =
          await [Permission.storage].request();

      PermissionStatus userPermission = permissions[Permission.storage];
      print('did user grant permission : ' + userPermission.toString());
    }
  }
}
