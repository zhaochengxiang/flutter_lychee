import 'package:flutter/material.dart';

import 'package:lychee/widget/base/BaseListState.dart';
import 'package:lychee/widget/base/BaseState.dart';
import 'package:lychee/widget/base/BaseBookListState.dart';
import 'package:lychee/widget/base/BaseBookListWidget.dart';

class SearchDetailBookPage extends StatefulWidget {
    
  final int cid;
  final String keyword;
  SearchDetailBookPage(this.cid,this.keyword);
  @override
  _SearchDetailBookPageState createState() => _SearchDetailBookPageState();
}

class _SearchDetailBookPageState extends State<SearchDetailBookPage> with AutomaticKeepAliveClientMixin<SearchDetailBookPage>,BaseState<SearchDetailBookPage>, BaseListState<SearchDetailBookPage>,BaseBookListState<SearchDetailBookPage> {

  @override
  bool get needCategory => false;

  @override
  bool get needLibrary => false;

  @override
  bool get needFrame => false;

  @override
  bool get needCount => false;

  @override
  bool get needSearch => false;
  
  @override
  remotePath() {
    return "/book/search";
  }

   @override
  generateRemoteParams() {
    Map<String,dynamic> params = new Map();
    params["category"] = widget.cid;
    params["lid"] = 0;
    params["keyword"] = widget.keyword;
    
    params["last"] = 0;
    params["offset"] = 0;
    return params;
  }

  @override
  generateMoreRemoteParams() {
    Map<String,dynamic> params = new Map();
    params["category"] = widget.cid;
    params["lid"] = 0;
    params["keyword"] = widget.keyword;
    
    params["last"] = control.last;
    params["offset"] = control.offset;
    return params;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return new Scaffold(
      body: BaseBookListWidget(
        control:control,
        onRefresh: handleRefresh,
        onLoadMore: onLoadMore,
        refreshKey: refreshIndicatorKey,
        widgetName: widget.runtimeType.toString(),
        itemBuilder: (BuildContext context, int index) => renderListItem(index),
      )
    );
  }
}