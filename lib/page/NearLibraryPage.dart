import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:lychee/widget/base/BaseListState.dart';
import 'package:lychee/widget/base/BaseListWidget.dart';
import 'package:lychee/widget/base/BaseState.dart';
import 'package:lychee/common/style/Style.dart';
import 'package:lychee/common/util/CommonUtils.dart';
import 'package:lychee/common/manager/MapManager.dart';
import 'package:amap_base/amap_base.dart';
import 'package:lychee/common/model/Library.dart';
import 'package:lychee/widget/NearLibraryItem.dart';

class NearLibraryPage extends StatefulWidget {
  @override
  State<NearLibraryPage> createState() {
    return _NearLibraryPageState();
  }
}

class _NearLibraryPageState extends State<NearLibraryPage>  with AutomaticKeepAliveClientMixin<NearLibraryPage>,BaseState<NearLibraryPage>, BaseListState<NearLibraryPage> {

  bool permission;
  Location location;

  @override
  bool get needRefreshHeader => false;

  @override
  bool get needRefreshFooter => false;

  @override
  Future<bool> needNetworkRequest() async {
    var res =  await MapManager.requestPermission();
    
    setState(() {
      permission = res;
    });

    if (permission == false) {
      return false;
    } else {
      location = await MapManager.getLocation();
      return true;
    }
  }

  @override
  remotePath() {
    return "/library/findNear";
  }

  @override
  generateRemoteParams() {
    return {"latitude":location.latitude,"longitude":location.longitude};
  }

  @override
  jsonConvertToModel(Map<String,dynamic> json) {
    return Library.fromJson(json);
  }

  _renderListItem(index) {
    Library library = control.data[index];
    return new NearLibraryItem(library,onPressed: (){

    });
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
        title:Text("附近的图书馆"),
        centerTitle: true,
      ),
      body: BaseListWidget(
        control:control,
        refreshKey: refreshIndicatorKey,
        emptyTip: (permission==true)?"附近没有图书馆":"定位服务未开启",
        itemBuilder: (BuildContext context, int index) => _renderListItem(index),
      )
    );
  }
}

class AboutModel {
  String title;
  String desc;
  AboutModel({this.title,this.desc});
}