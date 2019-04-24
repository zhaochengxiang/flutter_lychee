import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:lychee/widget/base/BaseListState.dart';
import 'package:lychee/widget/base/BaseListWidget.dart';
import 'package:lychee/widget/base/BaseState.dart';
import 'package:lychee/common/style/Style.dart';
import 'package:lychee/common/model/Frame.dart';

typedef FrameItemCallback = void Function(Frame frame);

class MineFrame extends StatefulWidget {

  final bool needSlide;
  final FrameItemCallback onPressed;
  MineFrame({this.needSlide=false,this.onPressed});

  @override
  State<MineFrame> createState() {
    return _MineFrameState();
  }
}

class _MineFrameState extends State<MineFrame>  with AutomaticKeepAliveClientMixin<MineFrame>,BaseState<MineFrame>, BaseListState<MineFrame> {

  @override
  bool get needHeader => true;

  @override
  bool get needRefreshHeader => false;

  @override
  bool get needRefreshFooter => false;

  @override
  bool get needSlide => widget.needSlide;

  @override
  List<Widget> slideActions(index) {
    return <Widget>[
      IconSlideAction(
        caption: '修改',
        color: Color(YYColors.primary),
        icon: Icons.edit,
        onTap: () {
          _modify(index);
        },
      ),
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

  _modify(index) {

  }

  _delete(index) async {
    Frame frame = control.data[index-1];

    var res = await handleNotAssociatedWithRefreshRequest("/frame/delete", {"id":frame.id});

    if (res!=null && res.result) {
      if (isShow) {
        setState(() {
          control.data.removeAt(index-1);
        });
      }
    }
  }

  @override
  remotePath() {
    return "/frame/findMy";
  }

  @override
  generateRemoteParams() {
    return {};
  }

  @override
  jsonConvertToModel(Map<String,dynamic> json) {
    return Frame.fromJson(json);
  }

  @override
  List<int> get canNotSlideRows => [0];

  _renderListItem(index) {
    Frame frame;
    if (index == 0) {
      frame = new Frame(1, 0, 0, "默认书架");
    } else {
      frame =control.data[index-1];
    }

    return InkWell( 
      child:Container(
        height: 47.0, 
        child: ListTile(
          title: Text(frame.name,style: TextStyle(color: Color(YYColors.primaryText),fontSize: YYSize.large), overflow: TextOverflow.ellipsis)
        )
      ),
      onTap: () {
        widget.onPressed?.call(frame);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: BaseListWidget(
        refreshKey: refreshIndicatorKey,
        control: control,
        itemBuilder:(BuildContext context, int index)=>_renderListItem(index),
      )
    );
  }
}