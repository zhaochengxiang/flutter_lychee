import 'package:flutter/material.dart';

import 'package:lychee/widget/base/YYBaseDecorationState.dart';

class YYBaseWidget extends StatefulWidget {
  final Widget child;
  final YYBaseWidgetControl control;
  final String emptyTip;
  final RefreshCallback onRefresh;

  YYBaseWidget({this.child,this.control,this.emptyTip,this.onRefresh});

  @override
  _YYBaseWidgetState createState() => _YYBaseWidgetState();
}

class _YYBaseWidgetState extends State<YYBaseWidget> with YYBaseDecorationState<YYBaseWidget> {

  _YYBaseWidgetState();

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

class YYBaseWidgetControl {
  dynamic data;

  ///是否正在加载
  bool isLoading = false;
  ///网络请求返回的错误信息
  String errorMessage = "";
}