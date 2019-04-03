import 'package:flutter/material.dart';

import 'package:lychee/widget/base/YYBaseListState.dart';
import 'package:lychee/widget/base/YYBaseState.dart';
import 'package:lychee/widget/base/YYBaseBookListState.dart';
import 'package:lychee/widget/base/YYBaseBookListWidget.dart';
import 'package:lychee/common/util/YYCommonUtils.dart';
import 'package:lychee/widget/base/YYBaseBookRadioListState.dart';
import 'package:lychee/widget/base/YYBaseBookRadioListWidget.dart';

class YYMineWantBorrowBookPage extends StatefulWidget {
  @override
  _YYMineWantBorrowBookPageState createState() => _YYMineWantBorrowBookPageState();
}

class _YYMineWantBorrowBookPageState extends State<YYMineWantBorrowBookPage> with AutomaticKeepAliveClientMixin<YYMineWantBorrowBookPage>,YYBaseState<YYMineWantBorrowBookPage>, YYBaseListState<YYMineWantBorrowBookPage>,YYBaseBookListState<YYMineWantBorrowBookPage>,
YYBaseBookRadioListState<YYMineWantBorrowBookPage> {

  @override
  remotePath() {
    return "/receipt/findWant";
  }

  @override
  String get buttonName => "借书";

  @override
  buttonOnPressed() {
    
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
        title:Text("我想借的"),
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