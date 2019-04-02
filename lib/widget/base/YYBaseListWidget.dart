import 'package:flutter/material.dart';

import 'package:lychee/common/style/YYStyle.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:lychee/widget/base/YYBaseDecorationState.dart';
import 'package:lychee/Widget/base/YYBaseScrollWidget.dart';
import 'package:lychee/widget/YYSeparatorWidget.dart';

class YYBaseListWidget extends StatefulWidget {
  ///item渲染
  final IndexedWidgetBuilder itemBuilder;
  ///加载更多回调
  final RefreshCallback onLoadMore;
  ///下拉刷新回调
  final RefreshCallback onRefresh;
  ///控制器，比如数据和一些配置
  final YYBaseListWidgetControl control;
  final String emptyTip;
  final Key refreshKey;

  YYBaseListWidget({this.control, this.itemBuilder, this.onRefresh, this.onLoadMore, this.emptyTip, this.refreshKey});

  @override
  _YYBaseListWidgetState createState() => _YYBaseListWidgetState();
}

class _YYBaseListWidgetState extends State<YYBaseListWidget> with YYBaseDecorationState<YYBaseListWidget> {

  _YYBaseListWidgetState();

  final GlobalKey<RefreshHeaderState> _refreshHeaderKey = new GlobalKey<RefreshHeaderState>();
  final GlobalKey<RefreshFooterState> _refreshFooterKey = new GlobalKey<RefreshFooterState>();

  ///根据配置状态返回实际列表数量
  ///实际上这里可以根据你的需要做更多的处理
  ///比如多个头部，是否需要空页面，是否需要显示加载更多。
  _getListCount() {
    if (widget.control.needHeader) {
      ///是否需要头部
      ///如果需要头部，用Item 0 的 Widget 作为ListView的头部
      return widget.control.dataList.length + 1;
    } else {
      ///如果不需要头部，在没有数据时，固定返回数量1用于空页面呈现
      if (widget.control.dataList.length == 0) {
        return 1;
      }

      ///如果有数据,因为部加载更多选项，需要对列表数据总数+1
      return widget.control.dataList.length;
    }
  }

  @override
  Widget buildDecoration(control, onRefresh, emptyTip) {
    if (control.isLoading&&control.dataList.length==0) {
      return buildActivityIndicator();
    } else if (!control.isLoading&&control.errorMessage.length!=0) {
      ///网络请求出错显示提示框
      return buildErrorTip(control.errorMessage,onRefresh);
    } else if (!control.needHeader && control.dataList.length == 0) {
      ///如果不需要头部，并且数据为0，渲染空页面
      return buildEmpty(emptyTip);
    } 

    return null;
  }


  @override
  Widget build(BuildContext context) {
    Widget decoration = buildDecoration(widget.control,widget.onRefresh,widget.emptyTip);
    if (decoration != null) return decoration; 

    return new SafeArea( 
      child: new EasyRefresh(
        ///GlobalKey，用户外部获取RefreshIndicator的State，做显示刷新
        key: widget.refreshKey,
        refreshHeader: ClassicsHeader(
          key: _refreshHeaderKey,
          refreshText: "下拉刷新",
          refreshReadyText: "释放刷新",
          refreshingText: "正在刷新...",
          refreshedText: "刷新结束",
          moreInfo: "更新于 %T",
          showMore: true,
          bgColor: Colors.white,
          textColor: Color(YYColors.primaryText),
          moreInfoColor: Color(YYColors.secondaryText),
        ),
        refreshFooter: ClassicsFooter(
          key: _refreshFooterKey,
          loadText: "上拉加载",
          loadReadyText: "释放加载",
          loadingText: "正在加载",
          loadedText: "加载结束",
          noMoreText: "没有更多数据",
          moreInfo: "更新于 %T",
          bgColor: Colors.white,
          textColor: Color(YYColors.primaryText),
          moreInfoColor: Color(YYColors.secondaryText),
          showMore: true,
        ),
        onRefresh:(widget.control.needRefreshHeader)?widget.onRefresh:null,
        loadMore:(widget.control.needRefreshFooter)?widget.onLoadMore:null,
        child: new ListView.separated(
          separatorBuilder: (context, index)=>YYSeparatorWidget(),
          itemBuilder: (context, index) {
            return widget.itemBuilder(context, index);
          },

          ///根据状态返回数量
          itemCount: _getListCount(),
        ),
      )
    );
  }
}

class YYBaseListWidgetControl extends YYBaseScrollWidgetControl {
  ///数据，对齐增减，不能替换
  List dataList = new List();

  ///是否需要上拉刷新
  bool needRefreshFooter = true;
  ///是否需要头部
  bool needHeader = false;
}
