import 'package:flutter/material.dart';

import 'package:lychee/widget/base/YYBaseListWidget.dart';
import 'package:lychee/common/util/YYCommonUtils.dart';
import 'package:lychee/common/style/YYStyle.dart';
import 'package:lychee/widget/YYCategoryWidget.dart';
import 'package:lychee/page/YYMineFramePage.dart';
import 'package:lychee/common/event/YYNeedRefreshEvent.dart';
import 'package:lychee/page/YYMineLibraryPage.dart';
import 'package:lychee/widget/base/YYBaseBookListWidget.dart';

class YYBaseBookRadioListWidget extends StatefulWidget {
  ///item渲染
  final IndexedWidgetBuilder itemBuilder;
  ///加载更多回调
  final RefreshCallback onLoadMore;
  ///下拉刷新回调
  final RefreshCallback onRefresh;
  ///控制器，比如数据和一些配置
  final YYBaseBookRadioListWidgetControl control;
  final String emptyTip;
  final Key refreshKey;
  final String widgetName;

  YYBaseBookRadioListWidget({@required this.control,@required this.itemBuilder, @required this.widgetName,this.onRefresh, this.onLoadMore, this.emptyTip, this.refreshKey});

  @override
  _YYBaseBookRadioListWidgetState createState() => _YYBaseBookRadioListWidgetState();
}

class _YYBaseBookRadioListWidgetState extends State<YYBaseBookRadioListWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea( 
      child: new Column(
        children: <Widget>[
          Expanded(
            child: new YYBaseBookListWidget(
              control: widget.control,
              onRefresh: widget.onRefresh,
              onLoadMore: widget.onLoadMore,
              refreshKey: widget.refreshKey,
              widgetName: widget.widgetName,
              itemBuilder: widget.itemBuilder,
            )
          ),
          Container(
            height: 47.0,
            color: Color(YYColors.gray),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(width: 10.5),
                Expanded(
                  child: Text("共选择"+widget.control.indexPaths.length.toString()+"本",style:TextStyle(color: Color(YYColors.primaryText),fontSize: YYSize.tip),overflow: TextOverflow.ellipsis)
                ),
                FlatButton(
                  padding: EdgeInsets.zero,
                  child: Container(
                    width: 104,
                    color: (widget.control.indexPaths.length==0)?Color(YYColors.disable):Color(YYColors.primary),
                    child: Center(
                      child: Text(widget.control.buttonName,style:TextStyle(color: Colors.white,fontSize: YYSize.tip),overflow: TextOverflow.ellipsis)
                    ),
                  ),
                  onPressed: () {
                    if (widget.control.indexPaths.length>0) {
                      widget.control.buttonOnPressed?.call();
                    }
                  }
                )
              ],
            ),
          )
        ],
      )
    );
  }
}

class YYBaseBookRadioListWidgetControl extends YYBaseBookListWidgetControl {
  int section = -1;
  List<Map> indexPaths = new List();
  String buttonName;
  VoidCallback buttonOnPressed;
}
