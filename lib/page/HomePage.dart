import 'package:flutter/material.dart';

import 'package:lychee/widget/base/BaseScrollSate.dart';
import 'package:lychee/widget/base/BaseScrollWidget.dart';
import 'package:lychee/widget/base/BaseState.dart';
import 'package:lychee/common/model/Index.dart';
import 'package:lychee/common/model/Banner.dart' as YYBanner;
import 'package:lychee/widget/SwiperWidget.dart';
import 'package:lychee/common/style/Style.dart';
import 'package:lychee/widget/IconText.dart';
import 'package:lychee/widget/LessonItem.dart';
import 'package:lychee/widget/CourseItem.dart';
import 'package:lychee/common/util/CommonUtils.dart';
import 'package:lychee/widget/BookGrid.dart';
import 'package:lychee/widget/SectionWdiget.dart';
import 'package:lychee/widget/SeparatorWidget.dart';
import 'package:lychee/common/model/Course.dart';
import 'package:lychee/common/model/Lesson.dart';
import './HomeBookPage.dart';
import './LessonPage.dart';
import './LessonDetailPage.dart';
import './CoursePage.dart';
import './CourseDetailPage.dart';
import './BookDetailPage.dart';
import './SearchPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin<HomePage>,BaseState<HomePage>, BaseScrollState<HomePage> {

  Index homeIndex;

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
    return Index.fromJson(json);
  }

  _optionIconText(String assetName,String text, VoidCallback callback) {
    return new FlatButton(
      padding: EdgeInsets.all(0),
      child: new IconText(
        direction:IconTextDirection.column,
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
        YYBanner.Banner book = banners[i];
        imageUrls.add(book.image);
      }
    }

    return (banners==null||banners.length==0)?new Container():new SwiperWidget(
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
            CommonUtils.openPage(context, HomeBookPage());           
          }),
          _optionIconText("lesson.png","小讲",() {
            CommonUtils.openPage(context, LessonPage());           
          }),
          _optionIconText("course.png","短课",() {
            CommonUtils.openPage(context, CoursePage());           
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
        SectionWidget(
          title: "精选图书",
        ),
        new BookGrid(books,onPressed: (book){
          CommonUtils.openPage(context, BookDetailPage({"lid":0,"uuid":book.uuid}));
        }),
      ],
    );
  }

  _buildChosenLessonWidget() {
    if (homeIndex == null) return new Container();

    var lessons = homeIndex.chosenLessonList;

    return (lessons==null||lessons.length==0)?new Container():new Column(
      children: <Widget>[
        SectionWidget(
          title: "精选小讲",
        ),
        new ListView.separated(
          shrinkWrap: true,
          physics: new NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index)=>SeparatorWidget(),
          itemBuilder: (context, index) {
            Lesson lesson = lessons[index];
            return new LessonItem(lesson,onPressed: (){
              CommonUtils.openPage(context, LessonDetailPage({"uuid":lesson.uuid}));
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
        SectionWidget(
          title: "精选短课",
        ),
        new ListView.separated(
          shrinkWrap: true,
          physics: new NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index)=>SeparatorWidget(),
          itemBuilder: (context, index) {
            Course course = courses[index];
            return new CourseItem(course,onPressed: (){
              CommonUtils.openPage(context, CourseDetailPage({"uuid":course.uuid}));
            });
          },
          itemCount: courses.length,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    homeIndex = control.data;

    return new Scaffold(
      appBar: new AppBar(
        leading: IconButton(
          icon: new Image.asset(CommonUtils.Local_Icon_prefix+"scan.png",width: 24.0,height: 24.0),
          onPressed: () {

          }),
        title:Text("荔枝课堂"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
          icon: new Image.asset(CommonUtils.Local_Icon_prefix+"search.png",width: 24.0,height: 24.0),
          onPressed: () {
            CommonUtils.openPage(context, SearchPage());
          })
        ],
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