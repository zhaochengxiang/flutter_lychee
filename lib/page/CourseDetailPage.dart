import 'package:flutter/material.dart';

import 'package:lychee/widget/base/BaseState.dart';
import 'package:lychee/widget/base/BaseScrollSate.dart';
import 'package:lychee/widget/base/BaseScrollWidget.dart';
import 'package:lychee/common/model/Course.dart';
import 'package:lychee/common/util/CommonUtils.dart';
import 'package:lychee/common/style/Style.dart';
import 'package:lychee/widget/ScholarItem.dart';
import 'package:lychee/widget/SeparatorWidget.dart';
import 'package:lychee/widget/SectionWdiget.dart';
import 'package:lychee/widget/CourseDetailItem.dart';
import 'package:lychee/common/model/Lesson.dart';
import 'package:lychee/page/LessonDetailPage.dart';

class CourseDetailPage extends StatefulWidget {
  final Map params;
  CourseDetailPage(this.params) :super();

  @override
  _CourseDetailPageState createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> with AutomaticKeepAliveClientMixin<CourseDetailPage>,BaseState<CourseDetailPage>, BaseScrollState<CourseDetailPage> {

  Course course;

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
    return Course.fromJson(json);
  }

  @override
  Widget build(BuildContext context) {
    course = control.data;

    return new Scaffold(
      appBar: new AppBar(
        title:Text("短课详情"),
        centerTitle: true, 
        leading: FlatButton(
          padding: EdgeInsets.all(0), 
          child: Image.asset(CommonUtils.Local_Icon_prefix+"back.png",width: 18,height: 18),
          onPressed: (){
            CommonUtils.closePage(context);
          },
        ),
        actions: <Widget>[
          IconButton(
          icon: new Image.asset(CommonUtils.Local_Icon_prefix+"more.png",width: 18.0,height: 18.0),
          onPressed: () {

          })
        ]
      ),
      body: BaseScrollWidget(
        control:control,
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
            ScholarItem(avatar: course.avatar,author: course.author,honor: course.honor,onPressed: (){

            }),
            SeparatorWidget(),
            (course.introduction==null||course.introduction.length==0)?new Container():Padding(
              padding: EdgeInsets.only(left: 10.5,right: 10.5),
              child: Text(course.introduction,style:TextStyle(color: Color(YYColors.primaryText),fontSize: YYSize.large,letterSpacing: 0,height:1.2))
            ),
            (course.lessonList==null||course.lessonList.length==0)?new Container():new Column(
              children: <Widget>[
                SectionWidget(title: "共"+course.lessonList.length.toString()+"讲"),
                new ListView.separated(
                  shrinkWrap: true,
                  physics: new NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index)=>SeparatorWidget(),
                  itemBuilder: (context, index) {
                    Lesson lesson = course.lessonList[index];
                    return new CourseDetailItem(lesson,index,onPressed:() {
                      CommonUtils.openPage(context, LessonDetailPage({"uuid":lesson.uuid}));
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