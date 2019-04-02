import 'package:flutter/material.dart';

import 'package:lychee/widget/base/YYBaseListState.dart';
import 'package:lychee/widget/base/YYBaseState.dart';
import 'package:lychee/widget/base/YYBaseBookListState.dart';
import 'package:lychee/widget/base/YYBaseBookListWidget.dart';
import 'package:lychee/common/util/YYCommonUtils.dart';

class YYTopReadingBookPage extends StatefulWidget {
  @override
  _YYTopReadingBookPageState createState() => _YYTopReadingBookPageState();
}

class _YYTopReadingBookPageState extends State<YYTopReadingBookPage> with AutomaticKeepAliveClientMixin<YYTopReadingBookPage>,YYBaseState<YYTopReadingBookPage>, YYBaseListState<YYTopReadingBookPage>,YYBaseBookListState<YYTopReadingBookPage> {

  @override
  options() {
    int options = 0;
    options = options | YYBaseBookListWidgetControl.ShowCategory;
 
    return options;
  } 

  @override
  remotePath() {
    return "/book/findTopReading";
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
        title:Text("大家都在读"),
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