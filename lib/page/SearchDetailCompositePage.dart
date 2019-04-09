import 'package:flutter/material.dart';

import 'package:lychee/widget/base/BaseScrollSate.dart';
import 'package:lychee/widget/base/BaseScrollWidget.dart';
import 'package:lychee/widget/base/BaseState.dart';
import 'package:lychee/widget/LessonItem.dart';
import 'package:lychee/widget/CourseItem.dart';
import 'package:lychee/common/util/CommonUtils.dart';
import 'package:lychee/widget/BookGrid.dart';
import 'package:lychee/widget/SectionWdiget.dart';
import 'package:lychee/widget/SeparatorWidget.dart';
import 'package:lychee/common/model/Course.dart';
import 'package:lychee/common/model/Lesson.dart';
import 'package:lychee/common/model/SearchResult.dart';
import './LessonDetailPage.dart';
import './CourseDetailPage.dart';
import './BookDetailPage.dart';
import './SearchDetailPage.dart';

class SearchDetailCompositePage extends StatefulWidget {

  @override
  _SearchDetailCompositePageState createState() => new _SearchDetailCompositePageState();
}

class _SearchDetailCompositePageState extends State<SearchDetailCompositePage> with AutomaticKeepAliveClientMixin<SearchDetailCompositePage>,BaseState<SearchDetailCompositePage>, BaseScrollState<SearchDetailCompositePage>  {
  SearchResult searchResult;

  @override
  remotePath() {
    return "/search";
  }

  @override
  generateRemoteParams() {
    return {'cid':SearchDetailModel.of(context).currentCid,'keyword':SearchDetailModel.of(context).currentKeyword};
  }

   @override
  jsonConvertToModel(Map<String,dynamic> json) {
    return SearchResult.fromJson(json);
  }

  _buildChosenBookWidget() {
    if (searchResult == null) return new Container();

    var books = searchResult.bookList;

    return (books==null||books.length==0)?new Container():new Column(
      children: <Widget>[
        SectionWidget(
          title: "图书",
        ),
        new BookGrid(books,onPressed: (book){
          CommonUtils.openPage(context, BookDetailPage({"lid":0,"uuid":book.uuid}));
        }),
      ],
    );
  }

  _buildChosenLessonWidget() {
    if (searchResult == null) return new Container();

    var lessons = searchResult.lessonList;

    return (lessons==null||lessons.length==0)?new Container():new Column(
      children: <Widget>[
        SectionWidget(
          title: "小讲",
        ),
        new ListView.separated(
          shrinkWrap: true,
          physics: new NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index)=>SeparatorWidget(),
          itemBuilder: (context, index) {
            Lesson lesson = lessons[index];
            return new LessonItem(lesson,onPressed: (){
              CommonUtils.openPage(context, LessonDetailPage({"uuid":lesson.uuid}));
            });
          },
          itemCount: lessons.length,
        ),
      ],
    );
  }

  _buildChosenCourseWidget() {
    if (searchResult == null) return new Container();

    var courses = searchResult.courseList;

    return (courses==null||courses.length==0)?new Container():new Column(
      children: <Widget>[
        SectionWidget(
          title: "短课",
        ),
        new ListView.separated(
          shrinkWrap: true,
          physics: new NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index)=>SeparatorWidget(),
          itemBuilder: (context, index) {
            Course course = courses[index];
            return new CourseItem(course,onPressed: (){
              CommonUtils.openPage(context, CourseDetailPage({"uuid":course.uuid}));
            });
          },
          itemCount: courses.length,
        ),
      ],
    );
  }
  
  @override
  Widget build(BuildContext context) {
    searchResult = control.data;

    return new Scaffold(
      body: SafeArea(
        child: BaseScrollWidget(
          control:control,
          onRefresh:handleRefresh,
          refreshKey: refreshIndicatorKey,
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildChosenBookWidget(),
              _buildChosenLessonWidget(),
              _buildChosenCourseWidget(),
            ]
          ),
        ),
      ),
    );
  }
}
