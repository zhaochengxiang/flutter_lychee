import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:lychee/widget/base/BaseListState.dart';
import 'package:lychee/widget/base/BaseListWidget.dart';
import 'package:lychee/widget/base/BaseState.dart';
import 'package:lychee/common/style/Style.dart';
import 'package:lychee/common/model/Frame.dart';
import 'package:lychee/widget/SeparatorWidget.dart';

typedef FrameItemCallback = void Function(Frame frame);

class MineFramePage extends StatefulWidget {

  final FrameItemCallback onPressed;
  MineFramePage({this.onPressed});

  @override
  State<MineFramePage> createState() {
    return _MineFramePageState();
  }
}

class _MineFramePageState extends State<MineFramePage>  with AutomaticKeepAliveClientMixin<MineFramePage>,BaseState<MineFramePage>, BaseListState<MineFramePage> {

  @override
  bool get needHeader => true;

  @override
  bool get needRefreshHeader => false;

  @override
  bool get needRefreshFooter => false;

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

  _renderListItem(index) {
    Frame frame;
    if (index == 0) {
      frame = new Frame(1, 0, 0, "默认书架");
    } else {
      frame =control.data[index-1];
    }

    return FlatButton( 
      padding: EdgeInsets.all(0),
      child:Container(
        height: 47.0, 
        child:new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child:ListTile(
                title: Text(frame.name,style: TextStyle(color: Color(YYColors.primaryText),fontSize: YYSize.large), overflow: TextOverflow.ellipsis)
              )
            ),
            SeparatorWidget()
          ],
        )
      ),
      onPressed: () {
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