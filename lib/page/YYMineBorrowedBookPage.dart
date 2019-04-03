import 'package:flutter/material.dart';

import 'package:lychee/widget/base/YYBaseListState.dart';
import 'package:lychee/widget/base/YYBaseState.dart';
import 'package:lychee/widget/base/YYBaseBookListState.dart';
import 'package:lychee/widget/base/YYBaseBookListWidget.dart';
import 'package:lychee/common/util/YYCommonUtils.dart';
import 'package:lychee/widget/base/YYBaseBookRadioListState.dart';
import 'package:lychee/widget/base/YYBaseBookRadioListWidget.dart';

class YYMineBorrowedBookPage extends StatefulWidget {
  @override
  _YYMineBorrowedBookPageState createState() => _YYMineBorrowedBookPageState();
}

class _YYMineBorrowedBookPageState extends State<YYMineBorrowedBookPage> with AutomaticKeepAliveClientMixin<YYMineBorrowedBookPage>,YYBaseState<YYMineBorrowedBookPage>, YYBaseListState<YYMineBorrowedBookPage>,YYBaseBookListState<YYMineBorrowedBookPage>,
YYBaseBookRadioListState<YYMineBorrowedBookPage> {

  @override
  remotePath() {
    return "/receipt/findBorrowed";
  }

  @override
  String get buttonName => "还书";

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
        title:Text("我借到的"),
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