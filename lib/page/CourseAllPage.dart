import 'package:flutter/material.dart';

import 'package:lychee/widget/base/BaseListState.dart';
import 'package:lychee/widget/base/BaseState.dart';
import 'package:lychee/widget/base/BaseBookListState.dart';
import 'package:lychee/widget/base/BaseBookListWidget.dart';
import 'package:lychee/common/util/CommonUtils.dart';
import './SearchPage.dart';
import 'package:lychee/common/model/CourseResult.dart';
import 'package:lychee/common/model/Course.dart';
import 'package:lychee/widget/CourseItem.dart';
import './CourseDetailPage.dart';
import 'package:lychee/common/model/Search.dart';
import './SearchCoursePage.dart';

class CourseAllPage extends StatefulWidget {
  CourseAllPage();

  @override
  _CourseAllPageState createState() => _CourseAllPageState();
}

class _CourseAllPageState extends State<CourseAllPage> with AutomaticKeepAliveClientMixin<CourseAllPage>,BaseState<CourseAllPage>, BaseListState<CourseAllPage>,BaseBookListState<CourseAllPage> {

  @override
  bool get needFrame => false;

  @override
  bool get needLibrary => false;

  @override
  bool get needCount => false;

  @override
  remotePath() {
    return "/course/search";
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
  renderListItem(context,index) {
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
        title:Text("全部短课"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
          icon: new Image.asset(CommonUtils.Local_Icon_prefix+"search_gray.png",width: 18.0,height: 18.0),
          onPressed: () {
            CommonUtils.openPage(context, SearchPage(type: Search.SEARCH_COURSE,onPressed:(keyword) {
              CommonUtils.openPage(context, SearchCoursePage(keyword: keyword));
            }));
          })
        ],
      ),
      body: BaseBookListWidget(
        control:control,
        onRefresh: handleRefresh,
        onLoadMore: onLoadMore,
        refreshKey: refreshIndicatorKey,
        widgetName: widget.runtimeType.toString(),
        emptyTip: "没有搜索到相关短课",
        itemBuilder: (BuildContext context, int index) => renderListItem(context,index),
      )
    );
  }
}