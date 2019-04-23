import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:lychee/page/HomePage.dart';
import 'package:lychee/page/CategoryPage.dart';
import 'package:lychee/page/DiscoverPage.dart';
import 'package:lychee/page/MinePage.dart';
import 'package:lychee/common/style/Style.dart';
import 'package:lychee/common/util/CommonUtils.dart';

class HomeTabBarPage extends StatefulWidget {
  @override
  State<HomeTabBarPage> createState() {
    return new _HomeTabBarPageState();
  }
}

class _HomeTabBarPageState extends State<HomeTabBarPage> {

  var tabImages;
  var pages;
  var titles;
  int _tabIndex = 0;

  /// 单击提示退出
  Future<bool> _dialogExitApp(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => new AlertDialog(
              content: new Text("确定要退出应用？"),
              actions: <Widget>[
                new InkWell(onTap: () => Navigator.of(context).pop(false), child: new Text("取消")),
                new InkWell(
                    onTap: () {
                      Navigator.of(context).pop(true);
                    },
                    child: new Text("确定"))
              ],
            ));
  }

  @override
  void initState() {
    super.initState();
    pages = <Widget>[
      new HomePage(),
      new CategoryPage(),
      new DiscoverPage(),
      new MinePage(),
    ];

    tabImages = [
      [
        getTabImage('tabbar_home.png'),
        getTabImage('tabbar_home_h.png')
      ],
      [
        getTabImage('tabbar_category.png'),
        getTabImage('tabbar_category_h.png')
      ],
      [
        getTabImage('tabbar_discover.png'),
        getTabImage('tabbar_discover_h.png')
      ],
      [
        getTabImage('tabbar_mine.png'),
        getTabImage('tabbar_mine_h.png')
      ]
    ];

    titles = ['首页', '分类', '发现', '我的'];
  }

  Image getTabImage(path) {
    return new Image.asset(CommonUtils.Local_Icon_prefix+path, width: 20.0, height: 20.0);
  }

  Image getTabIcon(int curIndex) {
    if (curIndex == _tabIndex) {
      return tabImages[curIndex][1];
    }
    return tabImages[curIndex][0];
  }

  TextStyle getTabTextStyle(int curIndex) {
    if (curIndex == _tabIndex) {
      return TextStyle(color:Color(YYColors.primary),fontSize: YYSize.small);
    }
    return TextStyle(color:Color(YYColors.secondaryText),fontSize: YYSize.small);
  }

  Text getTabTitle(int curIndex) {
    return new Text(titles[curIndex], style: getTabTextStyle(curIndex));
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return WillPopScope(
      onWillPop: () {
        return _dialogExitApp(context);
      },
      child: new Scaffold(
        body: new IndexedStack(
          children: pages,
          index: _tabIndex,
        ),
        bottomNavigationBar: new BottomNavigationBar(
          type:BottomNavigationBarType.fixed,
          iconSize: 24.0,
          currentIndex: _tabIndex,
          onTap: (index) {
            setState((){
              _tabIndex = index;
            });
          },
          items: <BottomNavigationBarItem>[
            new BottomNavigationBarItem(
                icon: getTabIcon(0),
                title: getTabTitle(0)),
            new BottomNavigationBarItem(
                icon: getTabIcon(1),
                title: getTabTitle(1)),
            new BottomNavigationBarItem(
                icon: getTabIcon(2),
                title: getTabTitle(2)),
            new BottomNavigationBarItem(
                icon: getTabIcon(3),
                title: getTabTitle(3)),
          ],
        ),
      ),
    );
  }
}

