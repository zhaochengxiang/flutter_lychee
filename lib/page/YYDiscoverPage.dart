import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:lychee/widget/base/YYBaseListState.dart';
import 'package:lychee/widget/base/YYBaseListWidget.dart';
import 'package:lychee/widget/base/YYBaseState.dart';
import 'package:lychee/common/util/YYCommonUtils.dart';
import 'package:lychee/common/style/YYStyle.dart';

class YYDiscoverPage extends StatefulWidget {
  @override
  State<YYDiscoverPage> createState() {
    return _YYDiscoverPageState();
  }
}

class _YYDiscoverPageState extends State<YYDiscoverPage>  with AutomaticKeepAliveClientMixin<YYDiscoverPage>,YYBaseState<YYDiscoverPage>, YYBaseListState<YYDiscoverPage> {

  @override
  Future<bool> needNetworkRequest() async {
    return false;
  }

  @override
  bool get needRefreshHeader => false;

  @override
  bool get needRefreshFooter => false;

  @override
  List get getDataList => [{"image":"found_fav.png","title":"大家都收藏"},{"image":"found_cut.png","title":"大家都在读"},{"image":"found_read.png","title":"大家都读过"},{"image":"found_location.png","title":"附近图书馆"}];

  _renderListItem(data) {
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
        
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    
    YYBaseListWidgetControl control = baseWidgetControl;

    return new Scaffold(
      appBar: new AppBar(
        title:Text("发现"),
        centerTitle: true,
      ),
      body: YYBaseListWidget(
        control: control,
        itemBuilder: (BuildContext context, int index) => _renderListItem(control.dataList[index]),
        refreshKey: refreshIndicatorKey,
      ),
    );
  }
}