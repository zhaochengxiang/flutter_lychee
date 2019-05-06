import 'package:flutter/material.dart';

import 'package:lychee/widget/base/BaseListState.dart';
import 'package:lychee/widget/base/BaseState.dart';
import 'package:lychee/widget/base/BaseBookListState.dart';
import 'package:lychee/widget/base/BaseBookListWidget.dart';
import 'package:lychee/common/util/CommonUtils.dart';
import 'package:lychee/common/event/NeedRefreshEvent.dart';
import 'package:lychee/common/style/Style.dart';
import './SearchPage.dart';
import 'package:lychee/common/model/Search.dart';

class SearchBookPage extends StatefulWidget {
  final String keyword;
  SearchBookPage({this.keyword});

  @override
  _SearchBookPageState createState() => _SearchBookPageState();
}

class _SearchBookPageState extends State<SearchBookPage> with AutomaticKeepAliveClientMixin<SearchBookPage>,BaseState<SearchBookPage>, BaseListState<SearchBookPage>,BaseBookListState<SearchBookPage> {

  @override
  bool get needFrame => false;

  @override
  bool get needCount => false;

  @override
  String get searchKeyword => widget.keyword;
  
  @override
  remotePath() {
    return "/book/search";
  }

   _searchPageOnPressed(value) {
    setState(() {
      control.keyword = value;
    });
    NeedRefreshEvent.refreshHandleFunction("SearchBookPage");
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        leading: IconButton(
          icon: new Image.asset(CommonUtils.Local_Icon_prefix+"back.png",width: 18.0,height: 18.0),
          onPressed: () {
            CommonUtils.closePage(context);
          }),
        title:InkWell(
          onTap: (){CommonUtils.openPage(context, SearchPage(type:Search.SEARCH_BOOK,onPressed: _searchPageOnPressed));},
          child: Container(
            height: 31,
            color:Color(YYColors.gray_dark),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(width: 5.0),
                Image.asset(CommonUtils.Local_Icon_prefix+'search_gray.png',width: 13,height: 14,fit: BoxFit.fill),
                SizedBox(width: 5.0),
                Expanded(
                  child:Text(control.keyword,style: TextStyle(color: Color(YYColors.secondaryText),fontSize: YYSize.tip),overflow: TextOverflow.ellipsis,maxLines: 1)                   
                ),
                SizedBox(width: 5.0)
              ],
            ),
          )
        ),
      ),
      body: BaseBookListWidget(
        control:control,
        onRefresh: handleRefresh,
        onLoadMore: onLoadMore,
        refreshKey: refreshIndicatorKey,
        widgetName: widget.runtimeType.toString(),
        itemBuilder: (BuildContext context, int index) => renderListItem(index),
      )
    );
  }
}