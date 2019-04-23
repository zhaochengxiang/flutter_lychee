import 'package:flutter/material.dart';

import 'package:lychee/widget/base/BaseListState.dart';
import 'package:lychee/widget/base/BaseState.dart';
import 'package:lychee/widget/base/BaseBookListState.dart';
import 'package:lychee/widget/base/BaseBookListWidget.dart';
import 'package:lychee/common/util/CommonUtils.dart';
import 'package:lychee/common/model/CourseResult.dart';
import 'package:lychee/common/model/Course.dart';
import 'package:lychee/widget/CourseItem.dart';
import './CourseDetailPage.dart';

class MineCoursePage extends StatefulWidget {
  MineCoursePage();

  @override
  _MineCoursePageState createState() => _MineCoursePageState();
}

class _MineCoursePageState extends State<MineCoursePage> with AutomaticKeepAliveClientMixin<MineCoursePage>,BaseState<MineCoursePage>, BaseListState<MineCoursePage>,BaseBookListState<MineCoursePage> {

  @override
  bool get needCategory => false;

  @override
  bool get needFrame => false;

  @override
  bool get needLibrary => false;

  @override
  bool get needCount => true;

  @override
  bool get needSearch => true;

  @override
  String get unit => "门";

  @override
  remotePath() {
    return "/course/findMy";
  }

  @override
  jsonConvertToModel(Map<String,dynamic> json) {
    return CourseResult.fromJson(json);
  }

  @override
  handleRefreshData(data) {
    control.data = new List();
    CourseResult courseResult = jsonConvertToModel(data);
    control.last = courseResult.last;
    control.offset = courseResult.offset;
    control.hasNext = courseResult.hasNext;
    control.total = courseResult.total;
    if (courseResult.list!=null&&courseResult.list.length>0) {
      control.data.addAll(courseResult.list);
    }
  }

  @override
  handleMoreData(data) {
    CourseResult courseResult = jsonConvertToModel(data);
    control.last = courseResult.last;
    control.offset = courseResult.offset;
    control.hasNext = courseResult.hasNext;
    if (courseResult.list!=null&&courseResult.list.length>0) {
      control.data.addAll(courseResult.list);
    }
  }

  @override
  renderListItem(index) {
    Course course = control.data[index];
    return new CourseItem(course,onPressed: (){
      CommonUtils.openPage(context, CourseDetailPage({"uuid":course.uuid}));
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        leading: IconButton(
          icon: new Image.asset(CommonUtils.Local_Icon_prefix+"back.png",width: 18.0,height: 18.0),
          onPressed: () {
            CommonUtils.closePage(context);
          }),
        title:Text("我的短课"),
        centerTitle: true,
      ),
      body: BaseBookListWidget(
        control:control,
        onRefresh: handleRefresh,
        onLoadMore: onLoadMore,
        refreshKey: refreshIndicatorKey,
        widgetName: widget.runtimeType.toString(),
        emptyTip: "没有搜索到相关短课",
        itemBuilder: (BuildContext context, int index) => renderListItem(index),
      )
    );
  }
}