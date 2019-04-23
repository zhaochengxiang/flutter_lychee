import 'package:flutter/material.dart';

import 'package:lychee/widget/base/BaseScrollState.dart';
import 'package:lychee/widget/base/BaseScrollWidget.dart';
import 'package:lychee/widget/base/BaseState.dart';
import 'package:lychee/common/model/BookHome.dart';
import 'package:lychee/common/model/Book.dart';
import 'package:lychee/common/util/CommonUtils.dart';
import 'package:lychee/widget/BookGrid.dart';
import 'package:lychee/common/style/Style.dart';
import 'package:lychee/widget/SwiperWidget.dart';
import 'package:lychee/widget/SectionWdiget.dart';
import 'package:lychee/common/model/Search.dart';
import './BookDetailPage.dart';
import './TopPopularBookPage.dart';
import './TopLatestBookPage.dart';
import './SearchPage.dart';
import './SearchBookPage.dart';

class HomeBookPage extends StatefulWidget {
  @override
  _HomeBookPageState createState() => _HomeBookPageState();
}

class _HomeBookPageState extends State<HomeBookPage> with AutomaticKeepAliveClientMixin<HomeBookPage>,BaseState<HomeBookPage>, BaseScrollState<HomeBookPage> {
  
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
    return BookHome.fromJson(json);
  }

  _buildBannelWidget() {
    if (control.data==null) return new Container();

    var fineBooks = control.data.fineList;
    List urls = List();
    if (fineBooks != null) {
      for (int i=0;i<fineBooks.length;i++) {
        Book book = fineBooks[i];
        urls.add(book.cover);
      }
    }

    return (fineBooks==null||fineBooks.length==0)?new Container():new SwiperWidget(
      height: 125,
      imageUrls: urls,
      dotActiveColor: Color(YYColors.primary),
      selectItemChanged:(selectIndex) {
       Book book = fineBooks[selectIndex];
        CommonUtils.openPage(context, BookDetailPage({"lid":0,"uuid":book.uuid}));
      },
    );
  }

  _buildLatestBookWidget() {
    if (control.data == null) return new Container();
    
    var latestBooks = control.data.latestList;
    return (latestBooks==null||latestBooks.length==0)?new Container():new Column(
      children: <Widget>[
        SectionWidget(
          title: "新书推荐",
          subtitle: "更多",
          onPressed: () {
            CommonUtils.openPage(context, TopLatestBookPage());
          },
        ),
        new BookGrid(latestBooks),
      ],
    ); 
  }

  _buildPopularBookWidget() {
    if (control.data == null) return new Container();
    
    var popularBooks = control.data.topPopularList;
    return (popularBooks==null||popularBooks.length==0)?new Container():new Column(
      children: <Widget>[
        SectionWidget(
          title: "热门图书",
          subtitle: "更多",
          onPressed: () {
            CommonUtils.openPage(context, TopPopularBookPage());
          },
        ),
        new BookGrid(popularBooks),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title:Text("图书"),
        centerTitle: true,
        leading: IconButton(
          icon: Image.asset(CommonUtils.Local_Icon_prefix+"back.png",width: 18,height: 18),
          onPressed: (){
            CommonUtils.closePage(context);
          },
        ),
        actions: <Widget>[
          IconButton(
          icon: new Image.asset(CommonUtils.Local_Icon_prefix+"search_gray.png",width: 18.0,height: 18.0),
          onPressed: () {
            CommonUtils.openPage(context, SearchPage(type:Search.SEARCH_BOOK, onPressed:(keyword) {
              CommonUtils.openPage(context, SearchBookPage(keyword: keyword));
            }));
          })
        ]
      ),
      body: BaseScrollWidget(
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