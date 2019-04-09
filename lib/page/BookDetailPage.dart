import 'package:flutter/material.dart';

import 'package:lychee/widget/base/BaseState.dart';
import 'package:lychee/widget/base/BaseScrollSate.dart';
import 'package:lychee/widget/base/BaseScrollWidget.dart';
import 'package:lychee/widget/BookItem.dart';
import 'package:lychee/common/model/RichBook.dart';
import 'package:lychee/common/util/CommonUtils.dart';
import 'package:lychee/widget/SectionWdiget.dart';
import 'package:lychee/widget/BookGrid.dart';
import 'package:lychee/common/style/Style.dart';
import 'package:lychee/common/event/NeedRefreshEvent.dart';

class BookDetailPage extends StatefulWidget {
  final Map params;
  BookDetailPage(this.params) :super();

  @override
  _BookDetailPageState createState() => _BookDetailPageState(params);
}

class _BookDetailPageState extends State<BookDetailPage> with AutomaticKeepAliveClientMixin<BookDetailPage>,BaseState<BookDetailPage>, BaseScrollState<BookDetailPage> {
  Map params;
  RichBook richBook;

  _BookDetailPageState(this.params) :super();
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
    return RichBook.fromJson(json);
  }

  @override
  Widget build(BuildContext context) {
    richBook = control.data;

    return new Scaffold(
      appBar: new AppBar(
        title:Text("图书详情"),
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
          icon: new Image.asset(CommonUtils.Local_Icon_prefix+"more.png",width: 18.0,height: 18.0),
          onPressed: () {

          })
        ]
      ),
      body: BaseScrollWidget(
        control:control,
        onRefresh:handleRefresh,
        refreshKey: refreshIndicatorKey,
        child: (richBook==null)?new Container():new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            (richBook.book==null)?new Container():BookItem(book:richBook.book,height:146),
            (richBook.book==null||richBook.book.summary==null||richBook.book.summary.length==0)?new Container():new Column(
              children: <Widget>[
                SectionWidget(title: "内容简介"),
                Padding(
                  padding: EdgeInsets.only(left: 10.5,right: 10.5),
                  child: Text(richBook.book.summary,style:TextStyle(color: Color(YYColors.primaryText),fontSize: YYSize.large,letterSpacing: 0,height:1.2)),
                )
              ],
            ),
            (richBook.favoriteList==null||richBook.favoriteList.length==0)?new Container():new Column(
              children: <Widget>[
                SectionWidget(title: "相关图书"),
                BookGrid(richBook.favoriteList,onPressed: (book) {
                  params["uuid"] = book.uuid??"";
                  NeedRefreshEvent.refreshHandleFunction("BookDetailPage");
                }),
              ],
            ),
          ]
        ),
      ),
    );
  }
}