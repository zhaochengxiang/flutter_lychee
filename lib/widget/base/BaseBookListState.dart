import 'package:flutter/material.dart';

import 'package:lychee/widget/base/BaseListState.dart';
import 'package:lychee/widget/base/BaseBookListWidget.dart';
import 'package:lychee/common/model/BookResult.dart';
import 'package:lychee/widget/BookItem.dart';
import 'package:lychee/common/util/CommonUtils.dart';
import 'package:lychee/common/model/Book.dart';
import 'package:lychee/page/BookDetailPage.dart';

mixin BaseBookListState<T extends StatefulWidget> on BaseListState<T>,AutomaticKeepAliveClientMixin<T>  {

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
      params["lid"] = control.lid;
    }
    if (control.needFrame) {
      params["fid"] =control.fid;
    }
    if (control.needSearch) {
      params["keyword"] = "";
    }
    
    params["last"] = 0;
    params["offset"] = 0;
    return params;
  }

  @override
  generateMoreRemoteParams() {
    Map<String,dynamic> params = new Map();
    if (control.needCategory) {
      params["category"] = control.cid;
    }
    if (control.needLibrary) {
      params["lid"] = control.lid;
    }
    if (control.needFrame) {
      params["fid"] =control.fid;
    }
    if (control.needSearch) {
      params["keyword"] = "";
    }
    params["last"] = control.last;
    params["offset"] = control.offset;
    return params;
  }

  @override
  jsonConvertToModel(Map<String,dynamic> json) {
    return BookResult.fromJson(json);
  }

  @override
  handleRefreshData(data) {
    if (data is Map) {
      control.data = new List();
      BookResult bookResult = jsonConvertToModel(data);
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
      BookResult bookResult = jsonConvertToModel(data);
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
    Book book = control.data[index];
    return BookItem(book:book,onPressed: (){
      CommonUtils.openPage(context, BookDetailPage({"lid":0,"uuid":book.uuid}));
    });
  }

  @override
  void initControl() {
    control = new BaseBookListWidgetControl();
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
