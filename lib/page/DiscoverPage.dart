import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:lychee/widget/base/BaseListState.dart';
import 'package:lychee/widget/base/BaseListWidget.dart';
import 'package:lychee/widget/base/BaseState.dart';
import 'package:lychee/common/util/CommonUtils.dart';
import 'package:lychee/common/style/Style.dart';
import './TopCollectionBookPage.dart';
import './TopReadingBookPage.dart';
import './TopReadBookPage.dart';
import 'package:lychee/widget/SeparatorWidget.dart';
import './NearLibraryPage.dart';

class DiscoverPage extends StatefulWidget {
  @override
  State<DiscoverPage> createState() {
    return _DiscoverPageState();
  }
}

class _DiscoverPageState extends State<DiscoverPage>  with AutomaticKeepAliveClientMixin<DiscoverPage>,BaseState<DiscoverPage>, BaseListState<DiscoverPage> {

  @override
  Future<bool> needNetworkRequest() async {
    return false;
  }

  @override
  bool get needRefreshHeader => false;

  @override
  bool get needRefreshFooter => false;

  @override
  dynamic get getData => [{"image":"found_fav.png","title":"大家都收藏"},{"image":"found_cut.png","title":"大家都在读"},{"image":"found_read.png","title":"大家都读过"},{"image":"found_location.png","title":"附近图书馆"}];

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
            SeparatorWidget()
          ],
        )
      ),
      onTap: () {
        if (index == 0) {
          CommonUtils.openPage(context, TopCollectionBookPage());
        } else if (index == 1) {
          CommonUtils.openPage(context, TopReadingBookPage());
        } else if (index == 2) {
          CommonUtils.openPage(context, TopReadBookPage());
        } else if (index ==3) {
          CommonUtils.openPage(context, NearLibraryPage());
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    
    return new Scaffold(
      appBar: new AppBar(
        title:Text("发现"),
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