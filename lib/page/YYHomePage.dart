import 'package:flutter/material.dart';

import 'package:lychee/widget/base/YYBaseScrollSate.dart';
import 'package:lychee/widget/base/YYBaseScrollWidget.dart';
import 'package:lychee/widget/base/YYBaseState.dart';
import 'package:lychee/common/model/YYIndex.dart';
import 'package:lychee/common/model/YYBanner.dart';
import 'package:lychee/widget/YYSwiperWidget.dart';
import 'package:lychee/common/style/YYStyle.dart';
import 'package:lychee/widget/YYIconText.dart';
import 'package:lychee/widget/YYLessonItem.dart';
import 'package:lychee/widget/YYCourseItem.dart';
import 'package:lychee/common/util/YYCommonUtils.dart';
import 'package:lychee/widget/YYBookGrid.dart';
import 'package:lychee/widget/YYSectionWdiget.dart';
import 'package:lychee/widget/YYSeparatorWidget.dart';
import 'package:lychee/common/model/YYCourse.dart';
import 'package:lychee/common/model/YYLesson.dart';

class YYHomePage extends StatefulWidget {
  @override
  _YYHomePageState createState() => _YYHomePageState();
}

class _YYHomePageState extends State<YYHomePage> with AutomaticKeepAliveClientMixin<YYHomePage>,YYBaseState<YYHomePage>, YYBaseScrollState<YYHomePage> {

  YYIndex homeIndex;

  @override
  bool get needRefreshHeader => true;
  
  @override
  remotePath() {
    return "/home";
  }

  @override
  generateRemoteParams() {
    return {'adCode':'未知'};
  }

  @override
  jsonConvertToModel(Map<String,dynamic> json) {
    return YYIndex.fromJson(json);
  }

  _optionIconText(String assetName,String text, VoidCallback callback) {
    return new FlatButton(
      padding: EdgeInsets.all(0),
      child: new YYIconText(
        direction:YYIconTextDirection.column,
        iconAssetName: assetName,
        iconWidth: 62.5,
        iconHeight: 62.5,
        textStyle: TextStyle(color: Color(YYColors.primarySection),fontSize: YYSize.medium),
        text: text,
        padding: 2.5,
        mainAxisAlignment: MainAxisAlignment.center,
      ),
      onPressed: () {callback?.call();},
    );
  }

  _buildBannerWidget() {
    if (homeIndex==null) return new Container();

    var banners = homeIndex.bannerList;

    List imageUrls = List();
    if (banners != null) {
      for (int i=0;i<banners.length;i++) {
        YYBanner book = banners[i];
        imageUrls.add(book.image);
      }
    }

    return (banners==null||banners.length==0)?new Container():new YYSwiperWidget(
      height: 125,
      imageUrls: imageUrls,
      dotActiveColor: Color(YYColors.primary),
      selectItemChanged:(selectIndex) {
       
      },
    );
  } 

  _buildOptionWidget() {
    return new Padding(
      padding:new EdgeInsets.only(left:0,top:21.0,right:0,bottom:10.5),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _optionIconText("book.png","图书",() {
            YYCommonUtils.openPage("flutter://home_book", null);
          }),
          _optionIconText("lesson.png","小讲",() {
            YYCommonUtils.openPage("flutter://lesson", null);
          }),
          _optionIconText("course.png","短课",() {
            YYCommonUtils.openPage("flutter://course", null);
          }),
        ],
      ),
    );
  }

  _buildChosenBookWidget() {
    if (homeIndex == null) return new Container();

    var books = homeIndex.chosenBookList;

    return (books==null||books.length==0)?new Container():new Column(
      children: <Widget>[
        YYSectionWidget(
          title: "精选图书",
        ),
        new YYBookGrid(books,onPressed: (book){
          YYCommonUtils.openPage("flutter://book_detail", {"lid":0,"uuid":book.uuid});
        }),
      ],
    );
  }

  _buildChosenLessonWidget() {
    if (homeIndex == null) return new Container();

    var lessons = homeIndex.chosenLessonList;

    return (lessons==null||lessons.length==0)?new Container():new Column(
      children: <Widget>[
        YYSectionWidget(
          title: "精选小讲",
        ),
        new ListView.separated(
          shrinkWrap: true,
          physics: new NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index)=>YYSeparatorWidget(),
          itemBuilder: (context, index) {
            YYLesson lesson = lessons[index];
            return new YYLessonItem(lesson,onPressed: (){
              YYCommonUtils.openPage("flutter://lesson_detail", {"uuid":lesson.uuid});
            });
          },
          itemCount: lessons.length,
        ),
      ],
    );
  }

  _buildChosenCourseWidget() {
    if (homeIndex == null) return new Container();

    var courses = homeIndex.chosenCourseList;

    return (courses==null||courses.length==0)?new Container():new Column(
      children: <Widget>[
        YYSectionWidget(
          title: "精选短课",
        ),
        new ListView.separated(
          shrinkWrap: true,
          physics: new NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index)=>YYSeparatorWidget(),
          itemBuilder: (context, index) {
            YYCourse course = courses[index];
            return new YYCourseItem(course,onPressed: (){
              YYCommonUtils.openPage("flutter://course_detail", {"uuid":course.uuid});
            });
          },
          itemCount: courses.length,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    homeIndex = baseWidgetControl.data;

    return new Scaffold(
      appBar: new AppBar(
        leading: IconButton(
          icon: new Image.asset(YYCommonUtils.Local_Icon_prefix+"scan.png",width: 24.0,height: 24.0),
          onPressed: () {

          }),
        title:Text("荔枝课堂"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
          icon: new Image.asset(YYCommonUtils.Local_Icon_prefix+"search.png",width: 24.0,height: 24.0),
          onPressed: () {

          })
        ],
      ),
      body: YYBaseScrollWidget(
        control:baseWidgetControl,
        onRefresh:handleRefresh,
        refreshKey: refreshIndicatorKey,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildBannerWidget(),
            _buildOptionWidget(),
            _buildChosenBookWidget(),
            _buildChosenLessonWidget(),
            _buildChosenCourseWidget(),
          ]
        ),
      ),
    );
  }
}