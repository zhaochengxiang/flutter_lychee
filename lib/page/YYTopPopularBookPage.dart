import 'package:flutter/material.dart';

import 'package:lychee/widget/base/YYBaseListState.dart';
import 'package:lychee/widget/base/YYBaseState.dart';
import 'package:lychee/widget/base/YYBaseBookListState.dart';
import 'package:lychee/widget/base/YYBaseBookListWidget.dart';
import 'package:lychee/common/util/YYCommonUtils.dart';

class YYTopPopularBookPage extends StatefulWidget {
  @override
  _YYTopPopularBookPageState createState() => _YYTopPopularBookPageState();
}

class _YYTopPopularBookPageState extends State<YYTopPopularBookPage> with AutomaticKeepAliveClientMixin<YYTopPopularBookPage>,YYBaseState<YYTopPopularBookPage>, YYBaseListState<YYTopPopularBookPage>,YYBaseBookListState<YYTopPopularBookPage> {

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
    return "/book/findTopPopular";
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        leading: IconButton(
          icon: new Image.asset(YYCommonUtils.Local_Icon_prefix+"back.png",width: 24.0,height: 24.0),
          onPressed: () {
            YYCommonUtils.closePage(context);
          }),
        title:Text("热门图书"),
        centerTitle: true,
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