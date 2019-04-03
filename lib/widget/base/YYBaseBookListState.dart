import 'package:flutter/material.dart';

import 'package:lychee/widget/base/YYBaseListState.dart';
import 'package:lychee/widget/base/YYBaseBookListWidget.dart';
import 'package:lychee/common/model/YYBookResult.dart';
import 'package:lychee/widget/YYBookItem.dart';
import 'package:lychee/common/util/YYCommonUtils.dart';
import 'package:lychee/common/model/YYBook.dart';
import 'package:lychee/page/YYBookDetailPage.dart';

mixin YYBaseBookListState<T extends StatefulWidget> on YYBaseListState<T>,AutomaticKeepAliveClientMixin<T>  {

  @override
  bool get needRefreshHeader => false;

  @override
  bool get needRefreshFooter => true;

  @protected
  String get categoryRemotePath => "/category/findAll";

  @protected
  String get libraryRemotePath => "/library/findMyself";

  @protected
  options() {
    int options = 0;
    options = options | YYBaseBookListWidgetControl.ShowCategory;
    options = options | YYBaseBookListWidgetControl.ShowLibrary;
    options = options | YYBaseBookListWidgetControl.ShowFrame;
    options = options | YYBaseBookListWidgetControl.ShowCount;
    return options;
  } 

  @override
  generateRemoteParams() {
    Map<String,dynamic> params = new Map();
    YYBaseBookListWidgetControl control = baseWidgetControl;
    if (control.options&YYBaseBookListWidgetControl.ShowCategory > 0) {
      params["category"] = control.cid;
    }
    if (control.options&YYBaseBookListWidgetControl.ShowLibrary > 0) {
      params["lid"] = control.lid.toInt();
    }
    if (control.options&YYBaseBookListWidgetControl.ShowFrame > 0) {
      params["fid"] =control.fid.toInt();
    }
    if (control.options&YYBaseBookListWidgetControl.ShowSearch > 0) {
      params["keyword"] = "";
    }
    
    params["last"] = control.last.toInt();
    params["offset"] = control.offset;
    return params;
  }

  @override
  generateMoreRemoteParams() {
    Map<String,dynamic> params = new Map();
    YYBaseBookListWidgetControl control = baseWidgetControl;
    if (control.options&YYBaseBookListWidgetControl.ShowCategory > 0) {
      params["category"] = control.cid;
    }
    if (control.options&YYBaseBookListWidgetControl.ShowLibrary > 0) {
      params["lid"] = control.lid.toInt();
    }
    if (control.options&YYBaseBookListWidgetControl.ShowFrame > 0) {
      params["fid"] =control.fid.toInt();
    }
    if (control.options&YYBaseBookListWidgetControl.ShowSearch > 0) {
      params["keyword"] = "";
    }
    params["last"] = control.last.toInt();
    params["offset"] = control.offset;
    return params;
  }

  @override
  jsonConvertToModel(Map<String,dynamic> json) {
    return YYBookResult.fromJson(json);
  }

  @override
  handleRefreshData(data) {
    if (data is Map) {
      YYBaseBookListWidgetControl control = baseWidgetControl;
      control.data = new List();
      YYBookResult bookResult = jsonConvertToModel(data);
      control.total = bookResult.total;
      control.last = bookResult.last;
      control.offset = bookResult.offset;
      control.hasNext = bookResult.hasNext;
      if (bookResult.list!=null&&bookResult.list.length>0) {
        control.data.addAll(bookResult.list);
      }
    } else if (data is List) {
      super.handleRefreshData(data);
    }
  }

  @override
  handleMoreData(data) {
    YYBaseBookListWidgetControl control = baseWidgetControl;
    if (data is Map) {
      YYBookResult bookResult = jsonConvertToModel(data);
      control.total = bookResult.total;
      control.last = bookResult.last;
      control.offset = bookResult.offset;
      control.hasNext = bookResult.hasNext;
      if (bookResult.list!=null&&bookResult.list.length>0) {
        control.data.addAll(bookResult.list);
      }
    } else if (data is List) {
      super.handleMoreData(data);
    }
  }

  @protected
  renderListItem(context,index) {
    YYBaseBookListWidgetControl control = baseWidgetControl;
    YYBook book = control.data[index];
    return YYBookItem(book:book,onPressed: (){
      YYCommonUtils.openPage(context, YYBookDetailPage({"lid":0,"uuid":book.uuid}));
    });
  }

  @override
  void initControl() {
    YYBaseBookListWidgetControl control = new YYBaseBookListWidgetControl();
    control.needHeader = needHeader;
    control.needRefreshHeader = needRefreshHeader;
    control.needRefreshFooter = needRefreshFooter;
    control.data = getData;
    control.options = options();
    control.categoryRemotePath = categoryRemotePath;
    control.libraryRemotePath = libraryRemotePath;
    baseWidgetControl = control;   
  }
}
