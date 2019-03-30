import 'package:flutter/material.dart';

import 'package:lychee/widget/base/YYBaseState.dart';
import 'package:lychee/widget/base/YYBaseScrollSate.dart';
import 'package:lychee/widget/base/YYBaseScrollWidget.dart';
import 'package:lychee/widget/YYBookItem.dart';
import 'package:lychee/common/model/YYRichBook.dart';
import 'package:lychee/common/util/YYCommonUtils.dart';
import 'package:lychee/widget/YYSectionWdiget.dart';
import 'package:lychee/widget/YYBookGrid.dart';

class YYBookDetailPage extends StatefulWidget {
  final Map params;
  YYBookDetailPage(this.params) :super();

  @override
  _YYBookDetailPageState createState() => _YYBookDetailPageState();
}

class _YYBookDetailPageState extends State<YYBookDetailPage> with AutomaticKeepAliveClientMixin<YYBookDetailPage>,YYBaseState<YYBookDetailPage>, YYBaseScrollState<YYBookDetailPage> {
  @override
  remotePath() {
    return "/book/get";
  }

  @override
  generateRemoteParams() {
    return {"uuid":widget.params['uuid'],"lid":widget.params['lid']};    
  }

  @override
  jsonConvertToModel(Map<String,dynamic> json) {
    return YYRichBook.fromJson(json);
  }

  @override
  Widget build(BuildContext context) {
    YYBaseScrollWidgetControl control = baseWidgetControl;
    YYRichBook richBook = control.data;

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
      ),
      body: YYBaseScrollWidget(
        control:control,
        onRefresh:handleRefresh,
        refreshKey: refreshIndicatorKey,
        child: (richBook==null)?new Container():new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            (richBook.book==null)?new Container():YYBookItem(book:richBook.book,height:146,onPressed: (){},),
            (richBook.favoriteList==null||richBook.favoriteList.length==0)?new Container():new Column(
              children: <Widget>[
                YYSectionWidget(title: "相关图书"),
                YYBookGrid(richBook.favoriteList),
              ],
            ),
          ]
        ),
      ),
    );
  }
}