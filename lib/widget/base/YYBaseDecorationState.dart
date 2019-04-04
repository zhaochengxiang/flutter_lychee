import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart' as Cupertino;

import 'package:lychee/common/style/YYStyle.dart';

mixin YYBaseDecorationState<T extends StatefulWidget> on State<T> {

  @protected
  Widget buildActivityIndicator() {
    return new Center(
      child: new Cupertino.CupertinoActivityIndicator(),
    );
  }

  @protected
  Widget buildErrorTip(errorMessage,onRefresh) {
    return new GestureDetector( 
      onTap: () {
        onRefresh?.call();
      },
      child:new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text( errorMessage,style: TextStyle(color: Color(YYColors.tip),fontSize: YYSize.tip)),
            Text( "轻触屏幕重新加载",style: TextStyle(color: Color(YYColors.tip),fontSize: YYSize.tip))
          ],
        ),
      )
    );
  }

  ///空页面
  @protected
  Widget buildEmpty(emptyTip) {
    return new Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text( emptyTip??"没有数据",style: TextStyle(color: Color(YYColors.primaryText),fontSize: YYSize.large))
          )
        ],
      ),
    );
  }

  @protected
  Widget buildDecoration(control,onRefresh,emptyTip) {
    if (control.isLoading&&control.data==null) {
      return buildActivityIndicator();
    } else if (!control.isLoading&&control.errorMessage.length!=0) {
      return buildErrorTip(control.errorMessage,onRefresh);
    } else {
      if (control.data==null|| ((control.data is Map)&&control.data.isEmpty) || ((control.data is List)&&control.data.length==0))
      return buildEmpty(emptyTip);
    } 

    return null;
  }
}