import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:lychee/widget/base/BaseListState.dart';
import 'package:lychee/widget/base/BaseListWidget.dart';
import 'package:lychee/widget/base/BaseState.dart';
import 'package:lychee/common/util/CommonUtils.dart';
import 'package:lychee/common/style/Style.dart';
import './MineCollectionBookPage.dart';
import './MineWantReadBookPage.dart';
import './MineShareBookPage.dart';
import './MineWantBorrowBookPage.dart';
import './MineBorrowedBookPage.dart';
import './MineLentBookPage.dart';

class MineBookPage extends StatefulWidget {
  @override
  State<MineBookPage> createState() {
    return _MineBookPageState();
  }
}

class _MineBookPageState extends State<MineBookPage>  with AutomaticKeepAliveClientMixin<MineBookPage>,BaseState<MineBookPage>, BaseListState<MineBookPage> {

  @protected
  bool get needNetworkRequest => false;

  @override
  bool get needRefreshHeader => false;

  @override
  bool get needRefreshFooter => false;

  @override
  dynamic get getData => [{"image":"found_read.png","title":"我的藏书"},{"image":"found_want.png","title":"我想读的"},{"image":"found_location.png","title":"我共享的"},{"image":"found_mark.png","title":"我想借的"},{"image":"found_fav.png","title":"我借到的"},{"image":"found_cut.png","title":"我借出的"}];

  _renderListItem(index) {
    var data = control.data[index];

    return InkWell( 
      child:Container(
        height: 58.5, 
        child:new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child:ListTile(
                leading: Image.asset(CommonUtils.Local_Icon_prefix+data['image'],width:33.0,height:33.0),
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
      onTap: () {
        if (index == 0) {
          CommonUtils.openPage(context, MineCollectionBookPage());
        } else if (index == 1) {
          CommonUtils.openPage(context, MineWantReadBookPage());
        } else if (index == 2) {
          CommonUtils.openPage(context, MineShareBookPage());
        } else if (index == 3) {
          CommonUtils.openPage(context, MineWantBorrowBookPage());
        } else if (index == 4) {
          CommonUtils.openPage(context, MineBorrowedBookPage());
        } else if (index == 5) {
          CommonUtils.openPage(context, MineLentBookPage());
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    
    return new Scaffold(
      appBar: new AppBar(
        leading: IconButton(
          icon: new Image.asset(CommonUtils.Local_Icon_prefix+"back.png",width: 18.0,height: 18.0),
          onPressed: () {
            CommonUtils.closePage(context);
          }
        ),
        title:Text("我的图书"),
        centerTitle: true,
      ),
      body: BaseListWidget(
        control: control,
        itemBuilder: (BuildContext context, int index) => _renderListItem(index),
        refreshKey: refreshIndicatorKey,
      ),
    );
  }
}