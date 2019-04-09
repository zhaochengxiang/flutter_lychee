import 'package:flutter/material.dart';

import 'package:lychee/widget/base/BaseState.dart';
import 'package:lychee/widget/base/BaseScrollSate.dart';
import 'package:lychee/widget/base/BaseScrollWidget.dart';
import 'package:lychee/common/util/CommonUtils.dart';
import 'package:lychee/widget/SectionWdiget.dart';
import 'package:lychee/widget/SwiperWidget.dart';
import 'package:lychee/widget/CourseItem.dart';
import 'package:lychee/common/model/CourseHome.dart';
import 'package:lychee/common/model/Course.dart';
import 'package:lychee/common/style/Style.dart';
import 'package:lychee/widget/SeparatorWidget.dart';
import 'package:lychee/page/CourseDetailPage.dart';
import './SearchPage.dart';
import './SearchCoursePage.dart';
import 'package:lychee/common/model/Search.dart';

class CoursePage extends StatefulWidget {
  @override
  _CoursePageState createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> with AutomaticKeepAliveClientMixin<CoursePage>,BaseState<CoursePage>, BaseScrollState<CoursePage> {

  CourseHome courseHome;

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
    return CourseHome.fromJson(json);
  }

  _buildBannerWidget() {
    if (courseHome==null) return new Container();

    var fineList = courseHome.fineList;

    List imageUrls = List();
    if (fineList != null) {
      for (int i=0;i<fineList.length;i++) {
        Course course = fineList[i];
        imageUrls.add(course.cover);
      }
    }

    return (fineList==null||fineList.length==0)?new Container():new SwiperWidget(
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
        SectionWidget(
          title: "推荐短课",
          subtitle: "全部短课",
          onPressed: (){},
        ),
        new ListView.separated(
          shrinkWrap: true,
          physics: new NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index)=>SeparatorWidget(),
          itemBuilder: (context, index) {
            Course recommend = recommends[index];
            return new CourseItem(recommends[index],onPressed: (){
              CommonUtils.openPage(context, CourseDetailPage({"uuid":recommend.uuid}));
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
          child: Image.asset(CommonUtils.Local_Icon_prefix+"back.png",width: 18,height: 18),
          onPressed: (){
            CommonUtils.closePage(context);
          },
        ),
        actions: <Widget>[
          IconButton(
          icon: new Image.asset(CommonUtils.Local_Icon_prefix+"search_gray.png",width: 18.0,height: 18.0),
          onPressed: () {
            CommonUtils.openPage(context, SearchPage(type:Search.SEARCH_COURSE,onPressed:(keyword) {
              CommonUtils.openPage(context, SearchCoursePage(keyword: keyword));
            }));
          })
        ]
      ),
      body: BaseScrollWidget(
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