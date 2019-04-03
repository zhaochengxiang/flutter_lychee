import 'package:flutter/material.dart';

import 'package:lychee/widget/base/YYBaseListState.dart';
import 'package:lychee/widget/base/YYBaseState.dart';
import 'package:lychee/widget/base/YYBaseBookListState.dart';
import 'package:lychee/widget/base/YYBaseBookListWidget.dart';
import 'package:lychee/common/util/YYCommonUtils.dart';

class YYMineCollectionBookPage extends StatefulWidget {
  @override
  _YYMineCollectionBookPageState createState() => _YYMineCollectionBookPageState();
}

class _YYMineCollectionBookPageState extends State<YYMineCollectionBookPage> with AutomaticKeepAliveClientMixin<YYMineCollectionBookPage>,YYBaseState<YYMineCollectionBookPage>, YYBaseListState<YYMineCollectionBookPage>,YYBaseBookListState<YYMineCollectionBookPage> {

  @override
  options() {
    int options = 0;
    options = options | YYBaseBookListWidgetControl.ShowCategory;
    options = options | YYBaseBookListWidgetControl.ShowFrame;
    options = options | YYBaseBookListWidgetControl.ShowCount; 
    options = options | YYBaseBookListWidgetControl.ShowSearch;
 
    return options;
  } 

  @override
  remotePath() {
    return "/collection/search";
  }

  @override
  String get categoryRemotePath => "/category/findCollection";

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        leading: IconButton(
          icon: new Image.asset(YYCommonUtils.Local_Icon_prefix+"back.png",width: 24.0,height: 24.0),
          onPressed: () {
            YYCommonUtils.closePage(context);
          }),
        title:Text("我的藏书"),
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