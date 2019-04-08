import 'package:flutter/material.dart';

import 'package:lychee/widget/base/BaseListState.dart';
import 'package:lychee/widget/base/BaseState.dart';
import 'package:lychee/widget/base/BaseBookListState.dart';
import 'package:lychee/widget/base/BaseBookListWidget.dart';
import 'package:lychee/common/util/CommonUtils.dart';
import 'package:lychee/common/style/Style.dart';

class MineShareBookPage extends StatefulWidget {
  @override
  _MineShareBookPageState createState() => _MineShareBookPageState();
}

class _MineShareBookPageState extends State<MineShareBookPage> with AutomaticKeepAliveClientMixin<MineShareBookPage>,BaseState<MineShareBookPage>, BaseListState<MineShareBookPage>,BaseBookListState<MineShareBookPage> {

  @override
  bool get needFrame => false;
  
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
    return new Scaffold(
      appBar: new AppBar(
        leading: IconButton(
          icon: new Image.asset(CommonUtils.Local_Icon_prefix+"back.png",width: 24.0,height: 24.0),
          onPressed: () {
            CommonUtils.closePage(context);
          }),
        title:Text("我共享的"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
          icon: new Image.asset(CommonUtils.Local_Icon_prefix+"search.png",width: 24.0,height: 24.0),
          onPressed: () {

          })
        ]
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child:  BaseBookListWidget(
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