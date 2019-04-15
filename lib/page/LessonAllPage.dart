import 'package:flutter/material.dart';

import 'package:lychee/widget/base/BaseListState.dart';
import 'package:lychee/widget/base/BaseState.dart';
import 'package:lychee/widget/base/BaseBookListState.dart';
import 'package:lychee/widget/base/BaseBookListWidget.dart';
import 'package:lychee/common/util/CommonUtils.dart';
import './SearchPage.dart';
import 'package:lychee/common/model/LessonResult.dart';
import 'package:lychee/common/model/Lesson.dart';
import 'package:lychee/widget/LessonItem.dart';
import './LessonDetailPage.dart';
import 'package:lychee/common/model/Search.dart';
import './SearchLessonPage.dart';

class LessonAllPage extends StatefulWidget {
  @override
  _LessonAllPageState createState() => _LessonAllPageState();
}

class _LessonAllPageState extends State<LessonAllPage> with AutomaticKeepAliveClientMixin<LessonAllPage>,BaseState<LessonAllPage>, BaseListState<LessonAllPage>,BaseBookListState<LessonAllPage> {

  @override
  bool get needFrame => false;

  @override
  bool get needLibrary => false;

  @override
  bool get needCount => false;

  @override
  remotePath() {
    return "/lesson/search";
  }

  @override
  jsonConvertToModel(Map<String,dynamic> json) {
    return LessonResult.fromJson(json);
  }

  @override
  handleRefreshData(data) {
    control.data = new List();
    LessonResult lessonResult = jsonConvertToModel(data);
    control.last = lessonResult.last;
    control.offset = lessonResult.offset;
    control.hasNext = lessonResult.hasNext;
    if (lessonResult.list!=null&&lessonResult.list.length>0) {
      control.data.addAll(lessonResult.list);
    }
  }

  @override
  handleMoreData(data) {
    LessonResult lessonResult = jsonConvertToModel(data);
    control.last = lessonResult.last;
    control.offset = lessonResult.offset;
    control.hasNext = lessonResult.hasNext;
    if (lessonResult.list!=null&&lessonResult.list.length>0) {
      control.data.addAll(lessonResult.list);
    }
  }

  @override
  renderListItem(index) {
    Lesson lesson = control.data[index];
    return new LessonItem(lesson,onPressed: (){
      CommonUtils.openPage(context, LessonDetailPage({"uuid":lesson.uuid}));
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
        title:Text("全部小讲"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
          icon: new Image.asset(CommonUtils.Local_Icon_prefix+"search_gray.png",width: 18.0,height: 18.0),
          onPressed: () {
            CommonUtils.openPage(context, SearchPage(type: Search.SEARCH_LESSON,onPressed:(keyword) {
              CommonUtils.openPage(context, SearchLessonPage(keyword: keyword));
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
        emptyTip: "没有搜索到相关小讲",
        itemBuilder: (BuildContext context, int index) => renderListItem(index),
      )
    );
  }
}