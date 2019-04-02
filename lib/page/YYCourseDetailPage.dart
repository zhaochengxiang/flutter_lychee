import 'package:flutter/material.dart';

import 'package:lychee/widget/base/YYBaseState.dart';
import 'package:lychee/widget/base/YYBaseScrollSate.dart';
import 'package:lychee/widget/base/YYBaseScrollWidget.dart';
import 'package:lychee/common/model/YYCourse.dart';
import 'package:lychee/common/util/YYCommonUtils.dart';
import 'package:lychee/common/style/YYStyle.dart';
import 'package:lychee/widget/YYScholarItem.dart';
import 'package:lychee/widget/YYSeparatorWidget.dart';
import 'package:lychee/widget/YYSectionWdiget.dart';
import 'package:lychee/widget/YYCourseDetailItem.dart';
import 'package:lychee/common/model/YYLesson.dart';
import 'package:lychee/page/YYLessonDetailPage.dart';

class YYCourseDetailPage extends StatefulWidget {
  final Map params;
  YYCourseDetailPage(this.params) :super();

  @override
  _YYCourseDetailPageState createState() => _YYCourseDetailPageState();
}

class _YYCourseDetailPageState extends State<YYCourseDetailPage> with AutomaticKeepAliveClientMixin<YYCourseDetailPage>,YYBaseState<YYCourseDetailPage>, YYBaseScrollState<YYCourseDetailPage> {

  YYCourse course;

  @override
  remotePath() {
    return "/course/get";
  }

  @override
  generateRemoteParams() {
    return {"uuid":widget.params['uuid']};    
  }

  @override
  jsonConvertToModel(Map<String,dynamic> json) {
    return YYCourse.fromJson(json);
  }

  @override
  Widget build(BuildContext context) {
    course = baseWidgetControl.data;

    return new Scaffold(
      appBar: new AppBar(
        title:Text("短课详情"),
        centerTitle: true, 
        leading: FlatButton(
          padding: EdgeInsets.all(0), 
          child: Image.asset(YYCommonUtils.Local_Icon_prefix+"back.png",width: 18,height: 18),
          onPressed: (){
            YYCommonUtils.closePage(context);
          },
        ),
        actions: <Widget>[
          IconButton(
          icon: new Image.asset(YYCommonUtils.Local_Icon_prefix+"more.png",width: 24.0,height: 24.0),
          onPressed: () {

          })
        ]
      ),
      body: YYBaseScrollWidget(
        control:baseWidgetControl,
        onRefresh:handleRefresh,
        refreshKey: refreshIndicatorKey,
        child: (course==null)?new Container():new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            (course.title==null)?new Container(): new Padding(
              padding: EdgeInsets.all(10.5),
              child: Text(course.title,style:TextStyle(color: Color(YYColors.primaryText),fontSize: YYSize.large),overflow: TextOverflow.ellipsis,maxLines: 1)
            ),
            YYScholarItem(avatar: course.avatar,author: course.author,honor: course.honor,onPressed: (){

            }),
            YYSeparatorWidget(),
            (course.introduction==null||course.introduction.length==0)?new Container():Padding(
              padding: EdgeInsets.only(left: 10.5,right: 10.5),
              child: Text(course.introduction,style:TextStyle(color: Color(YYColors.primaryText),fontSize: YYSize.large,letterSpacing: 0,height:1.2))
            ),
            (course.lessonList==null||course.lessonList.length==0)?new Container():new Column(
              children: <Widget>[
                YYSectionWidget(title: "共"+course.lessonList.length.toString()+"讲"),
                new ListView.separated(
                  shrinkWrap: true,
                  physics: new NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index)=>YYSeparatorWidget(),
                  itemBuilder: (context, index) {
                    YYLesson lesson = course.lessonList[index];
                    return new YYCourseDetailItem(lesson,index,onPressed:() {
                      YYCommonUtils.openPage(context, YYLessonDetailPage({"uuid":lesson.uuid}));
                    });
                  },
                  itemCount: course.lessonList.length,
                ),
              ],
            ),
          ],
        )
      ),
    );
  }
}