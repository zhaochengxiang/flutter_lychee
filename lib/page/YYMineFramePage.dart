import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:lychee/widget/base/YYBaseListState.dart';
import 'package:lychee/widget/base/YYBaseListWidget.dart';
import 'package:lychee/widget/base/YYBaseState.dart';
import 'package:lychee/common/style/YYStyle.dart';
import 'package:lychee/common/model/YYFrame.dart';
import 'package:lychee/widget/YYSeparatorWidget.dart';

typedef FrameItemCallback = void Function(YYFrame frame);

class YYMineFramePage extends StatefulWidget {

  final FrameItemCallback onPressed;
  YYMineFramePage({this.onPressed});

  @override
  State<YYMineFramePage> createState() {
    return _YYMineFramePageState();
  }
}

class _YYMineFramePageState extends State<YYMineFramePage>  with AutomaticKeepAliveClientMixin<YYMineFramePage>,YYBaseState<YYMineFramePage>, YYBaseListState<YYMineFramePage> {

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
    return YYFrame.fromJson(json);
  }

  _renderListItem(index) {
    YYFrame frame;
    if (index == 0) {
      frame = new YYFrame(1, 0, 0, "默认书架");
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
            YYSeparatorWidget()
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
      child: YYBaseListWidget(
        refreshKey: refreshIndicatorKey,
        control: control,
        itemBuilder:(BuildContext context, int index)=>_renderListItem(index),
      )
    );
  }
}