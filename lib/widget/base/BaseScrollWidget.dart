import 'package:flutter/material.dart';
import 'dart:io';

import 'package:lychee/common/style/Style.dart';
import "package:flutter_easyrefresh/easy_refresh.dart";
import 'package:lychee/widget/base/BaseWidget.dart';
import 'package:lychee/widget/base/BaseDecorationState.dart';

class BaseScrollWidget extends StatefulWidget {
  final Widget child;
  final BaseScrollWidgetControl control;
  final String emptyTip;
  final RefreshCallback onRefresh;
  final Key refreshKey;

  BaseScrollWidget({this.control, this.child, this.onRefresh, this.emptyTip, this.refreshKey});

  @override
  _BaseScrollWidgetState createState() => _BaseScrollWidgetState();
}

class _BaseScrollWidgetState extends State<BaseScrollWidget> with BaseDecorationState<BaseScrollWidget> {
  
  _BaseScrollWidgetState();

  final GlobalKey<RefreshHeaderState> _refreshHeaderKey = new GlobalKey<RefreshHeaderState>();

  @override
  Widget build(BuildContext context) {
     Widget decoration = buildDecoration(widget.control,widget.onRefresh,widget.emptyTip);
    if (decoration != null) return decoration; 

    return new EasyRefresh(
      key: widget.refreshKey,
      behavior: (Platform.isIOS)?ScrollOverBehavior():null,
      refreshHeader: ClassicsHeader(
        key: _refreshHeaderKey,
        refreshText: "下拉刷新",
        refreshReadyText: "释放刷新",
        refreshingText: "正在刷新...",
        refreshedText: "刷新结束",
        moreInfo: "更新于 %T",
        showMore: true,
        bgColor: Colors.white,
        textColor: Color(YYColors.primaryText),
        moreInfoColor: Color(YYColors.secondaryText),
      ),
      onRefresh:(widget.control.needRefreshHeader)?widget.onRefresh:null,
      loadMore:null,
      child: SingleChildScrollView(
        child: widget.child,
      ),
    );
  }
}
class BaseScrollWidgetControl extends BaseWidgetControl {
  bool needRefreshHeader = true;
}
