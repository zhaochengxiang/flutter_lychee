import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_boost/flutter_boost.dart';

import 'package:event_bus/event_bus.dart';

class YYCommonUtils {
  static const DEBUG = true;
  static const TOKEN_KEY = "token";

  static const Local_Icon_prefix = "static/images/";

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
        return WillPopScope(
          onWillPop: () => new Future.value(false),
          child: Center(
            child: new CupertinoActivityIndicator(),              
          )
        );
      }
    );
  }

  static openPage(url, params) {
    if(Platform.isIOS){
      FlutterBoost.singleton.openPage(url, params);
    }else if(Platform.isAndroid){
      FlutterBoost.singleton.openPage(url, {"query":params});
    }
  }

  static closePage(BuildContext context) {
    FlutterBoost.singleton.closePageForContext(context);
  }

  static isPhoneNo(String phone) {
    if (phone == null) return false;

    phone = phone.replaceAll(' ', '').replaceAll('-', '');

    if (phone.length==11 && phone.startsWith('1')) {
      return true;
    }

    return false;
  }
}