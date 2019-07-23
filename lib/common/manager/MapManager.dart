import 'package:amap_base_location/amap_base_location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MapManager {

  static String key = "0c34f8e7e85b363bfcad92ae12aa182c";
  
  static init() async {
    await AMap.init(key);
  }

  static Future<bool> requestPermission() async{
    PermissionStatus permission = await PermissionHandler().checkPermissionStatus(PermissionGroup.locationWhenInUse);

    if (permission ==PermissionStatus.unknown) {

      await PermissionHandler().requestPermissions([PermissionGroup.locationWhenInUse]);
      permission = await PermissionHandler().checkPermissionStatus(PermissionGroup.locationWhenInUse);
      if (permission ==PermissionStatus.denied || permission ==PermissionStatus.restricted) {
        
        Fluttertoast.showToast(msg: "定位服务未开启",gravity: ToastGravity.CENTER);
        return false;
      }

      return true;

    } else if (permission ==PermissionStatus.denied || permission ==PermissionStatus.restricted) {

      return false;

    }

    return true;
  }

  static Future<Location> getLocation() async {
    AMapLocation _amapLocation = AMapLocation();
    _amapLocation.init();

    final options = LocationClientOptions(isOnceLocation: true,locatingWithReGeocode: true);
    return  await _amapLocation.getLocation(options);
  }
  
}