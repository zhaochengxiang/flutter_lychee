import 'package:flutter/material.dart';

import 'package:lychee/widget/base/BaseListState.dart';
import 'package:lychee/widget/base/BaseState.dart';
import 'package:lychee/widget/base/BaseListWidget.dart';
import 'package:lychee/common/model/Lesson.dart';
import './LessonDetailPage.dart';
import 'package:lychee/common/util/CommonUtils.dart';
import 'package:lychee/common/model/LessonResult.dart';
import 'package:lychee/widget/ScholarLessonItem.dart';

class ScholarLessonPage extends StatefulWidget {
  final int id;
  ScholarLessonPage(this.id);

  @override
  _ScholarLessonPageState createState() => _ScholarLessonPageState();
}

class _ScholarLessonPageState extends State<ScholarLessonPage> with AutomaticKeepAliveClientMixin<ScholarLessonPage>,BaseState<ScholarLessonPage>, BaseListState<ScholarLessonPage> {

  int last = 0;
  int offset = 0;
  bool hasNext = false;

  @override
  bool get needRefreshHeader => false;
  
  @override
  remotePath() {
    return "/lesson/findBySid";
  }

  @override
  jsonConvertToModel(Map<String,dynamic> json) {
    return LessonResult.fromJson(json);
  }

  @override
  generateRemoteParams() {
    return {"sid":widget.id,"keyword":"","last":0,"offset":0};
  }

  @override
  generateMoreRemoteParams() {
    return {"sid":widget.id,"keyword":"","last":last,"offset":offset};
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
    return new ScholarLessonItem(lesson,onPressed: (){
      CommonUtils.openPage(context, LessonDetailPage({"uuid":lesson.uuid}));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseListWidget(
      control:control,
      onRefresh: handleRefresh,
      onLoadMore: onLoadMore,
      refreshKey: refreshIndicatorKey,
      emptyTip: "没有搜索到相关小讲",
      itemBuilder: (BuildContext context, int index) => renderListItem(index),
    );
  }
}