import 'package:flutter/material.dart';

import 'package:lychee/widget/base/YYBaseState.dart';
import 'package:lychee/widget/base/YYBaseScrollSate.dart';
import 'package:lychee/widget/base/YYBaseScrollWidget.dart';
import 'package:lychee/common/util/YYCommonUtils.dart';
import 'package:lychee/widget/YYSectionWdiget.dart';
import 'package:lychee/widget/YYSwiperWidget.dart';
import 'package:lychee/widget/YYCourseItem.dart';
import 'package:lychee/common/model/YYCourseHome.dart';
import 'package:lychee/common/model/YYCourse.dart';
import 'package:lychee/common/style/YYStyle.dart';
import 'package:lychee/widget/YYSeparatorWidget.dart';
import 'package:lychee/page/YYCourseDetailPage.dart';

class YYCoursePage extends StatefulWidget {
  @override
  _YYCoursePageState createState() => _YYCoursePageState();
}

class _YYCoursePageState extends State<YYCoursePage> with AutomaticKeepAliveClientMixin<YYCoursePage>,YYBaseState<YYCoursePage>, YYBaseScrollState<YYCoursePage> {

  YYCourseHome courseHome;

  @override
  remotePath() {
    return "/course/home";
  }

  @override
  generateRemoteParams() {
    return {};    
  }

  @override
  jsonConvertToModel(Map<String,dynamic> json) {
    return YYCourseHome.fromJson(json);
  }

  _buildBannerWidget() {
    if (courseHome==null) return new Container();

    var fineList = courseHome.fineList;

    List imageUrls = List();
    if (fineList != null) {
      for (int i=0;i<fineList.length;i++) {
        YYCourse course = fineList[i];
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
    if (courseHome == null) return new Container();

    var recommends = courseHome.recommendList;

    return (recommends==null||recommends.length==0)?new Container():new Column(
      children: <Widget>[
        YYSectionWidget(
          title: "推荐短课",
          subtitle: "全部短课",
          onPressed: (){},
        ),
        new ListView.separated(
          shrinkWrap: true,
          physics: new NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index)=>YYSeparatorWidget(),
          itemBuilder: (context, index) {
            YYCourse recommend = recommends[index];
            return new YYCourseItem(recommends[index],onPressed: (){
              YYCommonUtils.openPage(context, YYCourseDetailPage({"uuid":recommend.uuid}));
            });
          },
          itemCount: recommends.length,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    courseHome = control.data;

    return new Scaffold(
      appBar: new AppBar(
        title:Text("短课"),
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