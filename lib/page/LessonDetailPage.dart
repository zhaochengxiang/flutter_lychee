import 'package:flutter/material.dart';

import 'package:lychee/widget/base/BaseState.dart';
import 'package:lychee/widget/base/BaseScrollSate.dart';
import 'package:lychee/widget/base/BaseScrollWidget.dart';
import 'package:lychee/common/model/Lesson.dart';
import 'package:lychee/common/util/CommonUtils.dart';
import 'package:lychee/common/style/Style.dart';
import 'package:lychee/widget/ScholarItem.dart';
import 'package:lychee/widget/SeparatorWidget.dart';
import 'package:lychee/common/model/Scholar.dart';

class LessonDetailPage extends StatefulWidget {
  final Map params;
  LessonDetailPage(this.params) :super();

  @override
  _LessonDetailPageState createState() => _LessonDetailPageState();
}

class _LessonDetailPageState extends State<LessonDetailPage> with AutomaticKeepAliveClientMixin<LessonDetailPage>,BaseState<LessonDetailPage>, BaseScrollState<LessonDetailPage> {

  Lesson lesson;

  @override
  remotePath() {
    return "/lesson/get";
  }

  @override
  generateRemoteParams() {
    return {"uuid":widget.params['uuid']};    
  }

  @override
  jsonConvertToModel(Map<String,dynamic> json) {
    return Lesson.fromJson(json);
  }

  @override
  Widget build(BuildContext context) {
    lesson = control.data;

    return new Scaffold(
      appBar: new AppBar(
        title:Text("小讲详情"),
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
        child: (lesson==null)?new Container():new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            (lesson.title==null)?new Container(): new Padding(
              padding: EdgeInsets.all(10.5),
              child: Text(lesson.title,style:TextStyle(color: Color(YYColors.primaryText),fontSize: YYSize.large),overflow: TextOverflow.ellipsis,maxLines: 1)
            ),
            ScholarItem(Scholar(avatar:lesson.avatar,name:lesson.author,honor:lesson.honor),onPressed:(){

            }),
            SeparatorWidget(),
            (lesson.content==null||lesson.content.length==0)?new Container():Padding(
              padding: EdgeInsets.only(left: 10.5,right: 10.5),
              child: Text(lesson.content,style:TextStyle(color: Color(YYColors.primaryText),fontSize: YYSize.large,letterSpacing: 0,height:1.2))
            )
          ],
        )
      ),
    );
  }
}