import 'package:flutter/material.dart';

import 'package:lychee/widget/base/BaseListState.dart';
import 'package:lychee/widget/base/BaseState.dart';
import 'package:lychee/widget/base/BaseListWidget.dart';
import 'package:lychee/common/model/Lesson.dart';
import 'package:lychee/widget/LessonItem.dart';
import './LessonDetailPage.dart';
import 'package:lychee/common/util/CommonUtils.dart';
import 'package:lychee/common/model/LessonResult.dart';
import './SearchDetailPage.dart';

class SearchDetailLessonPage extends StatefulWidget {
  final int cid;
  final String keyword;
  SearchDetailLessonPage(this.cid,this.keyword);
  @override
  _SearchDetailLessonPageState createState() => _SearchDetailLessonPageState();
}

class _SearchDetailLessonPageState extends State<SearchDetailLessonPage> with AutomaticKeepAliveClientMixin<SearchDetailLessonPage>,BaseState<SearchDetailLessonPage>, BaseListState<SearchDetailLessonPage> {

  int last = 0;
  int offset = 0;
  bool hasNext = false;

  @override
  bool get needRefreshHeader => false;
  
  @override
  remotePath() {
    return "/lesson/search";
  }

  @override
  jsonConvertToModel(Map<String,dynamic> json) {
    return LessonResult.fromJson(json);
  }

  @override
  generateRemoteParams() {
    Map<String,dynamic> params = new Map();
    params["category"] = widget.cid;
    params["keyword"] = widget.keyword;
    
    params["last"] = 0;
    params["offset"] = 0;
    return params;
  }

  @override
  generateMoreRemoteParams() {
    Map<String,dynamic> params = new Map();
    params["category"] = widget.cid;
    params["keyword"] = widget.keyword;
    
    params["last"] = last;
    params["offset"] = offset;
    return params;
  }

  @override
  handleRefreshData(data) {
    control.data = new List();
    LessonResult lessonResult = jsonConvertToModel(data);
    last = lessonResult.last;
    offset = lessonResult.offset;
    hasNext = lessonResult.hasNext;
    if (lessonResult.list!=null&&lessonResult.list.length>0) {
      control.data.addAll(lessonResult.list);
    }
  }

  @override
  handleMoreData(data) {
    LessonResult lessonResult = jsonConvertToModel(data);
    last = lessonResult.last;
    offset = lessonResult.offset;
    hasNext = lessonResult.hasNext;
    if (lessonResult.list!=null&&lessonResult.list.length>0) {
      control.data.addAll(lessonResult.list);
    }
  }

  @protected
  renderListItem(index) {
    Lesson lesson = control.data[index];
    return new LessonItem(lesson,onPressed: (){
      CommonUtils.openPage(context, LessonDetailPage({"uuid":lesson.uuid}));
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return new Scaffold(
      body: BaseListWidget(
        control:control,
        onRefresh: handleRefresh,
        onLoadMore: onLoadMore,
        refreshKey: refreshIndicatorKey,
        emptyTip: "没有搜索到相关小讲",
        itemBuilder: (BuildContext context, int index) => renderListItem(index),
      )
    );
  }
}