import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'package:lychee/common/util/YYCommonUtils.dart';
import 'package:lychee/common/style/YYStyle.dart';
import 'package:lychee/widget/base/YYBaseState.dart';
import 'package:lychee/common/model/YYUser.dart';
import 'package:lychee/page/YYLoginPage.dart';

class YYMinePage extends StatefulWidget {
  @override
  _YYMinePageState createState() => _YYMinePageState();
}

class _YYMinePageState extends State<YYMinePage> with AutomaticKeepAliveClientMixin<YYMinePage>,YYBaseState<YYMinePage> {
  static const double topHeight = 187.5;
  static const double topBgHeight = 114.5;
  static const double serviceGridTileHeight = 81.0;

  static const double crossAxisSpacing = 0;
  static const int crossAxisCount = 4;
  static const double mainAxisSpacing = 0;

  static const List services = [{"image":"my_book.png","title":"我的图书"},{"image":"my_library.png","title":"我的图书馆"},{"image":"my_note.png","title":"拍书笔记"},{"image":"my_lesson.png","title":"我的小讲"},{"image":"my_course.png","title":"我的短课"},{"image":"my_frame.png","title":"我的书架"},{"image":"my_follow.png","title":"我的关注"},{"image":"my_recommend.png","title":"推荐给朋友"},{"image":"my_about.png","title":"关于我们"}];

  @override
  bool get needNetworkRequest => false;

  @override
  remotePath() {
    return "/user/getMyProfile";
  }

  @override
  generateRemoteParams() {
    return {};
  }

  @override
  jsonConvertToModel(Map<String,dynamic> json) {
     return YYUser.fromJson(json);
  }

  topPressed() {
    if (baseWidgetControl.data == null) {
      // YYCommonUtils.navigatorRouter(context, YYLoginPage());
      FlutterBoost.singleton.openPage("flutter://login", null);
    } 
  }

  Widget _buildTop(BuildContext context) {
    YYUser user = baseWidgetControl.data;

    return FlatButton(
      padding: EdgeInsets.all(0), 
      onPressed: topPressed,
      child: Container(
        height: topHeight,
        child:Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: topBgHeight,
              child: new Image.asset(YYCommonUtils.Local_Icon_prefix+'mine_top_bg.png',fit:BoxFit.fill)
            ),
            Positioned(
              width: MediaQuery.of(context).size.width,
              bottom: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ClipOval(
                    child:Container(
                      width: 77,
                      height: 77,
                      color: Colors.white,
                      child: Center( 
                        child: ClipOval(
                          child: (user==null)? Image.asset(YYCommonUtils.Local_Icon_prefix+'user_placeholder.png',width:73.0,height:73.0,fit:BoxFit.fill):new FadeInImage.assetNetwork(
                            placeholder: YYCommonUtils.Local_Icon_prefix+'user_placeholder.png',
                            fit: BoxFit.fill,
                            image: YYCommonUtils.avatarPath(user.avatar),
                            width: 73.0,
                            height: 73.0,
                          ),
                        )
                      ),
                    )
                  ),
                  Padding(padding: EdgeInsets.all(5.0)),
                  Text((user==null)?'登录':user.username,style: TextStyle(color: Color(YYColors.primaryText),fontSize: YYSize.large), overflow: TextOverflow.ellipsis),
                  Padding(padding: EdgeInsets.all(2.5)),
                  Text((user==null)?'':'学号:第${user.id.floor()}号',style: TextStyle(color: Color(YYColors.secondaryText),fontSize: YYSize.medium), overflow: TextOverflow.ellipsis)
                ],
              ),
            )
          ],
        )
      )
    );
  }

  List<Widget> _buildGridTiles() {
    List<Widget> lists = new List();
    for (int i=0;i<services.length;i++) {
      Map service = services[i];
      Widget tile = new FlatButton( 
        padding: EdgeInsets.all(0),
        child: Center(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(YYCommonUtils.Local_Icon_prefix+service['image'],width:16.5,height:16.5,fit:BoxFit.fill),
              Padding(padding:EdgeInsets.all(2.5)),
              Text(service['title'],style: TextStyle(color: Color(YYColors.primaryText),fontSize: YYSize.medium),overflow: TextOverflow.ellipsis)
            ],
          )
        ),
        onPressed: (){},
      );
      lists.add(tile);
    }
    return lists;
  }

  @override 
  Widget build(BuildContext context) {

    return new Scaffold(
      body: Column( 
        children: <Widget>[
          _buildTop(context),
          Padding(padding: EdgeInsets.all(10.5)),
          new Container(
            height:40.5,
            child: new Padding(
              padding: new EdgeInsets.only(left:10.5),
              child: Align( 
                alignment: Alignment.centerLeft,
                child: Text("个人服务",style: TextStyle(color: Color(YYColors.primarySection),fontSize: YYSize.large))
              ),
            ),
          ),
          GridView.count(
            padding: EdgeInsets.all(0),
            primary: false,
            shrinkWrap: true,
            crossAxisSpacing: crossAxisSpacing,
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: mainAxisSpacing,
            childAspectRatio: (MediaQuery.of(context).size.width/crossAxisCount)/serviceGridTileHeight,
            children: _buildGridTiles(),
          )
        ],
      ),
    );
  } 
}
