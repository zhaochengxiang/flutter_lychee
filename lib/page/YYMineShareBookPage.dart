import 'package:flutter/material.dart';

import 'package:lychee/widget/base/YYBaseListState.dart';
import 'package:lychee/widget/base/YYBaseState.dart';
import 'package:lychee/widget/base/YYBaseBookListState.dart';
import 'package:lychee/widget/base/YYBaseBookListWidget.dart';
import 'package:lychee/common/util/YYCommonUtils.dart';
import 'package:lychee/common/style/YYStyle.dart';

class YYMineShareBookPage extends StatefulWidget {
  @override
  _YYMineShareBookPageState createState() => _YYMineShareBookPageState();
}

class _YYMineShareBookPageState extends State<YYMineShareBookPage> with AutomaticKeepAliveClientMixin<YYMineShareBookPage>,YYBaseState<YYMineShareBookPage>, YYBaseListState<YYMineShareBookPage>,YYBaseBookListState<YYMineShareBookPage> {

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
    return "/copy/findMyShare";
  }

  @override
  String get categoryRemotePath => "/category/findMyShare";

  @override
  String get libraryRemotePath => "/library/findOpenShare";

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
        title:Text("我共享的"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
          icon: new Image.asset(YYCommonUtils.Local_Icon_prefix+"search.png",width: 24.0,height: 24.0),
          onPressed: () {

          })
        ]
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child:  YYBaseBookListWidget(
                control:control,
                onRefresh: handleRefresh,
                onLoadMore: onLoadMore,
                refreshKey: refreshIndicatorKey,
                widgetName: widget.runtimeType.toString(),
                itemBuilder: (BuildContext context, int index) => renderListItem(context,index),
              ),
            ),
            Container(
              height: 47.0,
              color: Color(YYColors.gray),
              child: Align(
                alignment: Alignment.centerRight,
                child: FlatButton(
                    padding: EdgeInsets.zero,
                    child: Container(
                      width: 104,
                      height: 47.0,
                      color: Color(YYColors.primary),
                      child: Center( 
                        child: Text("共享图书",style:TextStyle(color: Colors.white,fontSize: YYSize.tip),overflow: TextOverflow.ellipsis)
                      )
                    ),
                    onPressed: () {
                      
                    }
                ),
              )
            )
          ],
        ),
      )
    );
  }
}