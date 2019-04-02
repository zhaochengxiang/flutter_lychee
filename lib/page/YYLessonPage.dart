import 'package:flutter/material.dart';

import 'package:lychee/widget/base/YYBaseState.dart';
import 'package:lychee/widget/base/YYBaseScrollSate.dart';
import 'package:lychee/widget/base/YYBaseScrollWidget.dart';
import 'package:lychee/common/util/YYCommonUtils.dart';
import 'package:lychee/widget/YYSectionWdiget.dart';
import 'package:lychee/widget/YYSwiperWidget.dart';
import 'package:lychee/widget/YYLessonItem.dart';
import 'package:lychee/common/model/YYLessonHome.dart';
import 'package:lychee/common/model/YYLesson.dart';
import 'package:lychee/common/style/YYStyle.dart';
import 'package:lychee/widget/YYSeparatorWidget.dart';
import './YYLessonDetailPage.dart';

class YYLessonPage extends StatefulWidget {
  @override
  _YYLessonPageState createState() => _YYLessonPageState();
}

class _YYLessonPageState extends State<YYLessonPage> with AutomaticKeepAliveClientMixin<YYLessonPage>,YYBaseState<YYLessonPage>, YYBaseScrollState<YYLessonPage> {

  YYLessonHome lessonHome;

  @override
  remotePath() {
    return "/lesson/home";
  }

  @override
  generateRemoteParams() {
    return {};    
  }

  @override
  jsonConvertToModel(Map<String,dynamic> json) {
    return YYLessonHome.fromJson(json);
  }

  _buildBannerWidget() {
    if (lessonHome==null) return new Container();

    var fineList = lessonHome.fineList;

    List imageUrls = List();
    if (fineList != null) {
      for (int i=0;i<fineList.length;i++) {
        YYLesson course = fineList[i];
        imageUrls.add(course.cover);
      }
    }

    return (fineList==null||fineList.length==0)?new Container():new YYSwiperWidget(
      height: 125,
      imageUrls: imageUrls,
      dotActiveColor: Color(YYColors.primary),
      selectItemChanged:(selectIndex) {
       
      },
    );
  }

  _buildRecommendCourseWidget() {
    if (lessonHome == null) return new Container();

    var recommends = lessonHome.recommendList;

    return (recommends==null||recommends.length==0)?new Container():new Column(
      children: <Widget>[
        YYSectionWidget(
          title: "推荐小讲",
          subtitle: "全部小讲",
          onPressed: (){},
        ),
        new ListView.separated(
          shrinkWrap: true,
          physics: new NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index)=>YYSeparatorWidget(),
          itemBuilder: (context, index) {
            YYLesson recommend = recommends[index];
            return new YYLessonItem(recommend,onPressed: (){
              YYCommonUtils.openPage(context, YYLessonDetailPage({"uuid":recommend.uuid}));
            });
          },
          itemCount: recommends.length,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    YYBaseScrollWidgetControl control = baseWidgetControl;
    lessonHome = control.data;

    return new Scaffold(
      appBar: new AppBar(
        title:Text("小讲"),
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
          icon: new Image.asset(YYCommonUtils.Local_Icon_prefix+"search.png",width: 24.0,height: 24.0),
          onPressed: () {

          })
        ]
      ),
      body: YYBaseScrollWidget(
        control:control,
        onRefresh:handleRefresh,
        refreshKey: refreshIndicatorKey,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildBannerWidget(),
            _buildRecommendCourseWidget(),
          ]
        ),
      ),
    );
  }
}