import 'package:flutter/material.dart';

import 'package:lychee/widget/base/YYBaseListState.dart';
import 'package:lychee/widget/base/YYBaseState.dart';
import 'package:lychee/widget/base/YYBaseBookListState.dart';
import 'package:lychee/widget/base/YYBaseBookListWidget.dart';
import 'package:lychee/common/util/YYCommonUtils.dart';

class YYMineWantReadBookPage extends StatefulWidget {
  @override
  _YYMineWantReadBookPageState createState() => _YYMineWantReadBookPageState();
}

class _YYMineWantReadBookPageState extends State<YYMineWantReadBookPage> with AutomaticKeepAliveClientMixin<YYMineWantReadBookPage>,YYBaseState<YYMineWantReadBookPage>, YYBaseListState<YYMineWantReadBookPage>,YYBaseBookListState<YYMineWantReadBookPage> {

  @override
  options() {
    int options = 0;
    options = options | YYBaseBookListWidgetControl.ShowCategory;
    options = options | YYBaseBookListWidgetControl.ShowLibrary;
    options = options | YYBaseBookListWidgetControl.ShowCount; 
    options = options | YYBaseBookListWidgetControl.ShowSearch;
 
    return options;
  } 

  @override
  remotePath() {
    return "/label/searchWant";
  }

  @override
  String get categoryRemotePath => "/category/findWantRead";

  @override
  generateRemoteParams() {
    Map<String,dynamic> params = new Map();
    YYBaseBookListWidgetControl control = baseWidgetControl;
    params["category"] = control.cid;
    params["lid"] = control.lid.toInt();
    params["state"] = 0;
    params["keyword"] = "";
    params["last"] = control.last.toInt();
    params["offset"] = control.offset;
    return params;
  }

  @override
  generateMoreRemoteParams() {
    Map<String,dynamic> params = new Map();
    YYBaseBookListWidgetControl control = baseWidgetControl;
    params["category"] = control.cid;
    params["lid"] = control.lid.toInt();
    params["state"] = 0;
    params["keyword"] = "";
    params["last"] = control.last.toInt();
    params["offset"] = control.offset;
    return params;
  }

  @override
  Widget build(BuildContext context) {
    YYBaseBookListWidgetControl control = baseWidgetControl;

    return new Scaffold(
      appBar: new AppBar(
        leading: IconButton(
          icon: new Image.asset(YYCommonUtils.Local_Icon_prefix+"back.png",width: 24.0,height: 24.0),
          onPressed: () {
            YYCommonUtils.closePage(context);
          }),
        title:Text("我想读的"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
          icon: new Image.asset(YYCommonUtils.Local_Icon_prefix+"search.png",width: 24.0,height: 24.0),
          onPressed: () {

          })
        ]
      ),
      body: YYBaseBookListWidget(
        control:control,
        onRefresh: handleRefresh,
        onLoadMore: onLoadMore,
        refreshKey: refreshIndicatorKey,
        widgetName: widget.runtimeType.toString(),
        itemBuilder: (BuildContext context, int index) => renderListItem(context,index),
      )
    );
  }
}