import 'package:flutter/material.dart';

import 'package:lychee/widget/base/BaseListState.dart';
import 'package:lychee/widget/base/BaseState.dart';
import 'package:lychee/widget/base/BaseListWidget.dart';
import 'package:lychee/common/model/Course.dart';
import './CourseDetailPage.dart';
import 'package:lychee/common/util/CommonUtils.dart';
import 'package:lychee/common/model/CourseResult.dart';
import 'package:lychee/widget/ScholarCourseItem.dart';
import './SearchScholarPage.dart';

class ScholarCoursePage extends StatefulWidget {
  final int type;
  final int id;
  final String keyword;
  ScholarCoursePage({this.type=0,this.id,this.keyword=""});

  @override
  _ScholarCoursePageState createState() => _ScholarCoursePageState();
}

class _ScholarCoursePageState extends State<ScholarCoursePage> with AutomaticKeepAliveClientMixin<ScholarCoursePage>,BaseState<ScholarCoursePage>, BaseListState<ScholarCoursePage> {

  int last = 0;
  int offset = 0;
  bool hasNext = false;

  @override
  bool get needRefreshHeader => false;
  
  @override
  remotePath() {
    return "/course/findBySid";
  }

  @override
  jsonConvertToModel(Map<String,dynamic> json) {
    return CourseResult.fromJson(json);
  }

  @override
  generateRemoteParams() {
    return {"sid":widget.id,"keyword":(widget.type==0)?widget.keyword:SearchScholarModel.of(context).currentKeyword,"last":0,"offset":0};
  }

  @override
  generateMoreRemoteParams() {
    return {"sid":widget.id,"keyword":(widget.type==0)?widget.keyword:SearchScholarModel.of(context).currentKeyword,"last":last,"offset":offset};
  }

  @override
  handleRefreshData(data) {
    control.data = new List();
    CourseResult courseResult = jsonConvertToModel(data);
    last = courseResult.last;
    offset = courseResult.offset;
    hasNext = courseResult.hasNext;
    if (courseResult.list!=null&&courseResult.list.length>0) {
      control.data.addAll(courseResult.list);
    }
  }

  @override
  handleMoreData(data) {
    CourseResult courseResult = jsonConvertToModel(data);
    last = courseResult.last;
    offset = courseResult.offset;
    hasNext = courseResult.hasNext;
    if (courseResult.list!=null&&courseResult.list.length>0) {
      control.data.addAll(courseResult.list);
    }
  }

  @protected
  renderListItem(index) {
    Course course = control.data[index];
    return new ScholarCourseItem(course,onPressed: (){
      CommonUtils.openPage(context, CourseDetailPage({"uuid":course.uuid}));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseListWidget(
      control:control,
      onRefresh: handleRefresh,
      onLoadMore: onLoadMore,
      refreshKey: refreshIndicatorKey,
      emptyTip: "没有搜索到相关短课",
      itemBuilder: (BuildContext context, int index) => renderListItem(index),
    );
  }
}