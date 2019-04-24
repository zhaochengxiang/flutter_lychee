import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:lychee/widget/base/BaseState.dart';
import 'package:lychee/widget/base/BaseScrollState.dart';
import 'package:lychee/widget/base/BaseScrollWidget.dart';
import 'package:lychee/common/model/Lesson.dart';
import 'package:lychee/common/util/CommonUtils.dart';
import 'package:lychee/common/style/Style.dart';
import 'package:lychee/widget/ScholarItem.dart';
import 'package:lychee/widget/SeparatorWidget.dart';
import 'package:lychee/common/model/Scholar.dart';
import 'package:lychee/common/manager/ShareManager.dart';
import 'package:lychee/common/event/NeedRefreshEvent.dart';
import './ScholarPage.dart';

class LessonDetailPage extends StatefulWidget {
  final Map params;
  LessonDetailPage(this.params) :super();

  @override
  _LessonDetailPageState createState() => _LessonDetailPageState();
}

class _LessonDetailPageState extends State<LessonDetailPage> with AutomaticKeepAliveClientMixin<LessonDetailPage>,BaseState<LessonDetailPage>, BaseScrollState<LessonDetailPage> {

  Lesson lesson;
  ShareManager shareManager =ShareManager();

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

  @protected
  _share() {
    List<Widget> customMenuItems = List();
    if (lesson != null) {
      customMenuItems.add(InkWell(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(CommonUtils.Local_Icon_prefix+((lesson.favorite==true)?'favorite_red.png':'favorite_gray.png'),width:30.0,height:30.0,fit: BoxFit.fill),
            Text((lesson.favorite==true)?'取消收藏':'收藏',style: TextStyle(color: Color(YYColors.secondaryText),fontSize: YYSize.medium), overflow: TextOverflow.ellipsis,),
          ],
        ),
        onTap: () async {
          var res = await handleNotAssociatedWithRefreshRequest((lesson.favorite==true)?"/favorite/delete":"/favorite/save", {"id":lesson.id,"type":1});

          Navigator.pop(context);
          if (res!=null && res.result) {
            if (isShow) {
              setState(() {
                lesson.favorite = !lesson.favorite;
              });
            }
            Fluttertoast.showToast(msg: (lesson.favorite==true)?"收藏成功":"取消收藏成功",gravity: ToastGravity.CENTER);
            NeedRefreshEvent.refreshHandleFunction("MineLessonPage");
          }
        },
      ));
    }
    shareManager.showMenu(context,customMenuItems:customMenuItems,title:lesson.title??"",desc:(lesson.salePrice>0)?(lesson.introduction??""):(lesson.content??""),url:'http://lizhiketang.com/h5/lesson/'+lesson.uuid);
  }

  @override
  Widget build(BuildContext context) {
    lesson = control.data;

    return new Scaffold(
      appBar: new AppBar(
        title:Text("小讲详情"),
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
        child: (lesson==null)?new Container():new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            (lesson.title==null)?new Container(): new Padding(
              padding: EdgeInsets.all(10.5),
              child: Text(lesson.title,style:TextStyle(color: Color(YYColors.primaryText),fontSize: YYSize.large),overflow: TextOverflow.ellipsis,maxLines: 1)
            ),
            ScholarItem(Scholar(avatar:lesson.avatar,name:lesson.author,honor:lesson.honor),onPressed:(){
              
              CommonUtils.openPage(context, ScholarPage(lesson.sid));

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