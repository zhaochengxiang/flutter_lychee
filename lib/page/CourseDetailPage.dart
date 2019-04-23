import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:lychee/widget/base/BaseState.dart';
import 'package:lychee/widget/base/BaseScrollState.dart';
import 'package:lychee/widget/base/BaseScrollWidget.dart';
import 'package:lychee/common/model/Course.dart';
import 'package:lychee/common/util/CommonUtils.dart';
import 'package:lychee/common/style/Style.dart';
import 'package:lychee/widget/ScholarItem.dart';
import 'package:lychee/widget/SeparatorWidget.dart';
import 'package:lychee/widget/SectionWdiget.dart';
import 'package:lychee/widget/CourseDetailItem.dart';
import 'package:lychee/common/model/Lesson.dart';
import 'package:lychee/common/model/Scholar.dart';
import 'package:lychee/page/LessonDetailPage.dart';
import 'package:lychee/common/manager/ShareManager.dart';
import 'package:lychee/common/event/NeedRefreshEvent.dart';
import './ScholarPage.dart';

class CourseDetailPage extends StatefulWidget {
  final Map params;
  CourseDetailPage(this.params) :super();

  @override
  _CourseDetailPageState createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> with AutomaticKeepAliveClientMixin<CourseDetailPage>,BaseState<CourseDetailPage>, BaseScrollState<CourseDetailPage> {

  Course course;
  ShareManager shareManager =ShareManager();

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

  @protected
  _share() {
    List<Widget> customMenuItems = List();
    if (course != null) {
      customMenuItems.add(InkWell(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(CommonUtils.Local_Icon_prefix+((course.favorite==true)?'favorite_red.png':'favorite_gray.png'),width:30.0,height:30.0,fit: BoxFit.fill),
            Text((course.favorite==true)?'取消收藏':'收藏',style: TextStyle(color: Color(YYColors.secondaryText),fontSize: YYSize.medium), overflow: TextOverflow.ellipsis,),
          ],
        ),
        onTap: () async {
          var res = await handleNotAssociatedWithRefreshRequest(context, (course.favorite==true)?"/favorite/delete":"/favorite/save", {"id":course.id,"type":2});

          Navigator.pop(context);
          if (res!=null && res.result) {
            if (isShow) {
              setState(() {
                course.favorite = !course.favorite;
              });
            }
            Fluttertoast.showToast(msg: (course.favorite==true)?"收藏成功":"取消收藏成功",gravity: ToastGravity.CENTER);
            NeedRefreshEvent.refreshHandleFunction("MineCoursePage");
          }
        },
      ));
    }
    shareManager.showMenu(context,customMenuItems:customMenuItems,title:course.title??"",desc:course.introduction??"",url:'http://lizhiketang.com/h5/course/'+course.uuid);
  }

  @override
  Widget build(BuildContext context) {
    course = control.data;

    return new Scaffold(
      appBar: new AppBar(
        title:Text("短课详情"),
        centerTitle: true, 
        leading: IconButton(
          icon: Image.asset(CommonUtils.Local_Icon_prefix+"back.png",width: 18,height: 18),
          onPressed: (){
            CommonUtils.closePage(context);
          },
        ),
        actions: <Widget>[
          IconButton(
          icon: new Image.asset(CommonUtils.Local_Icon_prefix+"more.png",width: 18.0,height: 18.0),
          onPressed: () {
            _share();
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
            ScholarItem(Scholar(avatar:course.avatar,name:course.author,honor:course.honor),onPressed:(){

              CommonUtils.openPage(context, ScholarPage(course.sid));
            
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