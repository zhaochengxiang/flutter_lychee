import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lychee/common/event/HttpErrorEvent.dart';
import 'package:lychee/page/HomeTabBarPage.dart';
import 'package:lychee/common/util/CommonUtils.dart';
import 'package:lychee/common/manager/PushManager.dart';
import 'package:lychee/common/xservice/loader/ServiceLoader.dart';
import 'package:lychee/common/local/LocalStorage.dart';

void main() => runApp(LycheeApp());

class LycheeApp extends StatefulWidget {
  @override
  State<LycheeApp> createState() {
    return new _LycheeAppState();
  }
}

class _LycheeAppState extends State<LycheeApp> {
  StreamSubscription stream;

  @override
  void initState() {
    super.initState();

    LocalStorage.save(CommonUtils.TOKEN_KEY, "962e3e198187abcda3af749f2d29de98");

    PushManager.init();
    ServiceLoader.load();
    
    stream =  CommonUtils.eventBus.on<HttpErrorEvent>().listen((event) {
      errorHandleFunction(event.message);
    });
  }

  @override
  void dispose() {
    super.dispose();
    if(stream != null) {
      stream.cancel();
      stream = null;
    }
  }

  errorHandleFunction(message) {
    Fluttertoast.showToast(msg: message,gravity: ToastGravity.CENTER);
  }

  @override
  Widget build(BuildContext context) {

    return new MaterialApp(
      theme: new ThemeData(primaryColor: Colors.white,canvasColor: Colors.white),
      home: HomeTabBarPage()
    );
  }
}
