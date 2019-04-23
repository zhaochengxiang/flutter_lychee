import 'package:flutter/material.dart';

import 'package:lychee/widget/base/BaseListState.dart';
import 'package:lychee/widget/base/BaseState.dart';
import 'package:lychee/widget/base/BaseBookListState.dart';
import 'package:lychee/widget/base/BaseBookListWidget.dart';

class ScholarBookPage extends StatefulWidget {
  final int id;
  ScholarBookPage(this.id);
  
  @override
  _ScholarBookPageState createState() => _ScholarBookPageState();
}

class _ScholarBookPageState extends State<ScholarBookPage> with AutomaticKeepAliveClientMixin<ScholarBookPage>,BaseState<ScholarBookPage>, BaseListState<ScholarBookPage>,BaseBookListState<ScholarBookPage> {

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
    return "/book/findByScholar";
  }

   @override
  generateRemoteParams() {
    return {"sid":widget.id,"keyword":"","last":0,"offset":0};
  }

  @override
  generateMoreRemoteParams() {
    return {"sid":widget.id,"keyword":"","last":control.last,"offset":control.offset};
  }

  @override
  Widget build(BuildContext context) {
    return BaseBookListWidget(
      control:control,
      onRefresh: handleRefresh,
      onLoadMore: onLoadMore,
      refreshKey: refreshIndicatorKey,
      widgetName: widget.runtimeType.toString(),
      itemBuilder: (BuildContext context, int index) => renderListItem(index),
    );
  }
}