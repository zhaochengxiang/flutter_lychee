import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'package:lychee/common/event/YYHttpErrorEvent.dart';
import 'package:lychee/page/YYHomeTabBarPage.dart';
import 'package:lychee/page/YYLoginPage.dart';
import 'package:lychee/common/util/YYCommonUtils.dart';
import 'package:lychee/common/manager/YYShareManager.dart';
import 'package:lychee/common/manager/YYPushManager.dart';

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
    YYShareManager.init();
    YYPushManager.init();
    
    FlutterBoost.singleton.registerPageBuilders({
      'flutter://home': (pageName, params, _) => YYHomeTabBarPage(),
      'flutter://login': (pageName, params, _) => YYLoginPage(),
    });

    FlutterBoost.handleOnStartPage();

    stream =  YYCommonUtils.eventBus.on<YYHttpErrorEvent>().listen((event) {
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
      builder: FlutterBoost.init(),
      home: Container()
    );
  }
}
