import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  static Future storagePermission() async {
    PermissionStatus storagePerm = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.storage);

    print("current permission " + storagePerm.toString());

    if (storagePerm != PermissionStatus.granted) {
      Map<PermissionGroup, PermissionStatus> permissions =
          await PermissionHandler()
              .requestPermissions([PermissionGroup.storage]);

      PermissionStatus userPermission = permissions[PermissionGroup.storage];
      print('did user grant permission : ' + userPermission.toString());
    }
  }
}
