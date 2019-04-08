import 'package:flutter/material.dart';

import 'package:lychee/widget/base/BaseListState.dart';
import 'package:lychee/widget/base/BaseState.dart';
import 'package:lychee/widget/base/BaseBookListState.dart';
import 'package:lychee/widget/base/BaseBookListWidget.dart';
import 'package:lychee/common/util/CommonUtils.dart';

class TopReadingBookPage extends StatefulWidget {
  @override
  _TopReadingBookPageState createState() => _TopReadingBookPageState();
}

class _TopReadingBookPageState extends State<TopReadingBookPage> with AutomaticKeepAliveClientMixin<TopReadingBookPage>,BaseState<TopReadingBookPage>, BaseListState<TopReadingBookPage>,BaseBookListState<TopReadingBookPage> {

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
    return "/book/findTopReading";
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        leading: IconButton(
          icon: new Image.asset(CommonUtils.Local_Icon_prefix+"back.png",width: 24.0,height: 24.0),
          onPressed: () {
            CommonUtils.closePage(context);
          }),
        title:Text("大家都在读"),
        centerTitle: true,
      ),
      body: BaseBookListWidget(
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