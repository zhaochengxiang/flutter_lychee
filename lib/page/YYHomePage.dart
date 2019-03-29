import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost.dart';

import 'package:lychee/widget/base/YYBaseScrollSate.dart';
import 'package:lychee/widget/base/YYBaseScrollWidget.dart';
import 'package:lychee/widget/base/YYBaseState.dart';
import 'package:lychee/common/model/YYIndex.dart';
import 'package:lychee/common/model/YYBanner.dart';
import 'package:lychee/widget/YYSwiperWidget.dart';
import 'package:lychee/common/style/YYStyle.dart';
import 'package:lychee/widget/YYIconTextWidget.dart';
import 'package:lychee/widget/YYLessonItemWidget.dart';
import 'package:lychee/widget/YYCourseItemWidget.dart';
import 'package:lychee/common/util/YYCommonUtils.dart';
import 'package:lychee/widget/YYBookGridWidget.dart';

class YYHomePage extends StatefulWidget {
  @override
  _YYHomePageState createState() => _YYHomePageState();
}

class _YYHomePageState extends State<YYHomePage> with AutomaticKeepAliveClientMixin<YYHomePage>,YYBaseState<YYHomePage>, YYBaseScrollState<YYHomePage> {

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
      child: new YYIconTextWidget(
        type:2,
        iconAssetName: assetName,
        iconText: text,
        iconWidth: 62.5,
        iconHeight: 62.5,
        textStyle: TextStyle(color: Color(YYColors.primarySection),fontSize: YYSize.medium),
        padding: 2.5,
        mainAxisAlignment: MainAxisAlignment.center,
      ),
      onPressed: () {callback?.call();},
    );
  }

  _buildBannerWidget() {
    if (baseWidgetControl.data==null) return new Container();

    var banners = baseWidgetControl.data.bannerList;

    List urls = List();
    if (banners != null) {
      for (int i=0;i<banners.length;i++) {
        YYBanner book = banners[i];
        urls.add(book.image);
      }
    }

    return (banners==null||banners.length==0)?new Container():new YYSwiperWidget(
      height: 125,
      imageUrls: urls,
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
              FlutterBoost.singleton.openPage("flutter://home_book", null);
          }),
          _optionIconText("lesson.png","小讲",() {
         
          }),
          _optionIconText("course.png","短课",() {
            
          }),
        ],
      ),
    );
  }

  _buildChosenBookWidget() {
    if (baseWidgetControl.data == null) return new Container();

    var books =baseWidgetControl.data.chosenBookList;

    return (books==null||books.length==0)?new Container():new Column(
      children: <Widget>[
        new Container(
          height:40.5,
          child: new Padding(
            padding: new EdgeInsets.only(left:10.5),
            child: Align( 
              alignment: Alignment.centerLeft,
              child: Text("精选图书",style: TextStyle(color: Color(YYColors.primarySection),fontSize: YYSize.large))
            ),
          ),
        ),
        new YYBookGridWidget(books),
      ],
    );
  }

  _buildChosenLessonWidget() {
    if (baseWidgetControl.data == null) return new Container();

    var lessons =baseWidgetControl.data.chosenLessonList;

    return (lessons==null||lessons.length==0)?new Container():new Column(
      children: <Widget>[
        new Container(
          height:40.5,
          child: new Padding(
            padding: new EdgeInsets.only(left:10.5),
            child: Align( 
              alignment: Alignment.centerLeft,
              child: Text("精选小讲",style: TextStyle(color: Color(YYColors.primarySection),fontSize: YYSize.large))
            ),
          ),
        ),
        new ListView.builder(
          shrinkWrap: true,
          physics: new NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return new YYLessonItemWidget(lessons[index],onPressed:() {

            });
          },
          itemCount: lessons.length,
        ),
      ],
    );
  }

  _buildChosenCourseWidget() {
    if (baseWidgetControl.data == null) return new Container();

    var courses =baseWidgetControl.data.chosenCourseList;

    return (courses==null||courses.length==0)?new Container():new Column(
      children: <Widget>[
        new Container(
          height:40.5,
          child: new Padding(
            padding: new EdgeInsets.only(left:10.5),
            child: Align( 
              alignment: Alignment.centerLeft,
              child: Text("精选短课",style: TextStyle(color: Color(YYColors.primarySection),fontSize: YYSize.large))
            ),
          ),
        ),
        new ListView.builder(
          shrinkWrap: true,
          physics: new NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return new YYCourseItemWidget(courses[index],onPressed: (){
              
            });
          },
          itemCount: courses.length,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    YYBaseScrollWidgetControl control = baseWidgetControl;

    return new Scaffold(
      appBar: new AppBar(
        leading: IconButton(
          icon: new Image.asset(YYCommonUtils.Local_Icon_prefix+"scan.png",width: 24.0,height: 24.0),
          onPressed: () {

          }),
        title:Text("荔枝课堂"),
        actions: <Widget>[
          IconButton(
          icon: new Image.asset(YYCommonUtils.Local_Icon_prefix+"search.png",width: 24.0,height: 24.0),
          onPressed: () {

          })
        ],
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