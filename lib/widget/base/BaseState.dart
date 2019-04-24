import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:lychee/common/manager/HttpManager.dart';
import 'package:lychee/common/util/CommonUtils.dart';
import 'package:lychee/common/event/NeedRefreshEvent.dart';
import 'package:lychee/widget/base/BaseWidget.dart';

mixin BaseState<T extends StatefulWidget> on State<T>, AutomaticKeepAliveClientMixin<T> {
  @protected
  bool isShow = false;

  @protected
  dynamic control;
  @protected
  StreamSubscription refreshEventStream;

  @override
  bool get wantKeepAlive => true;

  @protected
  dynamic get getData => null;

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
      control.data = jsonConvertToModel(data);
    } else if (data is List) {
      control.data = new List();
      for (int i = 0; i < data.length; i++) {
        control.data.add(jsonConvertToModel(data[i]));
      }
    }
  }

  @protected
  Future<Null> handleRefresh() async {
    if (control.isLoading) {
      return null;
    }
    if (isShow) {
      setState(() {
        control.isLoading = true;    
        control.errorMessage = "";  
      });
    }

    var params = generateRemoteParams();

    var res = await HttpManager.netFetch(context,remotePath(),params,null,null,noTip:true);

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
          control.errorMessage = res.data;        
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

  ///与刷新无关的网络请求
  @protected
  Future<ResultData> handleNotAssociatedWithRefreshRequest(String url, Map<String, dynamic> params) async {
    if (control.isLoading) {
      return new ResultData(null, false);
    }

    CommonUtils.showLoadingDialog(context);

    var res = await HttpManager.netFetch(context,url,params,null,null);
    Navigator.pop(context);

    return res;
  }

  @protected
  void initControl() {
    control = new BaseWidgetControl();
  }

  @protected
  void setControl() {
    control.data = getData;
  }

  @override
  void initState() {
    isShow = true;
    super.initState();
    initControl();
    setControl();

    needNetworkRequest().then((res) {
      if (res == true) {
        handleRefresh();
      } 
    });
    
    refreshEventStream =  CommonUtils.eventBus.on<NeedRefreshEvent>().listen((event) {
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
