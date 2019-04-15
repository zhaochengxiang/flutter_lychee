import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:lychee/widget/base/BaseListState.dart';
import 'package:lychee/widget/base/BaseState.dart';
import 'package:lychee/widget/base/BaseBookListState.dart';
import 'package:lychee/widget/base/BaseBookListWidget.dart';
import 'package:lychee/common/util/CommonUtils.dart';
import 'package:lychee/common/model/Book.dart';

class MineWantReadBookPage extends StatefulWidget {
  @override
  _MineWantReadBookPageState createState() => _MineWantReadBookPageState();
}

class _MineWantReadBookPageState extends State<MineWantReadBookPage> with AutomaticKeepAliveClientMixin<MineWantReadBookPage>,BaseState<MineWantReadBookPage>, BaseListState<MineWantReadBookPage>,BaseBookListState<MineWantReadBookPage> {

  @override
  bool get needFrame => false;

  @override
  bool get needSlide => true;

  @override
  List<Widget> slideActions(context,index) {
    return <Widget>[
      IconSlideAction(
        caption: '删除',
        color: Colors.red,
        icon: Icons.delete,
        onTap: () {
          _delete(context, index);
        },
      ),
    ];
  }

  @override
  remotePath() {
    return "/label/searchWant";
  }

  @override
  String get categoryRemotePath => "/category/findWantRead";

  @override
  generateRemoteParams() {
    Map<String,dynamic> params = new Map();
    params["category"] = control.cid;
    params["lid"] = control.lid;
    params["state"] = 0;
    params["keyword"] = "";
    params["last"] = 0;
    params["offset"] = 0;
    return params;
  }

  @override
  generateMoreRemoteParams() {
    Map<String,dynamic> params = new Map();
    params["category"] = control.cid;
    params["lid"] = control.lid;
    params["state"] = 0;
    params["keyword"] = "";
    params["last"] = control.last;
    params["offset"] = control.offset;
    return params;
  }

  _delete(context,index) async{
    Book book = control.data[index];

    var res = await handleNotAssociatedWithRefreshRequest(context, "/label/deleteWant", {"bid":book.id});

    if (res!=null && res.result) {
      if (isShow) {
        setState(() {
          control.data.removeAt(index);
        });
      }
    }
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
        title:Text("我想读的"),
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