import 'package:flutter/material.dart';

import 'package:lychee/widget/base/BaseDecorationState.dart';

class BaseWidget extends StatefulWidget {
  final Widget child;
  final BaseWidgetControl control;
  final String emptyTip;
  final RefreshCallback onRefresh;

  BaseWidget({this.child,this.control,this.emptyTip,this.onRefresh});

  @override
  _BaseWidgetState createState() => _BaseWidgetState();
}

class _BaseWidgetState extends State<BaseWidget> with BaseDecorationState<BaseWidget> {

  _BaseWidgetState();

  @override
  Widget build(BuildContext context) {
    Widget decoration = buildDecoration(widget.control,widget.onRefresh,widget.emptyTip);
    if (decoration != null) return decoration;

    return new Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: widget.child
    );
  }
}

class BaseWidgetControl {
  dynamic data;

  ///进入组件是否需要请求网络接口
  bool needNetworkRequest = false;
  ///是否正在加载
  bool isLoading = false;
  ///网络请求返回的错误信息
  String errorMessage = "";
}