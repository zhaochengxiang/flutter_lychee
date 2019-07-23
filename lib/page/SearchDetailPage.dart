import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:lychee/common/util/CommonUtils.dart';
import 'package:lychee/common/style/Style.dart';
import 'package:lychee/widget/CategoryWidget.dart';
import './SearchPage.dart';
import './SearchDetailCompositePage.dart';
import './SearchDetailBookPage.dart';
import './SearchDetailLessonPage.dart';
import './SearchDetailCoursePage.dart';
import 'package:lychee/common/event/NeedRefreshEvent.dart';
import 'package:lychee/common/model/Category.dart';

class SearchDetailPage extends StatefulWidget {
  final String keyword;
  final Category category;
  final int leftIndex;
  final int rightSection;
  final int rightIndex;

  SearchDetailPage({this.keyword="",this.category,this.leftIndex=0,this.rightSection=-1,this.rightIndex=-1});

  @override
  _SearchDetailPagetState createState() => new _SearchDetailPagetState();
}

class _SearchDetailPagetState extends State<SearchDetailPage> with SingleTickerProviderStateMixin {
  String curCategoryName;
  int cid;
  String keyword;
  int categoryLeftIndex;
  int categoryRightSection;
  int categoryRightIndex;

  bool isCategorySelected = false;
  int stackIndex = 0;
  List tabTitles = ["综合","图书","小讲","短课"];
  int tabIndex = 0;
  TabController _tabController;

  _SearchDetailPagetState();

   @override
  void initState() {
    super.initState();

    if (widget.category == null) {
      curCategoryName = "分类";
      cid = -1;
    } else {
      curCategoryName = widget.category.name;
      cid = widget.category.id;
    }

    keyword = widget.keyword;
    categoryLeftIndex = widget.leftIndex;
    categoryRightSection = widget.rightSection;
    categoryRightIndex = widget.rightIndex;

    _tabController =  TabController(vsync: this, length: tabTitles.length);
    _tabController.addListener((){
      if (mounted) {
        setState(() {
          tabIndex = _tabController.index;
        });
      }
    });
  }

  _buildTopOptionWidget(title,onPressed) {
    return new Row( 
      children: <Widget>[
        InkWell(
          onTap: (){onPressed?.call();},
          child: SizedBox(
            width: 83.5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  constraints:BoxConstraints(
                    maxWidth: 70
                  ),
                  child: Text(title,style: TextStyle(color: Color(YYColors.primaryText),fontSize: YYSize.large),maxLines: 1,overflow: TextOverflow.ellipsis,softWrap: false),
                ),
                Image.asset(CommonUtils.Local_Icon_prefix+"drop_down.png",width: 10,height: 10,fit: BoxFit.fill)
              ],
            ),
          ),
        ),
        SizedBox(width: 21)
      ],
    );
  }

  _buildTabsWidget() {
    List<Widget> tabs = new List();
    for (int i=0;i<tabTitles.length;i++) {
      String title =tabTitles[i];
      tabs.add(Tab(child: Text(title,style:TextStyle(color: (tabIndex==i)?Color(YYColors.primary):Color(YYColors.secondaryText),fontSize: YYSize.large),overflow: TextOverflow.ellipsis,maxLines: 1)));
    }

    return tabs;
  }

  _searchPageOnPressed(value) {
    if (mounted) {
      setState(() {
        keyword = value.trim();
      });
    }

    SchedulerBinding.instance.addPostFrameCallback((_) {
      _childWidgetsNeedRefresh();
    });
  }

  _topCategoryOnPressed() {
    if (mounted) {
      setState(() {
        isCategorySelected = !isCategorySelected;
        if (isCategorySelected==true) {
          stackIndex = 1;
          curCategoryName = "不限";
        } else {
          stackIndex = 0;
          curCategoryName = "分类";
          cid = 0;
          categoryLeftIndex = 0;
          categoryRightSection = -1;
          categoryRightIndex = -1;
        }
      });
    }

     SchedulerBinding.instance.addPostFrameCallback((_) {
      _childWidgetsNeedRefresh();
    });
  }

  _categoryWidgetOnPressed(category) {
    if (mounted) {
      setState(() {
        isCategorySelected = false;
        curCategoryName = category.name;
        stackIndex = 0;
        cid =category.id;
      });
    }
    
     SchedulerBinding.instance.addPostFrameCallback((_) {
      _childWidgetsNeedRefresh();
    });
  }

  _childWidgetsNeedRefresh() {
    NeedRefreshEvent.refreshHandleFunction("SearchDetailCompositePage");
    NeedRefreshEvent.refreshHandleFunction("SearchDetailBookPage");
    NeedRefreshEvent.refreshHandleFunction("SearchDetailLessonPage");
    NeedRefreshEvent.refreshHandleFunction("SearchDetailCoursePage");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        leading: IconButton(
          icon: Image.asset(CommonUtils.Local_Icon_prefix+"back.png",width: 18,height: 18),
          onPressed: (){
            CommonUtils.closePage(context);
          },
        ),
        title: InkWell(
          onTap: (){CommonUtils.openPage(context, SearchPage(onPressed: _searchPageOnPressed));},
          child: Container(
            height: 31,
            color:Color(YYColors.gray_dark),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(width: 5.0),
                Image.asset(CommonUtils.Local_Icon_prefix+'search_gray.png',width: 13,height: 14,fit: BoxFit.fill),
                SizedBox(width: 5.0),
                Expanded(
                  child:Text(keyword??"",style: TextStyle(color: Color(YYColors.secondaryText),fontSize: YYSize.tip),overflow: TextOverflow.ellipsis,maxLines: 1)                   
                ),
                SizedBox(width: 5.0)
              ],
            ),
          )
        )
      ),
      body: SafeArea(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 42,
              color: Color(YYColors.gray),
              child: Padding(
                padding: EdgeInsets.only(left: 10.5,right: 10.5),
                child: Row(
                  children: <Widget>[
                    _buildTopOptionWidget(curCategoryName, _topCategoryOnPressed),
                    Expanded(
                      child: TabBar(
                        isScrollable: false,
                        controller: _tabController,
                        indicatorColor: Color(YYColors.primary),
                        indicatorSize: TabBarIndicatorSize.label,
                        tabs: _buildTabsWidget(),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: IndexedStack(
                children: <Widget>[
                  TabBarView(controller: _tabController, children: <Widget>[
                    SearchDetailCompositePage(cid,keyword),
                    SearchDetailBookPage(cid,keyword),
                    SearchDetailLessonPage(cid,keyword),
                    SearchDetailCoursePage(cid,keyword),
                  ]),
                  new CategoryWidget(leftIndex: categoryLeftIndex,rightSection:categoryRightSection,rightIndex: categoryRightIndex,onPressed: (category,_leftIndex,_rightSection,_rightIndex){
                    _categoryWidgetOnPressed(category);
                  })
                ],
                index: stackIndex,
              )
            
            ),
          ],
        ),
      ),
    );
  }
}
