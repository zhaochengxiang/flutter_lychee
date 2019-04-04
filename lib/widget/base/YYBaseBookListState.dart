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
  bool get needCategory => true;

  @protected
  bool get needLibrary => true;

  @protected
  bool get needFrame => true;

  @protected
  bool get needCount => true;

  @protected
  bool get needSearch => true;

  @protected
  String get categoryRemotePath => "/category/findAll";

  @protected
  String get libraryRemotePath => "/library/findMyself";

  @override
  generateRemoteParams() {
    Map<String,dynamic> params = new Map();
    if (control.needCategory) {
      params["category"] = control.cid;
    }
    if (control.needLibrary) {
      params["lid"] = control.lid.toInt();
    }
    if (control.needFrame) {
      params["fid"] =control.fid.toInt();
    }
    if (control.needSearch) {
      params["keyword"] = "";
    }
    
    params["last"] = control.last.toInt();
    params["offset"] = control.offset;
    return params;
  }

  @override
  generateMoreRemoteParams() {
    Map<String,dynamic> params = new Map();
    if (control.needCategory) {
      params["category"] = control.cid;
    }
    if (control.needLibrary) {
      params["lid"] = control.lid.toInt();
    }
    if (control.needFrame) {
      params["fid"] =control.fid.toInt();
    }
    if (control.needSearch) {
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
    YYBook book = control.data[index];
    return YYBookItem(book:book,onPressed: (){
      YYCommonUtils.openPage(context, YYBookDetailPage({"lid":0,"uuid":book.uuid}));
    });
  }

  @override
  void initControl() {
    control = new YYBaseBookListWidgetControl();
  }

  @override
  void setControl() {
    super.setControl();
    control.needCategory = needCategory;
    control.needLibrary = needLibrary;
    control.needFrame = needFrame;
    control.needCount = needCount;
    control.needSearch = needSearch;
    control.categoryRemotePath = categoryRemotePath;
    control.libraryRemotePath = libraryRemotePath;
  }
}
