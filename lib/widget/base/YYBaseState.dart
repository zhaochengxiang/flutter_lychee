import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:lychee/common/manager/YYHttpManager.dart';
import 'package:lychee/common/util/YYCommonUtils.dart';
import 'package:lychee/common/event/YYNeedRefreshEvent.dart';
import 'package:lychee/widget/base/YYBaseWidget.dart';

mixin YYBaseState<T extends StatefulWidget> on State<T>, AutomaticKeepAliveClientMixin<T> {
  @protected
  bool isShow = false;

  @protected
  YYBaseWidgetControl baseWidgetControl;
  @protected
  final dynamic data = null;
  @protected
  StreamSubscription refreshEventStream;

  ///是否需要保持
  @override
  bool get wantKeepAlive => true;

  @protected
  dynamic get getData => data;

  @protected
  Future<bool> needNetworkRequest() async {
    return true;
  }

  @protected
  remotePath() {
    return "";
  }

  @protected
  generateRemoteParams() {
    return null;
  }

  @protected
  jsonConvertToModel(Map<String,dynamic> json) {
    return null;
  }

  @protected
  handleRefreshData(data) {
    if (data is Map) {
      baseWidgetControl.data = jsonConvertToModel(data);
    } else if (data is List) {
      baseWidgetControl.data = new List();
      for (int i = 0; i < data.length; i++) {
        baseWidgetControl.data.add(jsonConvertToModel(data[i]));
      }
    }
  }

  @protected
  Future<Null> handleRefresh() async {
    if (baseWidgetControl.isLoading) {
      return null;
    }
    if (isShow) {
      setState(() {
        baseWidgetControl.isLoading = true;    
        baseWidgetControl.errorMessage = "";  
      });
    }

    var params = generateRemoteParams();

    var res = await YYHttpManager.netFetch(remotePath(),params,null,null,noTip:true);

    if (res != null && res.result) {
      var data = res.data;
      if (isShow) {
        setState(() {
          handleRefreshData(data);
        });
      }
    } else if (res != null && !res.result) {
      if (isShow) {
        setState(() {
          baseWidgetControl.errorMessage = res.data;        
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

  ///与刷新无关的网络请求
  @protected
  Future<YYResultData> handleNotAssociatedWithRefreshRequest(BuildContext context,String url, Map<String, dynamic> params) async {
    if (baseWidgetControl.isLoading) {
      return new YYResultData(null, false);
    }

    YYCommonUtils.showLoadingDialog(context);

    var res = await YYHttpManager.netFetch(url,params,null,null);
    Navigator.pop(context);

    return res;
  }

  @protected
  void initControl() {
    baseWidgetControl = new YYBaseWidgetControl();
    baseWidgetControl.data = getData;
  }

  @override
  void initState() {
    isShow = true;
    super.initState();
    initControl();

    needNetworkRequest().then((res) {
      if (res == true) {
        handleRefresh();
      } 
    });
    
    refreshEventStream =  YYCommonUtils.eventBus.on<YYNeedRefreshEvent>().listen((event) {
      refreshHandleFunction(event.className);
    });
  }

  @protected
  refreshHandleFunction(String name) {
    if (name == this.widget.runtimeType.toString()) {
      handleRefresh();
    }
  }

  @override
  void dispose() {
    isShow = false;
    super.dispose();
    if(refreshEventStream != null) {
      refreshEventStream.cancel();
      refreshEventStream = null;
    }
  }
}
