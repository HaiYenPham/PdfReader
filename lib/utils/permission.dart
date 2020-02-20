import 'package:permission_handler/permission_handler.dart';

class PermissionUtil {
  PermissionStatus _permissionStatus;
  PermissionGroup _permissionGroup;

  static Future<bool> requestPermission(PermissionGroup permission) async {
    final List<PermissionGroup> permissions = <PermissionGroup>[permission];
    final Map<PermissionGroup, PermissionStatus> permissionRequestResult =
        await PermissionHandler().requestPermissions(permissions);
    return permissionRequestResult[permission] == PermissionStatus.granted;
  }
}
