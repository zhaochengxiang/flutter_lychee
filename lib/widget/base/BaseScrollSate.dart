import 'package:flutter/material.dart';

import "package:flutter_easyrefresh/easy_refresh.dart";
import 'package:lychee/widget/base/BaseState.dart';
import 'package:lychee/widget/base/BaseScrollWidget.dart';

mixin BaseScrollState<T extends StatefulWidget> on BaseState<T>,AutomaticKeepAliveClientMixin<T> {

  final GlobalKey<EasyRefreshState> refreshIndicatorKey = new GlobalKey<EasyRefreshState>();

  @protected
  bool get needRefreshHeader => false;

  @override
  void initControl() {
    control = new BaseScrollWidgetControl();
  }

  @override
  void setControl() {
    super.setControl();
    control.needRefreshHeader = needRefreshHeader;
  }
}
