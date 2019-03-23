import 'package:flutter/material.dart';

import 'package:lychee/common/style/YYStyle.dart';
import "package:flutter_easyrefresh/easy_refresh.dart";
import 'package:lychee/widget/base/YYBaseWidget.dart';
import 'package:lychee/widget/base/YYBaseDecorationState.dart';

class YYBaseScrollWidget extends StatefulWidget {
  final Widget child;
  final YYBaseScrollWidgetControl control;
  final String emptyTip;
  final RefreshCallback onRefresh;
  final Key refreshKey;

  YYBaseScrollWidget({this.control, this.child, this.onRefresh, this.emptyTip, this.refreshKey});

  @override
  _YYBaseScrollWidgetState createState() => _YYBaseScrollWidgetState();
}

class _YYBaseScrollWidgetState extends State<YYBaseScrollWidget> with YYBaseDecorationState<YYBaseScrollWidget> {
  
  _YYBaseScrollWidgetState();

  final GlobalKey<RefreshHeaderState> _refreshHeaderKey = new GlobalKey<RefreshHeaderState>();

  @override
  Widget build(BuildContext context) {
     Widget decoration = buildDecoration(widget.control,widget.onRefresh,widget.emptyTip);
    if (decoration != null) return decoration; 

    return new EasyRefresh(
      ///GlobalKey，用户外部获取RefreshIndicator的State，做显示刷新
      key: widget.refreshKey,
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
class YYBaseScrollWidgetControl extends YYBaseWidgetControl {
  bool needRefreshHeader = true;
}
