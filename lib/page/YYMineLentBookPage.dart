import 'package:flutter/material.dart';

import 'package:lychee/widget/base/YYBaseListState.dart';
import 'package:lychee/widget/base/YYBaseState.dart';
import 'package:lychee/widget/base/YYBaseBookListState.dart';
import 'package:lychee/widget/base/YYBaseBookListWidget.dart';
import 'package:lychee/common/util/YYCommonUtils.dart';
import 'package:lychee/widget/base/YYBaseBookRadioListState.dart';
import 'package:lychee/widget/base/YYBaseBookRadioListWidget.dart';

class YYMineLentBookPage extends StatefulWidget {
  @override
  _YYMineLentBookPageState createState() => _YYMineLentBookPageState();
}

class _YYMineLentBookPageState extends State<YYMineLentBookPage> with AutomaticKeepAliveClientMixin<YYMineLentBookPage>,YYBaseState<YYMineLentBookPage>, YYBaseListState<YYMineLentBookPage>,YYBaseBookListState<YYMineLentBookPage>,
YYBaseBookRadioListState<YYMineLentBookPage> {

  @override
  remotePath() {
    return "/receipt/findLent";
  }

  @override
  String get buttonName => "删除";

  @override
  buttonOnPressed() {
    
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
        title:Text("我借出的"),
        centerTitle: true,
      ),
      body: YYBaseBookRadioListWidget(
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