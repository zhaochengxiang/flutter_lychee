import 'package:flutter/material.dart';
import "package:flutter_easyrefresh/easy_refresh.dart";

import 'package:lychee/common/manager/YYHttpManager.dart';
import 'package:lychee/widget/base/YYBaseListWidget.dart';
import 'package:lychee/widget/base/YYBaseState.dart';

mixin YYBaseListState<T extends StatefulWidget> on YYBaseState<T>,AutomaticKeepAliveClientMixin<T>  {
  final GlobalKey<EasyRefreshState> refreshIndicatorKey = new GlobalKey<EasyRefreshState>();

  final List dataList = new List();

  ///是否需要头部
  @protected
  bool get needHeader => false;

  @protected
  bool get needRefreshHeader => true;

  @protected
  bool get needRefreshFooter => true;

  List get getDataList => dataList;

  @protected
  generateMoreRemoteParams() {
    return null;
  }

  @override
  handleRefreshData(data) {
    YYBaseListWidgetControl control = baseWidgetControl;
    control.dataList.clear();
    if (data is List) {
      for (int i = 0; i < data.length; i++) {
        control.dataList.add(jsonConvertToModel(data[i]));
      }
    }
  }

  @protected
  handleMoreData(data) {
    YYBaseListWidgetControl control = baseWidgetControl;
    if (data is List) {
      for (int i = 0; i < data.length; i++) {
        control.dataList.add(jsonConvertToModel(data[i]));
      }
    }
  }

  @protected
  Future<Null> onLoadMore() async {
    if (baseWidgetControl.isLoading) {
      return null;
    }
    if (isShow) {
      setState(() {
        baseWidgetControl.isLoading = true;
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
        baseWidgetControl.isLoading = false;
      });
    }
    return null;
  }

  @override
  void initControl() {
    YYBaseListWidgetControl control = new YYBaseListWidgetControl();
    control.needHeader = needHeader;
    control.needRefreshHeader = needRefreshHeader;
    control.needRefreshFooter = needRefreshFooter;
    control.dataList = getDataList;
    baseWidgetControl = control;   
  }

}
