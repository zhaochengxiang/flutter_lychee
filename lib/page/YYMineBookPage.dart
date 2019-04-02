import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:lychee/widget/base/YYBaseListState.dart';
import 'package:lychee/widget/base/YYBaseListWidget.dart';
import 'package:lychee/widget/base/YYBaseState.dart';
import 'package:lychee/common/util/YYCommonUtils.dart';
import 'package:lychee/common/style/YYStyle.dart';
import './YYMineCollectionBookPage.dart';

class YYMineBookPage extends StatefulWidget {
  @override
  State<YYMineBookPage> createState() {
    return _YYMineBookPageState();
  }
}

class _YYMineBookPageState extends State<YYMineBookPage>  with AutomaticKeepAliveClientMixin<YYMineBookPage>,YYBaseState<YYMineBookPage>, YYBaseListState<YYMineBookPage> {

  @override
  Future<bool> needNetworkRequest() async {
    return false;
  }

  @override
  bool get needRefreshHeader => false;

  @override
  bool get needRefreshFooter => false;

  @override
  List get getDataList => [{"image":"found_read.png","title":"我的藏书"},{"image":"found_want.png","title":"我想读的"},{"image":"found_location.png","title":"我共享的"},{"image":"found_mark.png","title":"我想借的"},{"image":"found_fav.png","title":"我借到的"},{"image":"found_cut.png","title":"我借出的"}];

  _renderListItem(index) {
    YYBaseListWidgetControl control = baseWidgetControl;
    var data = control.dataList[index];

    return FlatButton( 
      padding: EdgeInsets.all(0),
      child:Container(
        height: 58.5, 
        child:new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child:ListTile(
                leading: Image.asset(YYCommonUtils.Local_Icon_prefix+data['image'],width:33.0,height:33.0),
                title: Text(data['title'],style: TextStyle(color: Color(YYColors.primaryText),fontSize: YYSize.large), overflow: TextOverflow.ellipsis),
                trailing: new Icon(Icons.keyboard_arrow_right),
              )
            ),
            Padding(
              padding:EdgeInsets.only(left:10.5,right:10.5),
              child:Divider(height: 0.5,color:Color(YYColors.divider)),
            )
          ],
        )
      ),
      onPressed: () {
        if (index == 0) {
          YYCommonUtils.openPage(context, YYMineCollectionBookPage());
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    
    return new Scaffold(
      appBar: new AppBar(
        leading: IconButton(
          icon: new Image.asset(YYCommonUtils.Local_Icon_prefix+"back.png",width: 24.0,height: 24.0),
          onPressed: () {
            YYCommonUtils.closePage(context);
          }
        ),
        title:Text("我的图书"),
        centerTitle: true,
      ),
      body: YYBaseListWidget(
        control: baseWidgetControl,
        itemBuilder: (BuildContext context, int index) => _renderListItem(index),
        refreshKey: refreshIndicatorKey,
      ),
    );
  }
}