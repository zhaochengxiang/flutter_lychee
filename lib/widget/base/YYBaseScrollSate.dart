import 'package:flutter/material.dart';

import "package:flutter_easyrefresh/easy_refresh.dart";
import 'package:lychee/widget/base/YYBaseState.dart';
import 'package:lychee/widget/base/YYBaseScrollWidget.dart';

mixin YYBaseScrollState<T extends StatefulWidget> on YYBaseState<T>,AutomaticKeepAliveClientMixin<T> {

  final GlobalKey<EasyRefreshState> refreshIndicatorKey = new GlobalKey<EasyRefreshState>();

  @protected
  bool get needRefreshHeader => false;

  @override
  void initControl() {
    control = new YYBaseScrollWidgetControl();
  }

  @override
  void setControl() {
    super.setControl();
    control.needRefreshHeader = needRefreshHeader;
  }
}
