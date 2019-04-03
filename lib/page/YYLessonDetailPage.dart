import 'package:flutter/material.dart';

import 'package:lychee/widget/base/YYBaseState.dart';
import 'package:lychee/widget/base/YYBaseScrollSate.dart';
import 'package:lychee/widget/base/YYBaseScrollWidget.dart';
import 'package:lychee/common/model/YYLesson.dart';
import 'package:lychee/common/util/YYCommonUtils.dart';
import 'package:lychee/common/style/YYStyle.dart';
import 'package:lychee/widget/YYScholarItem.dart';
import 'package:lychee/widget/YYSeparatorWidget.dart';

class YYLessonDetailPage extends StatefulWidget {
  final Map params;
  YYLessonDetailPage(this.params) :super();

  @override
  _YYLessonDetailPageState createState() => _YYLessonDetailPageState();
}

class _YYLessonDetailPageState extends State<YYLessonDetailPage> with AutomaticKeepAliveClientMixin<YYLessonDetailPage>,YYBaseState<YYLessonDetailPage>, YYBaseScrollState<YYLessonDetailPage> {

  YYLesson lesson;

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
    return YYLesson.fromJson(json);
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
            YYScholarItem(avatar: lesson.avatar,author: lesson.author,honor: lesson.honor,onPressed: (){

            }),
            YYSeparatorWidget(),
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