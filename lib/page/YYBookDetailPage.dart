import 'package:flutter/material.dart';

import 'package:lychee/widget/base/YYBaseState.dart';
import 'package:lychee/widget/base/YYBaseScrollSate.dart';
import 'package:lychee/widget/base/YYBaseScrollWidget.dart';
import 'package:lychee/widget/YYBookItem.dart';
import 'package:lychee/common/model/YYRichBook.dart';
import 'package:lychee/common/util/YYCommonUtils.dart';
import 'package:lychee/widget/YYSectionWdiget.dart';
import 'package:lychee/widget/YYBookGrid.dart';
import 'package:lychee/common/style/YYStyle.dart';
import 'package:lychee/common/event/YYNeedRefreshEvent.dart';

class YYBookDetailPage extends StatefulWidget {
  final Map params;
  YYBookDetailPage(this.params) :super();

  @override
  _YYBookDetailPageState createState() => _YYBookDetailPageState(params);
}

class _YYBookDetailPageState extends State<YYBookDetailPage> with AutomaticKeepAliveClientMixin<YYBookDetailPage>,YYBaseState<YYBookDetailPage>, YYBaseScrollState<YYBookDetailPage> {
  Map params;
  YYRichBook richBook;

  _YYBookDetailPageState(this.params) :super();
  @override
  remotePath() {
    return "/book/get";
  }

  @override
  generateRemoteParams() {
    return {"uuid":params['uuid'],"lid":params['lid']};    
  }

  @override
  jsonConvertToModel(Map<String,dynamic> json) {
    return YYRichBook.fromJson(json);
  }

  @override
  Widget build(BuildContext context) {
    richBook = baseWidgetControl.data;

    return new Scaffold(
      appBar: new AppBar(
        title:Text("图书详情"),
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
          icon: new Image.asset(YYCommonUtils.Local_Icon_prefix+"more.png",width: 24.0,height: 24.0),
          onPressed: () {

          })
        ]
      ),
      body: YYBaseScrollWidget(
        control:baseWidgetControl,
        onRefresh:handleRefresh,
        refreshKey: refreshIndicatorKey,
        child: (richBook==null)?new Container():new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            (richBook.book==null)?new Container():YYBookItem(book:richBook.book,height:146),
            (richBook.book==null||richBook.book.summary==null||richBook.book.summary.length==0)?new Container():new Column(
              children: <Widget>[
                YYSectionWidget(title: "内容简介"),
                Padding(
                  padding: EdgeInsets.only(left: 10.5,right: 10.5),
                  child: Text(richBook.book.summary,style:TextStyle(color: Color(YYColors.primaryText),fontSize: YYSize.large,letterSpacing: 0,height:1.2)),
                )
              ],
            ),
            (richBook.favoriteList==null||richBook.favoriteList.length==0)?new Container():new Column(
              children: <Widget>[
                YYSectionWidget(title: "相关图书"),
                YYBookGrid(richBook.favoriteList,onPressed: (book) {
                  params["uuid"] = book.uuid??"";
                  YYNeedRefreshEvent.refreshHandleFunction("YYBookDetailPage");
                }),
              ],
            ),
          ]
        ),
      ),
    );
  }
}