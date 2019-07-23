import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:lychee/common/util/CommonUtils.dart';
import 'package:lychee/common/style/Style.dart';
import './SearchPage.dart';
import 'package:lychee/common/event/NeedRefreshEvent.dart';
import 'package:lychee/common/model/Search.dart';
import './SearchScholarCompositePage.dart';
import './ScholarBookPage.dart';
import './ScholarCoursePage.dart';
import './ScholarLessonPage.dart';

class SearchScholarPage extends StatefulWidget {
  final int id;
  final String keyword;
  SearchScholarPage({this.id,this.keyword=""});

  @override
  _SearchScholarPagetState createState() => new _SearchScholarPagetState();
}

class _SearchScholarPagetState extends State<SearchScholarPage> with SingleTickerProviderStateMixin {

  List tabTitles = ["综合","图书","小讲","短课"];
  int tabIndex = 0;
  TabController _tabController;
  String keyword;

   @override
  void initState() {
    super.initState();
    keyword = widget.keyword;

    _tabController =  TabController(vsync: this, length: tabTitles.length);
    _tabController.addListener((){
      if (mounted) {
        setState(() {
          tabIndex = _tabController.index;
        });
      }
    });
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

  _childWidgetsNeedRefresh() {
    NeedRefreshEvent.refreshHandleFunction("SearchScholarCompositePage");
    NeedRefreshEvent.refreshHandleFunction("ScholarBookPage");
    NeedRefreshEvent.refreshHandleFunction("ScholarCoursePage");
    NeedRefreshEvent.refreshHandleFunction("ScholarLessonPage");
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
          onTap: (){CommonUtils.openPage(context, SearchPage(type: Search.SEARCH_SCHOLAR,onPressed: _searchPageOnPressed));},
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
              child: TabBar(
                isScrollable: false,
                controller: _tabController,
                indicatorColor: Color(YYColors.primary),
                indicatorSize: TabBarIndicatorSize.label,
                tabs: _buildTabsWidget(),
              ),
            ),
            Expanded(
              child: TabBarView(controller: _tabController, children: <Widget>[
                SearchScholarCompositePage(id: widget.id,keyword:keyword??""),
                ScholarBookPage(id: widget.id,keyword:keyword??""),
                ScholarLessonPage(id: widget.id,keyword:keyword??""),
                ScholarCoursePage(id: widget.id,keyword:keyword??""),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

