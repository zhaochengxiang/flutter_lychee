import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:amap_base_location/amap_base_location.dart';

import 'package:lychee/widget/base/BaseListState.dart';
import 'package:lychee/widget/base/BaseListWidget.dart';
import 'package:lychee/widget/base/BaseState.dart';
import 'package:lychee/common/util/CommonUtils.dart';
import 'package:lychee/common/model/Library.dart';
import 'package:lychee/widget/NearLibraryItem.dart';

class NearLibraryPage extends StatefulWidget {
  final Location location;
  NearLibraryPage(this.location);

  @override
  State<NearLibraryPage> createState() {
    return _NearLibraryPageState();
  }
}

class _NearLibraryPageState extends State<NearLibraryPage>  with AutomaticKeepAliveClientMixin<NearLibraryPage>,BaseState<NearLibraryPage>, BaseListState<NearLibraryPage> {

  @override
  bool get needRefreshHeader => false;

  @override
  bool get needRefreshFooter => false;

  @override
  remotePath() {
    return "/library/findNear";
  }

  @override
  generateRemoteParams() {
    return {"latitude":widget.location.latitude,"longitude":widget.location.longitude};
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
    super.build(context);
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
        emptyTip: "附近没有图书馆",
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