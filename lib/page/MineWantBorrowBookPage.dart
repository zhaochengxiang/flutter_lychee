import 'package:flutter/material.dart';

import 'package:lychee/widget/base/BaseListState.dart';
import 'package:lychee/widget/base/BaseState.dart';
import 'package:lychee/widget/base/BaseBookListState.dart';
import 'package:lychee/common/util/CommonUtils.dart';
import 'package:lychee/widget/base/BaseBookRadioListState.dart';
import 'package:lychee/widget/base/BaseBookRadioListWidget.dart';
import 'package:lychee/common/model/QRCode.dart';
import 'package:lychee/common/model/ReceiptResult.dart';
import 'package:lychee/common/model/Receipt.dart';
import './QRCodePage.dart';

class MineWantBorrowBookPage extends StatefulWidget {
  @override
  _MineWantBorrowBookPageState createState() => _MineWantBorrowBookPageState();
}

class _MineWantBorrowBookPageState extends State<MineWantBorrowBookPage> with AutomaticKeepAliveClientMixin<MineWantBorrowBookPage>,BaseState<MineWantBorrowBookPage>, BaseListState<MineWantBorrowBookPage>,BaseBookListState<MineWantBorrowBookPage>,
BaseBookRadioListState<MineWantBorrowBookPage> {

  @override
  remotePath() {
    return "/receipt/findWant";
  }

  @override
  String get buttonName => "借书";

  @override
  buttonOnPressed() {
    Map firstMap = control.indexPaths[0];
    ReceiptResult receiptResult = control.data[firstMap["section"]]; 
    List<Receipt> receipts =receiptResult.receiptList;

    List<int> ids = new List();
    control.indexPaths.forEach((map){
      Receipt receipt =receipts[map["row"]];
      ids.add(receipt.id);
    });
    
    QRCode qrCode = QRCode((receiptResult.personal==true)?QRCode.TYPE_BORROW_FROM_PERSON:QRCode.TYPE_BORROW_FROM_ORGANIZE, receiptResult.lid, ids);
    CommonUtils.openPage(context, QRCodePage(qrCode));
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
        title:Text("我想借的"),
        centerTitle: true,
      ),
      body: BaseBookRadioListWidget(
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