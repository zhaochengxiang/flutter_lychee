import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter_statusbar/flutter_statusbar.dart';

import '../local/LocalStorage.dart';

class CommonUtils {
  static const DEBUG = true;
  static const TOKEN_KEY = "token";

  static const Local_Icon_prefix = "static/images/";

  static const QRCode_Prefix = "https://lizhiketang.com/";

  static final EventBus eventBus = new EventBus();

  static String coverPath(id,style) {
    return "http://cover.lizhiketang.com/$style/$id.webp";
  }

  static String avatarPath(id) {
    return "http://avatar.lizhiketang.com/$id.jpg";
  }

  static Future<Null> showLoadingDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return new Material(
          color: Colors.transparent,
          child: WillPopScope(
            onWillPop: () => new Future.value(false),
            child: Center(
              child: new CupertinoActivityIndicator(),              
            )
          )
        );
      }
    );
  }

  static openPage(BuildContext context, Widget widget) {
    return Navigator.push(context, new CupertinoPageRoute(builder: (context) => widget));
  }

  static closePage(BuildContext context) {
    Navigator.pop(context);
  }

  static isPhoneNo(String phone) {
    if (phone == null) return false;

    phone = phone.replaceAll(' ', '').replaceAll('-', '');

    if (phone.length==11 && phone.startsWith('1')) {
      return true;
    }

    return false;
  }

  static double sStaticBarHeight = 0.0;

  static Future initStatusBarHeight() async {
    sStaticBarHeight = await FlutterStatusbar.height;
  }

  static bool sStaticUserIsLogin = false;
  static initUserIsLoginState() async {
    var token =await LocalStorage.get(CommonUtils.TOKEN_KEY);
    if (token==null||token.length==0) {
      sStaticUserIsLogin = false;
    } else {
      sStaticUserIsLogin = true;
    }
  }
}