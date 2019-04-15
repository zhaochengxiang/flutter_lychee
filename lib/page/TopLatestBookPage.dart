import 'package:flutter/material.dart';

import 'package:lychee/widget/base/BaseListState.dart';
import 'package:lychee/widget/base/BaseState.dart';
import 'package:lychee/widget/base/BaseBookListState.dart';
import 'package:lychee/widget/base/BaseBookListWidget.dart';
import 'package:lychee/common/util/CommonUtils.dart';

class TopLatestBookPage extends StatefulWidget {
  @override
  _TopLatestBookPageState createState() => _TopLatestBookPageState();
}

class _TopLatestBookPageState extends State<TopLatestBookPage> with AutomaticKeepAliveClientMixin<TopLatestBookPage>,BaseState<TopLatestBookPage>, BaseListState<TopLatestBookPage>,BaseBookListState<TopLatestBookPage> {

  @override
  bool get needLibrary => false;

  @override
  bool get needFrame => false;

  @override
  bool get needCount => false;

  @override
  bool get needSearch => false;

  @override
  remotePath() {
    return "/book/findLatest";
  }

  @override
  generateRemoteParams() {
    Map<String,dynamic> params = new Map();
    params["category"] = control.cid;
    params["scope"] = 0;
    params["last"] = 0;
    params["offset"] = 0;
    return params;
  }

  @override
  generateMoreRemoteParams() {
    Map<String,dynamic> params = new Map();
    params["category"] = control.cid;
    params["scope"] = 0;
    params["last"] = control.last;
    params["offset"] = control.offset;
    return params;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        leading: IconButton(
          icon: new Image.asset(CommonUtils.Local_Icon_prefix+"back.png",width: 18.0,height: 18.0),
          onPressed: () {
            CommonUtils.closePage(context);
          }),
        title:Text("新书推荐"),
        centerTitle: true,
      ),
      body: BaseBookListWidget(
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