import 'package:flutter/material.dart';

import 'package:lychee/widget/base/BaseListState.dart';
import 'package:lychee/widget/base/BaseState.dart';
import 'package:lychee/widget/base/BaseBookListState.dart';
import 'package:lychee/widget/base/BaseBookListWidget.dart';
import 'package:lychee/common/util/CommonUtils.dart';
import 'package:lychee/common/style/Style.dart';
import 'package:lychee/common/model/Library.dart';
import './MineUnShareBookPage.dart';

class MineShareBookPage extends StatefulWidget {
  @override
  _MineShareBookPageState createState() => _MineShareBookPageState();
}

class _MineShareBookPageState extends State<MineShareBookPage> with AutomaticKeepAliveClientMixin<MineShareBookPage>,BaseState<MineShareBookPage>, BaseListState<MineShareBookPage>,BaseBookListState<MineShareBookPage> {

  @override
  bool get needFrame => false;
  
  @override
  remotePath() {
    return "/copy/findMyShare";
  }

  @override
  String get categoryRemotePath => "/category/findMyShare";

  @override
  String get libraryRemotePath => "/library/findOpenShare";

  _share() async {
    var res = await handleNotAssociatedWithRefreshRequest(context, "/library/findOpenShare", {});
    if (res!=null && res.result && res.data!=null) {
      List<Widget> childWidgets = List();
      for (int i = 0; i < res.data.length; i++) {
        Library library = Library.fromJson(res.data[i]);
        childWidgets.add(
          InkWell(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(library.name,style:TextStyle(color: Color(YYColors.primaryText),fontSize: YYSize.large),overflow: TextOverflow.ellipsis)
            ),
            onTap: (){
              Navigator.of(context).pop();
              CommonUtils.openPage(context, MineUnShareBookPage(library.id));
            }
          )
        );
      }

      showDialog<void>(
        context: context,
        barrierDismissible: true, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('请选择图书馆'),
            content: SingleChildScrollView(
              child: ListBody(
                children: childWidgets,
              ),
            ),
          );
        }
      );
    }
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
        title:Text("我共享的"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child:  BaseBookListWidget(
                control:control,
                onRefresh: handleRefresh,
                onLoadMore: onLoadMore,
                refreshKey: refreshIndicatorKey,
                widgetName: widget.runtimeType.toString(),
                itemBuilder: (BuildContext context, int index) => renderListItem(index),
              ),
            ),
            Container(
              height: 47.0,
              color: Color(YYColors.gray),
              child: Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                    child: Container(
                      width: 104,
                      height: 47.0,
                      color: Color(YYColors.primary),
                      child: Center( 
                        child: Text("共享图书",style:TextStyle(color: Colors.white,fontSize: YYSize.tip),overflow: TextOverflow.ellipsis)
                      )
                    ),
                    onTap: () {
                      _share();
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