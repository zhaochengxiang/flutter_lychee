import 'package:flutter/material.dart';
import "package:flutter_easyrefresh/easy_refresh.dart";

import 'package:lychee/common/manager/YYHttpManager.dart';
import 'package:lychee/widget/base/YYBaseListWidget.dart';
import 'package:lychee/widget/base/YYBaseState.dart';

mixin YYBaseListState<T extends StatefulWidget> on YYBaseState<T>,AutomaticKeepAliveClientMixin<T>  {
  final GlobalKey<EasyRefreshState> refreshIndicatorKey = new GlobalKey<EasyRefreshState>();

  @protected
  bool get needHeader => false;

  @protected
  bool get needSlide => false;

  @protected
  List<Widget> slideActions(context,index) {
    return List();
  }

  @protected
  bool get needRefreshHeader => true;

  @protected
  bool get needRefreshFooter => true;

  @protected
  generateMoreRemoteParams() {
    return null;
  }

  @override
  handleRefreshData(data) {
    control.data = new List();
    if (data is List) {
      for (int i = 0; i < data.length; i++) {
        control.data.add(jsonConvertToModel(data[i]));
      }
    }
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
    var res = await YYHttpManager.netFetch(remotePath(),params,null,null);

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
    control = new YYBaseListWidgetControl();
  }

  @override
  void setControl() {
    super.setControl();
    control.needHeader = needHeader;
    control.needRefreshHeader = needRefreshHeader;
    control.needRefreshFooter = needRefreshFooter;
    control.needSlide = needSlide;
    control.slideActions = slideActions;
  }
}
