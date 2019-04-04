import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:lychee/widget/base/YYBaseListState.dart';
import 'package:lychee/widget/base/YYBaseState.dart';
import 'package:lychee/widget/base/YYBaseBookListState.dart';
import 'package:lychee/widget/base/YYBaseBookListWidget.dart';
import 'package:lychee/common/util/YYCommonUtils.dart';
import 'package:lychee/common/style/YYStyle.dart';
import 'package:lychee/common/model/YYBook.dart';
import 'package:lychee/common/model/YYFrame.dart';

class YYMineCollectionBookPage extends StatefulWidget {
  @override
  _YYMineCollectionBookPageState createState() => _YYMineCollectionBookPageState();
}

class _YYMineCollectionBookPageState extends State<YYMineCollectionBookPage> with AutomaticKeepAliveClientMixin<YYMineCollectionBookPage>,YYBaseState<YYMineCollectionBookPage>, YYBaseListState<YYMineCollectionBookPage>,YYBaseBookListState<YYMineCollectionBookPage> {
  @override
  remotePath() {
    return "/collection/search";
  }

  @override
  bool get needLibrary => false;

  @override
  bool get needSlide => true;

  @override
  List<Widget> slideActions(context,index) {
    return <Widget>[
      IconSlideAction(
        caption: '定位',
        color: Color(YYColors.primary),
        icon: Icons.location_on,
        onTap: () {
          _location(context,index);
        },
      ),
      IconSlideAction(
        caption: '删除',
        color: Colors.red,
        icon: Icons.delete,
        onTap: () {
          _delete(context, index);
        },
      ),
    ];
  }

  @override
  String get categoryRemotePath => "/category/findCollection";

  _location(context,index) async{
    YYBook book = control.data[index];
    var res = await handleNotAssociatedWithRefreshRequest(context, "/frame/findMyByBid", {"bid":book.id.toInt()});
    if (res!=null && res.result && res.data!=null) {
      YYFrame frame = YYFrame.fromJson(res.data);
      showDialog<void>(
        context: context,
        barrierDismissible: true, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('所属书架'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(frame.name,style:TextStyle(color: Color(YYColors.primaryText),fontSize: YYSize.large),overflow: TextOverflow.ellipsis)
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('确定',style: TextStyle(color: Color(YYColors.secondaryText),fontSize: YYSize.medium),overflow: TextOverflow.ellipsis),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
      );
    }
  }

  _delete(context,index) async{
    YYBook book = control.data[index];
    var res = await handleNotAssociatedWithRefreshRequest(context, "/collection/delete", {"bid":book.id.toInt()});
    if (res!=null && res.result && res.data!=null) {
      if (isShow) {
        setState(() {
          control.data = control.data.removeAt(index);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        leading: IconButton(
          icon: new Image.asset(YYCommonUtils.Local_Icon_prefix+"back.png",width: 24.0,height: 24.0),
          onPressed: () {
            YYCommonUtils.closePage(context);
          }),
        title:Text("我的藏书"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
          icon: new Image.asset(YYCommonUtils.Local_Icon_prefix+"search.png",width: 24.0,height: 24.0),
          onPressed: () {

          })
        ]
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child:  YYBaseBookListWidget(
                control:control,
                onRefresh: handleRefresh,
                onLoadMore: onLoadMore,
                refreshKey: refreshIndicatorKey,
                widgetName: widget.runtimeType.toString(),
                itemBuilder: (BuildContext context, int index) => renderListItem(context,index),
              ),
            ),
            Container(
              height: 47.0,
              color: Color(YYColors.gray),
              child: Align(
                alignment: Alignment.centerRight,
                child: FlatButton(
                    padding: EdgeInsets.zero,
                    child: Container(
                      width: 104,
                      height: 47.0,
                      color: Color(YYColors.primary),
                      child: Center( 
                        child: Text("扫描添加",style:TextStyle(color: Colors.white,fontSize: YYSize.tip),overflow: TextOverflow.ellipsis)
                      )
                    ),
                    onPressed: () {
                      
                    }
                ),
              )
            )
          ],
        ),
      )
    );
  }
}