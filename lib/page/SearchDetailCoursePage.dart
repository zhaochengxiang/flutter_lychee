import 'package:flutter/material.dart';

import 'package:lychee/widget/base/BaseListState.dart';
import 'package:lychee/widget/base/BaseState.dart';
import 'package:lychee/widget/base/BaseListWidget.dart';
import 'package:lychee/common/model/Course.dart';
import 'package:lychee/widget/CourseItem.dart';
import './CourseDetailPage.dart';
import 'package:lychee/common/util/CommonUtils.dart';
import 'package:lychee/common/model/CourseResult.dart';
import './SearchDetailPage.dart';

class SearchDetailCoursePage extends StatefulWidget {
  @override
  _SearchDetailCoursePageState createState() => _SearchDetailCoursePageState();
}

class _SearchDetailCoursePageState extends State<SearchDetailCoursePage> with AutomaticKeepAliveClientMixin<SearchDetailCoursePage>,BaseState<SearchDetailCoursePage>, BaseListState<SearchDetailCoursePage> {
  
  int last = 0;
  int offset = 0;
  bool hasNext = false;

  @override
  bool get needRefreshHeader => false;

  @override
  remotePath() {
    return "/course/search";
  }

   @override
  jsonConvertToModel(Map<String,dynamic> json) {
    return CourseResult.fromJson(json);
  }

   @override
  generateRemoteParams() {
    Map<String,dynamic> params = new Map();
    params["category"] = SearchDetailModel.of(context).currentCid;
    params["keyword"] = SearchDetailModel.of(context).currentKeyword;
    
    params["last"] = 0;
    params["offset"] = 0;
    return params;
  }

  @override
  generateMoreRemoteParams() {
    Map<String,dynamic> params = new Map();
    params["category"] = SearchDetailModel.of(context).currentCid;
    params["keyword"] = SearchDetailModel.of(context).currentKeyword;
    
    params["last"] = last;
    params["offset"] = offset;
    return params;
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
  renderListItem(context,index) {
    Course course = control.data[index];
    return new CourseItem(course,onPressed: (){
      CommonUtils.openPage(context, CourseDetailPage({"uuid":course.uuid}));
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: BaseListWidget(
        control:control,
        onRefresh: handleRefresh,
        onLoadMore: onLoadMore,
        refreshKey: refreshIndicatorKey,
        emptyTip: "没有搜索到相关短课",
        itemBuilder: (BuildContext context, int index) => renderListItem(context,index),
      )
    );
  }
}