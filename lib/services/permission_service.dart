import 'package:app_tracking_transparency/app_tracking_transparency.dart';


class PermissionService{

  requestTrackingPermission()async{
    final TrackingStatus status = await AppTrackingTransparency.trackingAuthorizationStatus;
    if (status != TrackingStatus.authorized) {
      final TrackingStatus newStatus = await AppTrackingTransparency.requestTrackingAuthorization();
    }
  }
}