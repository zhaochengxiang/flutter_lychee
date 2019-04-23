import 'package:flutter/material.dart';

import 'package:lychee/widget/base/BaseScrollState.dart';
import 'package:lychee/widget/base/BaseScrollWidget.dart';
import 'package:lychee/widget/base/BaseState.dart';
import 'package:lychee/widget/ScholarLessonItem.dart';
import 'package:lychee/widget/ScholarCourseItem.dart';
import 'package:lychee/common/util/CommonUtils.dart';
import 'package:lychee/widget/BookGrid.dart';
import 'package:lychee/widget/SectionWdiget.dart';
import 'package:lychee/widget/SeparatorWidget.dart';
import 'package:lychee/common/model/Course.dart';
import 'package:lychee/common/model/Lesson.dart';
import 'package:lychee/common/model/Scholar.dart';
import './LessonDetailPage.dart';
import './CourseDetailPage.dart';
import './BookDetailPage.dart';
import 'package:lychee/common/style/Style.dart';

class ScholarHomePage extends StatefulWidget {

  final int id;
  ScholarHomePage(this.id);

  @override
  _ScholarHomePageState createState() => new _ScholarHomePageState();
}

class _ScholarHomePageState extends State<ScholarHomePage> with AutomaticKeepAliveClientMixin<ScholarHomePage>,BaseState<ScholarHomePage>, BaseScrollState<ScholarHomePage>  {
  Scholar scholar;

  @override
  remotePath() {
    return "/scholar/get";
  }

  @override
  generateRemoteParams() {
    return {"id":widget.id};
  }

   @override
  jsonConvertToModel(Map<String,dynamic> json) {
    return Scholar.fromJson(json);
  }

  _buildChosenBookWidget() {
    if (scholar == null) return new Container();

    var books = scholar.bookList;

    return (books==null||books.length==0)?new Container():new Column(
      children: <Widget>[
        SectionWidget(
          title: "TA的图书",
        ),
        new BookGrid(books,onPressed: (book){
          CommonUtils.openPage(context, BookDetailPage({"lid":0,"uuid":book.uuid}));
        }),
      ],
    );
  }

  _buildChosenLessonWidget() {
    if (scholar == null) return new Container();

    var lessons = scholar.lessonList;

    return (lessons==null||lessons.length==0)?new Container():new Column(
      children: <Widget>[
        SectionWidget(
          title: "TA的小讲",
        ),
        new ListView.separated(
          shrinkWrap: true,
          physics: new NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          separatorBuilder: (context, index)=>SeparatorWidget(),
          itemBuilder: (context, index) {
            Lesson lesson = lessons[index];
            return new ScholarLessonItem(lesson,onPressed: (){
              CommonUtils.openPage(context, LessonDetailPage({"uuid":lesson.uuid}));
            });
          },
          itemCount: lessons.length,
        ),
      ],
    );
  }

  _buildChosenCourseWidget() {
    if (scholar == null) return new Container();

    var courses = scholar.courseList;

    return (courses==null||courses.length==0)?new Container():new Column(
      children: <Widget>[
        SectionWidget(
          title: "TA的短课",
        ),
        new ListView.separated(
          shrinkWrap: true,
          physics: new NeverScrollableScrollPhysics(),
          padding:EdgeInsets.zero,
          separatorBuilder: (context, index)=>SeparatorWidget(),
          itemBuilder: (context, index) {
            Course course = courses[index];
            return new ScholarCourseItem(course,onPressed: (){
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
    scholar = control.data;

    return BaseScrollWidget(
          control:control,
          onRefresh:handleRefresh,
          refreshKey: refreshIndicatorKey,
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              (scholar==null||scholar.resume==null||scholar.resume.length==0)?new Container():new Padding(
                  padding: EdgeInsets.only(left: 10.5,right: 10.5),
                  child: Text(scholar.resume,style:TextStyle(color: Color(YYColors.primaryText),fontSize: YYSize.large,letterSpacing: 0,height:1.2)),
              ),
              _buildChosenBookWidget(),
              _buildChosenLessonWidget(),
              _buildChosenCourseWidget(),
            ]
          ),
        );
  }
}
