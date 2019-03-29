import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost.dart';

import 'package:lychee/widget/base/YYBaseScrollSate.dart';
import 'package:lychee/widget/base/YYBaseScrollWidget.dart';
import 'package:lychee/widget/base/YYBaseState.dart';
import 'package:lychee/common/model/YYBookHome.dart';
import 'package:lychee/common/model/YYBook.dart';
import 'package:lychee/common/util/YYCommonUtils.dart';
import 'package:lychee/widget/YYBookGridWidget.dart';
import 'package:lychee/common/style/YYStyle.dart';
import 'package:lychee/widget/YYSwiperWidget.dart';

class YYHomeBookPage extends StatefulWidget {
  @override
  _YYHomeBookPageState createState() => _YYHomeBookPageState();
}

class _YYHomeBookPageState extends State<YYHomeBookPage> with AutomaticKeepAliveClientMixin<YYHomeBookPage>,YYBaseState<YYHomeBookPage>, YYBaseScrollState<YYHomeBookPage> {
  
  @override
  remotePath() {
    return "/book/home";
  }

  @override
  generateRemoteParams() {
    return {};
  }

  @override
  jsonConvertToModel(Map<String,dynamic> json) {
    return YYBookHome.fromJson(json);
  }

  _buildBannelWidget() {
    if (baseWidgetControl.data==null) return new Container();

    var fineBooks = baseWidgetControl.data.fineList;
    List urls = List();
    if (fineBooks != null) {
      for (int i=0;i<fineBooks.length;i++) {
        YYBook book = fineBooks[i];
        urls.add(book.cover);
      }
    }

    return (fineBooks==null||fineBooks.length==0)?new Container():new YYSwiperWidget(
      height: 125,
      imageUrls: urls,
      dotActiveColor: Color(YYColors.primary),
      selectItemChanged:(selectIndex) {
       
      },
    );
  }

  _buildLatestBookWidget() {
    if (baseWidgetControl.data == null) return new Container();
    
    var latestBooks = baseWidgetControl.data.latestList;
    return (latestBooks==null||latestBooks.length==0)?new Container():new Column(
      children: <Widget>[
        new Container(
          height:40.5,
          child: new Padding(
            padding: new EdgeInsets.only(left:10.5,right:10.5),
            child:FlatButton(
              padding: EdgeInsets.all(0),
              onPressed: () {},
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Text("新书推荐",style: TextStyle(color: Color(YYColors.primarySection),fontSize: YYSize.large)),
                  ),
                  Text("更多",style: TextStyle(color: Color(YYColors.secondarySection),fontSize: YYSize.small)),
                  Image.asset(YYCommonUtils.Local_Icon_prefix+"arrow_more.png",width: 13,height: 13,fit:BoxFit.fill)
                ],
              )
            )
          ),
        ),
        new YYBookGridWidget(latestBooks),
      ],
    ); 
  }

  _buildPopularBookWidget() {
    if (baseWidgetControl.data == null) return new Container();
    
    var popularBooks = baseWidgetControl.data.topPopularList;
    return (popularBooks==null||popularBooks.length==0)?new Container():new Column(
      children: <Widget>[
        new Container(
          height:40.5,
          child: new Padding(
            padding: new EdgeInsets.only(left:10.5,right:10.5),
            child:FlatButton(
              padding: EdgeInsets.all(0),
              onPressed: () {},
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Text("热门图书",style: TextStyle(color: Color(YYColors.primarySection),fontSize: YYSize.large)),
                  ),
                  Text("更多",style: TextStyle(color: Color(YYColors.secondarySection),fontSize: YYSize.small)),
                  Image.asset(YYCommonUtils.Local_Icon_prefix+"arrow_more.png",width: 13,height: 13,fit:BoxFit.fill)
                ],
              )
            )
          ),
        ),
        new YYBookGridWidget(popularBooks),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    YYBaseScrollWidgetControl control = baseWidgetControl;

    return new Scaffold(
      appBar: new AppBar(
        title:Text("图书"),
        leading: FlatButton(
          padding: EdgeInsets.all(0), 
          child: Image.asset(YYCommonUtils.Local_Icon_prefix+"back.png",width: 18,height: 18),
          onPressed: (){
            FlutterBoost.singleton.closePageForContext(context);
          },
        )
      ),
      body: YYBaseScrollWidget(
        control:control,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildBannelWidget(),
            _buildLatestBookWidget(),
            _buildPopularBookWidget(),
          ]
        ),
      ),
    );
  }
}