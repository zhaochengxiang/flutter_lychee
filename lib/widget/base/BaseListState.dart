import 'package:flutter/material.dart';
import "package:flutter_easyrefresh/easy_refresh.dart";

import 'package:lychee/common/manager/HttpManager.dart';
import 'package:lychee/widget/base/BaseListWidget.dart';
import 'package:lychee/widget/base/BaseState.dart';

mixin BaseListState<T extends StatefulWidget> on BaseState<T>,AutomaticKeepAliveClientMixin<T>  {
  final GlobalKey<EasyRefreshState> refreshIndicatorKey = new GlobalKey<EasyRefreshState>();

  @protected
  bool get needHeader => false;

  @protected
  bool get needSlide => false;

  @protected
  List<Widget> slideActions(index) {
    return List();
  }

  @protected
  List<int> get canNotSlideRows => List();

  @protected
  bool get needRefreshHeader => true;

  @protected
  bool get needRefreshFooter => true;

  @protected
  generateMoreRemoteParams() {
    return null;
  }

  @protected
  handleMoreData(data) {
    if (data is List) {
      for (int i = 0; i < data.length; i++) {
        control.data.add(jsonConvertToModel(data[i]));
      }
    }
  }

  @protected
  Future<Null> onLoadMore() async {
    if (control.isLoading) {
      return null;
    }
    if (isShow) {
      setState(() {
        control.isLoading = true;
      });
    }

    var params = generateMoreRemoteParams();
    var res = await HttpManager.netFetch(remotePath(),params,null,null);

    if (res != null && res.result) {
      if (isShow) {
        setState(() {
          handleMoreData(res.data); 
        });
      }
    }

    if (isShow) {
      setState(() {
        control.isLoading = false;
      });
    }
    return null;
  }

  @override
  void initControl() {
    control = new BaseListWidgetControl();
  }

  @override
  void setControl() {
    super.setControl();
    control.needHeader = needHeader;
    control.needRefreshHeader = needRefreshHeader;
    control.needRefreshFooter = needRefreshFooter;
    control.needSlide = needSlide;
    control.slideActions = slideActions;
    control.canNotSlideRows = canNotSlideRows;
  }
}
