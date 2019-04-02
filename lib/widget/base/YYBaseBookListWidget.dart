import 'package:flutter/material.dart';

import 'package:lychee/widget/base/YYBaseListWidget.dart';
import 'package:lychee/common/util/YYCommonUtils.dart';
import 'package:lychee/common/style/YYStyle.dart';
import 'package:lychee/widget/YYCategoryWidget.dart';
import 'package:lychee/common/event/YYNeedRefreshEvent.dart';

class YYBaseBookListWidget extends StatefulWidget {
  ///item渲染
  final IndexedWidgetBuilder itemBuilder;
  ///加载更多回调
  final RefreshCallback onLoadMore;
  ///下拉刷新回调
  final RefreshCallback onRefresh;
  ///控制器，比如数据和一些配置
  final YYBaseBookListWidgetControl control;
  final String emptyTip;
  final Key refreshKey;
  final String widgetName;

  YYBaseBookListWidget({@required this.control,@required this.itemBuilder, @required this.widgetName,this.onRefresh, this.onLoadMore, this.emptyTip, this.refreshKey});

  @override
  _YYBaseBookListWidgetState createState() => _YYBaseBookListWidgetState();
}

class _YYBaseBookListWidgetState extends State<YYBaseBookListWidget> {

  _topCategoryOnPressed() {
    setState(() {
      widget.control.isCategorySelected = !widget.control.isCategorySelected;
      widget.control.isLibrarySelected = false;
      widget.control.isFrameSelected = false;
      if (widget.control.isCategorySelected==true) {
        widget.control.stackIndex = 1;
        widget.control.curCategoryName = "不限";
      } else {
        widget.control.stackIndex = 0;
        widget.control.cid = 0;
        widget.control.offset = 0;
        widget.control.last = 0;
        widget.control.curCategoryName = "分类";
        YYNeedRefreshEvent.refreshHandleFunction(widget.widgetName);
      }
    });
  }

  _topLibraryOnPressed() {
    setState(() {
      widget.control.isCategorySelected = false;
      widget.control.isLibrarySelected = !widget.control.isLibrarySelected;
      widget.control.isFrameSelected = false;
      if (widget.control.isLibrarySelected==true) {
        widget.control.stackIndex = 2;
      } else {
        widget.control.stackIndex = 0;
      }
    });
  }

  _topFrameOnPressed() {
    setState(() {
      widget.control.isCategorySelected = false;
      widget.control.isLibrarySelected = !widget.control.isLibrarySelected;
      widget.control.isFrameSelected = !widget.control.isFrameSelected;
      if (widget.control.isFrameSelected==true) {
        widget.control.stackIndex = 3;
      } else {
        widget.control.stackIndex = 0;
      }
    });
  }

  _categoryWidgetOnPressed(category) {
    setState(() {
      widget.control.isCategorySelected = false;
      widget.control.curCategoryName = category.name;
      widget.control.cid = category.id;
      widget.control.last = 0;
      widget.control.offset = 0;
      widget.control.stackIndex = 0;
    });
    YYNeedRefreshEvent.refreshHandleFunction(widget.widgetName??"");
  }

  _buildTopOptionWidget(title,onPressed) {
    return new Row( 
      children: <Widget>[
        FlatButton(
          padding: EdgeInsets.zero,
          onPressed: (){onPressed?.call();},
          child: SizedBox(
            width: 83.5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(title,style: TextStyle(color: Color(YYColors.primaryText),fontSize: YYSize.large,),maxLines: 1,overflow: TextOverflow.ellipsis),
                Image.asset(YYCommonUtils.Local_Icon_prefix+"drop_down.png",width: 10,height: 10,fit: BoxFit.fill)
              ],
            ),
          ),
        ),
        SizedBox(width: 21)
      ],
    );
  }

  _buildTopWidget() {
    return Container(
      height: 42,
      color: Color(YYColors.gray),
      child: Padding(
        padding: EdgeInsets.only(left: 10.5,right: 10.5),
        child: Row(
          children: <Widget>[
            (widget.control.options&YYBaseBookListWidgetControl.ShowCategory>0)?_buildTopOptionWidget(widget.control.curCategoryName, _topCategoryOnPressed):new Container(),

            (widget.control.options&YYBaseBookListWidgetControl.ShowLibrary  > 0)?_buildTopOptionWidget(widget.control.curLibraryName, _topLibraryOnPressed):new Container(),

            (widget.control.options&YYBaseBookListWidgetControl.ShowFrame>0)?_buildTopOptionWidget(widget.control.curFrameName, _topFrameOnPressed):new Container(),

            (widget.control.options&YYBaseBookListWidgetControl.ShowCount>0)?Expanded(
              child: Text("共"+widget.control.total.toString()+"本",style: TextStyle(color: Color(YYColors.primaryText),fontSize: YYSize.large),maxLines: 1,overflow: TextOverflow.ellipsis),
            ):new Container(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Container( 
      height:MediaQuery.of(context).size.height,
      child: Column( 
        children: <Widget>[
          _buildTopWidget(),
          Expanded(
            child: IndexedStack(
              children: <Widget>[
                new YYBaseListWidget(control: widget.control,itemBuilder: widget.itemBuilder,onRefresh: widget.onRefresh,onLoadMore: widget.onLoadMore,emptyTip: widget.emptyTip??"没有搜索到相关图书",refreshKey: widget.refreshKey),
                (widget.control.options&YYBaseBookListWidgetControl.ShowCategory>0)?new YYCategoryWidget(onPressed: (category){
                  _categoryWidgetOnPressed(category);
                }):new Container(),
                new Container(),
                new Container(),
              ],
              index: widget.control.stackIndex,
            )
          ),
        ],
      )
    );
  }
}

class YYBaseBookListWidgetControl extends YYBaseListWidgetControl {
  static const int ShowCategory = 1 << 0;
  static const int ShowLibrary = 1 << 1;
  static const int ShowFrame = 1 << 2;
  static const int ShowCount = 1 << 3;

  int options = 0;
  int cid = 0;
  double lid = 0;
  double fid = 0; 
  double last = 0;
  int offset = 0;
  int total = 0;
  bool hasNext = false;

  bool isCategorySelected = false;
  String curCategoryName = "分类" ;
  bool isLibrarySelected = false;
  String curLibraryName = "图书馆";
  bool isFrameSelected = false;
  String curFrameName = "书架";

  int stackIndex = 0;
}
