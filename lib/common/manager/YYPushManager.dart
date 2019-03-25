import 'dart:io';
// import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

class YYPushManager {
  // static String appKey = 'efc2f808fadd15339b95ac41';
  // static bool isProduction = false;
  // static bool isDebug = true; 

  // static void init() {
  //   final JPush jpush = new JPush();
  //   jpush.setup(
  //     appKey: appKey,
  //     channel: '',
  //     production: isProduction,
  //     debug: isDebug,
  //   );

  //   jpush.applyPushAuthority(new NotificationSettingsIOS(
  //     sound: true,
  //     alert: true,
  //     badge: true));

  //   jpush.addEventHandler(
  //     onReceiveNotification: (Map<String, dynamic> message) async {
  //       print("flutter onReceiveNotification: $message");
  //       if(Platform.isIOS){
  //         Fluttertoast.showToast(msg: message['aps']['alert'],gravity: ToastGravity.CENTER);
  //       }else if(Platform.isAndroid){
  //         Fluttertoast.showToast(msg: message['alert'],gravity: ToastGravity.CENTER);
  //       }
  //     },
  //     onOpenNotification: (Map<String, dynamic> message) async {
  //       print("flutter onOpenNotification: $message");
  //       if(Platform.isIOS){
  //         Fluttertoast.showToast(msg: message['aps']['alert'],gravity: ToastGravity.CENTER);
  //       }else if(Platform.isAndroid){
  //         Fluttertoast.showToast(msg: message['alert'],gravity: ToastGravity.CENTER);
  //       }
  //     },
  //     onReceiveMessage: (Map<String, dynamic> message) async {
  //       print("flutter onReceiveMessage: $message");
  //     },
  //   );
  // }
}