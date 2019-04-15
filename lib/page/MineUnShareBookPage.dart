import 'package:flutter/material.dart';

import 'package:lychee/widget/base/BaseListState.dart';
import 'package:lychee/widget/base/BaseState.dart';
import 'package:lychee/widget/base/BaseBookListState.dart';
import 'package:lychee/common/util/CommonUtils.dart';
import 'package:lychee/widget/base/BaseBookRadioListState.dart';
import 'package:lychee/widget/base/BaseBookRadioListWidget.dart';
import 'package:lychee/common/model/BookResult.dart';
import 'package:lychee/widget/BookRadioItem.dart';

class MineUnShareBookPage extends StatefulWidget {

  final int lid;
  MineUnShareBookPage(this.lid);
  @override
  _MineUnShareBookPageState createState() => _MineUnShareBookPageState();
}

class _MineUnShareBookPageState extends State<MineUnShareBookPage> with AutomaticKeepAliveClientMixin<MineUnShareBookPage>,BaseState<MineUnShareBookPage>, BaseListState<MineUnShareBookPage>,BaseBookListState<MineUnShareBookPage>,
BaseBookRadioListState<MineUnShareBookPage> {

  List<int> indexs = new List();

  @override
  bool get needCategory => true;
  
  @override
  bool get needCount => true;

  @override
  remotePath() {
    return "/copy/findMyUnShare";
  }

  @override
  String get buttonName => "确定共享";

  @override
  buttonOnPressed() {
   
  }

  @override
  generateRemoteParams() {
    Map<String,dynamic> params = new Map();
    params["category"] = control.cid;
    params["lid"] = control.lid;
    params["keyword"] = control.keyword;    
    params["last"] = 0;
    params["offset"] = 0;
    return params;
  }

  @override
  generateMoreRemoteParams() {
    Map<String,dynamic> params = new Map();
    params["category"] = control.cid;
    params["lid"] = control.lid;
    params["keyword"] = control.keyword; 
    params["last"] = control.last;
    params["offset"] = control.offset;
    return params;
  }

  @override
  jsonConvertToModel(Map<String,dynamic> json) {
    return BookResult.fromJson(json);
  }

  @override
  void setControl() {
    super.setControl();
    control.lid = widget.lid;
  }

  @protected
  renderListItem(index) {
    return BookRadioItem(type:BookRadioItem.TYPE_BOOK,book: control.data[index],isSelected: (indexs.contains(index)),onPressed: (){
      if (indexs.contains(index)) {
        setState(() {
          indexs.remove(index);
        });
      } else {
        setState(() {
          indexs.add(index);
        });
      }
    });
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
        title:Text("选择图书共享"),
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