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
    Map firstMap = control.indexPaths[0];
    ReceiptResult receiptResult = control.data[firstMap["section"]]; 
    List<Receipt> receipts =receiptResult.receiptList;

    List<int> ids = new List();
    control.indexPaths.forEach((map){
      Receipt receipt =receipts[map["row"]];
      ids.add(receipt.id);
    });
    
    QRCode qrCode = QRCode((receiptResult.personal==true)?QRCode.TYPE_RETURN_TO_PERSON:QRCode.TYPE_RETURN_TO_ORGANIZE, receiptResult.lid, ids);
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
        title:Text("我借到的"),
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