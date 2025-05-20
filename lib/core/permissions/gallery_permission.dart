import 'package:permission_handler/permission_handler.dart';

class GalleryPermission {

  Future<bool> requestGalleryPermission() async {
    final status = await Permission.photos.request();

      switch (status) {
        case PermissionStatus.granted:
        case PermissionStatus.limited:
          return true;
        case PermissionStatus.denied:
          final secondRequest = await Permission.photos.request();
          return secondRequest.isGranted || secondRequest.isLimited;
        case PermissionStatus.permanentlyDenied:
          await openAppSettings();
          return false;
        case PermissionStatus.restricted:
          return false;
        default:
          return false;
      }
  }
}
