import 'package:flutter/material.dart';

import 'package:lychee/widget/base/YYBaseListState.dart';
import 'package:lychee/widget/base/YYBaseState.dart';
import 'package:lychee/widget/base/YYBaseBookListState.dart';
import 'package:lychee/widget/base/YYBaseBookListWidget.dart';
import 'package:lychee/common/util/YYCommonUtils.dart';

class YYTopLatestBookPage extends StatefulWidget {
  @override
  _YYTopLatestBookPageState createState() => _YYTopLatestBookPageState();
}

class _YYTopLatestBookPageState extends State<YYTopLatestBookPage> with AutomaticKeepAliveClientMixin<YYTopLatestBookPage>,YYBaseState<YYTopLatestBookPage>, YYBaseListState<YYTopLatestBookPage>,YYBaseBookListState<YYTopLatestBookPage> {

  @override
  options() {
    int options = 0;
    options = options | YYBaseBookListWidgetControl.ShowCategory;
 
    return options;
  } 

  @override
  remotePath() {
    return "/book/findLatest";
  }

  @override
  generateRemoteParams() {
    Map<String,dynamic> params = new Map();
    YYBaseBookListWidgetControl control = baseWidgetControl;

    params["category"] = control.cid;
    params["scope"] = 0;
    params["last"] = control.last.toInt();
    params["offset"] = control.offset;
    return params;
  }

  @override
  generateMoreRemoteParams() {
    Map<String,dynamic> params = new Map();
    YYBaseBookListWidgetControl control = baseWidgetControl;

    params["category"] = control.cid;
    params["scope"] = 0;
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
        title:Text("新书推荐"),
        centerTitle: true,
      ),
      body: YYBaseBookListWidget(
        control:control,
        onRefresh: handleRefresh,
        onLoadMore: onLoadMore,
        refreshKey: refreshIndicatorKey,
        widgetName: widget.runtimeType.toString(),
        itemBuilder: (BuildContext context, int index) => renderListItem(index),
      )
    );
  }
}