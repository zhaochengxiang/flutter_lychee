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
import 'package:lychee/common/xservice/loader/YYServiceLoader.dart';
import 'package:lychee/common/local/YYLocalStorage.dart';
import 'package:lychee/page/YYHomeBookPage.dart';
import 'package:lychee/page/YYBookDetailPage.dart';
import 'package:lychee/page/YYCoursePage.dart';
import 'package:lychee/page/YYLessonPage.dart';
import 'package:lychee/page/YYLessonDetailPage.dart';
import 'package:lychee/page/YYCourseDetailPage.dart';
import 'package:lychee/page/YYTopCollectionBookPage.dart';
import 'package:lychee/page/YYTopReadingBookPage.dart';
import 'package:lychee/page/YYTopReadBookPage.dart';
import 'package:lychee/page/YYTopPopularBookPage.dart';
import 'package:lychee/page/YYTopLatestBookPage.dart';
import 'package:lychee/page/YYMineBookPage.dart';
import 'package:lychee/page/YYMineCollectionBookPage.dart';

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

    YYLocalStorage.save(YYCommonUtils.TOKEN_KEY, "303ddfbd03d78d14d5fde13129cc8b0e");

    YYShareManager.init();
    YYPushManager.init();
    YYServiceLoader.load();

    FlutterBoost.singleton.registerPageBuilders({
      'flutter://home': (pageName, params, _) => YYHomeTabBarPage(),
      
      'flutter://home_book': (pageName, params, _) => YYHomeBookPage(),
      'flutter://book_detail': (pageName, params, _) => YYBookDetailPage(params),
      'flutter://lesson': (pageName, params, _) => YYLessonPage(),
      'flutter://lesson_detail': (pageName, params, _) => YYLessonDetailPage(params),
      'flutter://course': (pageName, params, _) => YYCoursePage(),
      'flutter://course_detail': (pageName, params, _) => YYCourseDetailPage(params),

      'flutter://top_collection': (pageName, params, _) => YYTopCollectionBookPage(),
      'flutter://top_reading': (pageName, params, _) => YYTopReadingBookPage(),
      'flutter://top_read': (pageName, params, _) => YYTopReadBookPage(),
      'flutter://top_popular': (pageName, params, _) => YYTopPopularBookPage(), 'flutter://top_latest': (pageName, params, _) => YYTopLatestBookPage(),

      'flutter://login': (pageName, params, _) => YYLoginPage(),
      'flutter://mine_book': (pageName, params, _) => YYMineBookPage(),
      'flutter://mine_collection': (pageName, params, _) => YYMineCollectionBookPage(),
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
