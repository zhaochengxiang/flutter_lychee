import 'dart:io';
import 'package:flutter/material.dart';

import 'package:lychee/widget/base/BaseScrollState.dart';
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
import './SearchDetailPage.dart';
import './WebViewPage.dart';
import 'package:lychee/common/xservice/cross-platform/service/CrossPlatformService.dart';
import 'package:lychee/common/model/Book.dart';

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
    return new InkWell(
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
      onTap: () {callback?.call();},
    );
  }

  _buildBannerWidget() {
    if (homeIndex==null) return new Container();

    var banners = homeIndex.bannerList;

    List imageUrls = List();
    if (banners != null) {
      for (int i=0;i<banners.length;i++) {
        YYBanner.Banner banner = banners[i];
        imageUrls.add(banner.image);
      }
    }

    return (banners==null||banners.length==0)?new Container():new SwiperWidget(
      height: 125,
      imageUrls: imageUrls,
      dotActiveColor: Color(YYColors.primary),
      selectItemChanged:(selectIndex) {
          YYBanner.Banner banner = banners[selectIndex];
          String link = banner.link??"";
          if (link.startsWith('http://') || link.startsWith('https://')) {

            CommonUtils.openPage(context, WebViewPage(url:link));

          } else {
            List<String> separates = link.split(":");
            String head = separates[0];
            String trail = separates[1];
            if (head == "book") {
              
              CommonUtils.openPage(context, BookDetailPage({'lid':0,'uuid':trail}));

            } else if (head == "lesson") {

              List<String> subSeparates = trail.split(",");
              String subHead = subSeparates[0];
              CommonUtils.openPage(context, LessonDetailPage({'uuid':subHead}));

            } else if (head == "course") {
              CommonUtils.openPage(context, CourseDetailPage({'uuid':trail}));
            }
          }
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

  @protected
  _scan() {
    CrossPlatformService.service().emitEvent("flutter_event_open_scan", {});
    CrossPlatformService.service().addEventListner("native_event_scan_code", (String event,Map<dynamic,dynamic> params) async{
      String code = params["code"]??"";
      if (code.startsWith(CommonUtils.QRCode_Prefix)) {

      } else {
        var res = await handleNotAssociatedWithRefreshRequest("/book/findByIsbn", {"isbn":code});

        if (res!=null && res.result && res.data!=null && res.data.length!=0) {
          List<Book> books = new List();
          for (int i=0;i<res.data.length;i++) {
            books.add(Book.fromJson(res.data[i]));
          }

          if (books.length == 1) {

            Book book = books[0];
            Future.delayed(Duration(milliseconds: 500),(){
              CommonUtils.openPage(context, BookDetailPage({'uuid': book.uuid,'lid': 0}));
            });
        
          } else {

          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    homeIndex = control.data;

    return new Scaffold(
      appBar: new AppBar(
        leading: IconButton(
          icon: new Image.asset(CommonUtils.Local_Icon_prefix+"scan.png",width: 18.0,height: 18.0),
          onPressed: () {

            _scan();

          }),
        title:Text("荔枝课堂"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
          icon: new Image.asset(CommonUtils.Local_Icon_prefix+"search.png",width: 18.0,height: 18.0),
          onPressed: () {
            CommonUtils.openPage(context, SearchPage(onPressed:(keyword) {
              CommonUtils.openPage(context, SearchDetailPage(keyword: keyword));
            }));
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