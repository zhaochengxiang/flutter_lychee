import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:lychee/widget/base/BaseListState.dart';
import 'package:lychee/widget/base/BaseState.dart';
import 'package:lychee/widget/base/BaseBookListState.dart';
import 'package:lychee/widget/base/BaseBookListWidget.dart';
import 'package:lychee/common/util/CommonUtils.dart';
import 'package:lychee/common/model/ScholarResult.dart';
import 'package:lychee/common/model/Scholar.dart';
import 'package:lychee/widget/ScholarItem.dart';
import './ScholarPage.dart';

class MineFollowPage extends StatefulWidget {
  MineFollowPage();

  @override
  _MineFollowPageState createState() => _MineFollowPageState();
}

class _MineFollowPageState extends State<MineFollowPage> with AutomaticKeepAliveClientMixin<MineFollowPage>,BaseState<MineFollowPage>, BaseListState<MineFollowPage>,BaseBookListState<MineFollowPage> {

  @override
  bool get needCategory => false;

  @override
  bool get needFrame => false;

  @override
  bool get needLibrary => false;

  @override
  bool get needCount => true;

  @override
  bool get needSearch => true;

  @override
  bool get needSlide => true;

  @override
  List<Widget> slideActions(index) {
    return <Widget>[
      IconSlideAction(
        caption: '删除',
        color: Colors.red,
        icon: Icons.delete,
        onTap: () {
          _delete(index);
        },
      ),
    ];
  }

  _delete(index) async{
    Scholar scholar = control.data[index];

    var res = await handleNotAssociatedWithRefreshRequest(context, "/scholar/unfollow", {"id":scholar.id});

    if (res!=null && res.result) {
      if (isShow) {
        setState(() {
          control.data.removeAt(index);
          control.total--;
          Fluttertoast.showToast(msg: "取消关注成功",gravity: ToastGravity.CENTER);
        });
      }
    }
  }

  @override
  remotePath() {
    return "/scholar/searchMyFollow";
  }

  @override
  jsonConvertToModel(Map<String,dynamic> json) {
    return ScholarResult.fromJson(json);
  }

  @override
  handleRefreshData(data) {
    control.data = new List();
    ScholarResult scholarResult = jsonConvertToModel(data);
    control.last = scholarResult.last;
    control.offset = scholarResult.offset;
    control.hasNext = scholarResult.hasNext;
    control.total = scholarResult.total;
    if (scholarResult.list!=null&&scholarResult.list.length>0) {
      control.data.addAll(scholarResult.list);
    }
  }

  @override
  handleMoreData(data) {
    ScholarResult scholarResult = jsonConvertToModel(data);
    control.last = scholarResult.last;
    control.offset = scholarResult.offset;
    control.hasNext = scholarResult.hasNext;
    if (scholarResult.list!=null&&scholarResult.list.length>0) {
      control.data.addAll(scholarResult.list);
    }
  }

  @override
  String get unit => "位";

  @override
  renderListItem(index) {
    Scholar scholar = control.data[index];
    return new ScholarItem(scholar,onPressed: (){
      CommonUtils.openPage(context, ScholarPage(scholar.id));
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
        title:Text("我的关注"),
        centerTitle: true,
      ),
      body: BaseBookListWidget(
        control:control,
        onRefresh: handleRefresh,
        onLoadMore: onLoadMore,
        refreshKey: refreshIndicatorKey,
        widgetName: widget.runtimeType.toString(),
        emptyTip: "你还没有关注任何人",
        itemBuilder: (BuildContext context, int index) => renderListItem(index),
      )
    );
  }
}