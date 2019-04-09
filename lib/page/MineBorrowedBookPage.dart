import 'package:flutter/material.dart';

import 'package:lychee/widget/base/BaseListState.dart';
import 'package:lychee/widget/base/BaseState.dart';
import 'package:lychee/widget/base/BaseBookListState.dart';
import 'package:lychee/widget/base/BaseBookListWidget.dart';
import 'package:lychee/common/util/CommonUtils.dart';
import 'package:lychee/widget/base/BaseBookRadioListState.dart';
import 'package:lychee/widget/base/BaseBookRadioListWidget.dart';

class MineBorrowedBookPage extends StatefulWidget {
  @override
  _MineBorrowedBookPageState createState() => _MineBorrowedBookPageState();
}

class _MineBorrowedBookPageState extends State<MineBorrowedBookPage> with AutomaticKeepAliveClientMixin<MineBorrowedBookPage>,BaseState<MineBorrowedBookPage>, BaseListState<MineBorrowedBookPage>,BaseBookListState<MineBorrowedBookPage>,
BaseBookRadioListState<MineBorrowedBookPage> {

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
          icon: new Image.asset(CommonUtils.Local_Icon_prefix+"back.png",width: 18.0,height: 18.0),
          onPressed: () {
            CommonUtils.closePage(context);
          }),
        title:Text("我借到的"),
        centerTitle: true,
      ),
      body: BaseBookRadioListWidget(
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