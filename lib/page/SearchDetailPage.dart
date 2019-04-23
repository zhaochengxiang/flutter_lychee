import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

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
import 'package:lychee/common/event/CategoryIndexChangeEvent.dart';

class SearchDetailPage extends StatefulWidget {
  final String keyword;
  final Category category;
  final int leftIndex;
  final int rightSection;
  final int rightIndex;

  SearchDetailPage({this.keyword="",this.category,this.leftIndex=0,this.rightSection=-1,this.rightIndex=-1});

  @override
  _SearchDetailPagetState createState() => new _SearchDetailPagetState(curCategoryName: (this.category==null)?"分类":this.category.name,cid:(this.category==null)?-1:this.category.id);
}

class _SearchDetailPagetState extends State<SearchDetailPage> with SingleTickerProviderStateMixin {
  String curCategoryName;
  int cid;
  bool isCategorySelected = false;
  int stackIndex = 0;
  List tabTitles = ["综合","图书","小讲","短课"];
  int tabIndex = 0;
  TabController _tabController;
  final SearchDetailModel searchDetailModel = new SearchDetailModel();

  _SearchDetailPagetState({this.curCategoryName,this.cid});

   @override
  void initState() {
    super.initState();
    searchDetailModel.setCurrentCid(cid);
    searchDetailModel.setCurrentKeyword(widget.keyword);
    searchDetailModel.setCategoryIndex(widget.leftIndex, widget.rightSection, widget.rightIndex);

    _tabController =  TabController(vsync: this, length: tabTitles.length);
    _tabController.addListener((){
      setState(() {
        tabIndex = _tabController.index;
      });
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
    setState(() {
      searchDetailModel.setCurrentKeyword(value);
    });

    _childWidgetsNeedRefresh();
  }

  _topCategoryOnPressed() {
    setState(() {
      isCategorySelected = !isCategorySelected;
      if (isCategorySelected==true) {
        stackIndex = 1;
        curCategoryName = "不限";
      } else {
        stackIndex = 0;
        curCategoryName = "分类";
        searchDetailModel.setCurrentCid(0);
        _childWidgetsNeedRefresh();
        searchDetailModel.setCategoryIndex(0, -1, -1);
        CategoryIndexChangeEvent.changeHandleFunction();
      }
    });
  }

  _categoryWidgetOnPressed(category) {
    setState(() {
      isCategorySelected = false;
      curCategoryName = category.name;
      stackIndex = 0;
      searchDetailModel.setCurrentCid(category.id);
    });
    
    _childWidgetsNeedRefresh();
  }

  _childWidgetsNeedRefresh() {
    NeedRefreshEvent.refreshHandleFunction("SearchDetailCompositePage");
    NeedRefreshEvent.refreshHandleFunction("SearchDetailBookPage");
    NeedRefreshEvent.refreshHandleFunction("SearchDetailLessonPage");
    NeedRefreshEvent.refreshHandleFunction("SearchDetailCoursePage");
  }

  @override
  Widget build(BuildContext context) {
    return new ScopedModel<SearchDetailModel>(
      model: searchDetailModel,
      child: new ScopedModelDescendant<SearchDetailModel>(
        builder: (context, child, model) { 
          return new Scaffold(
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
                  color:Color(YYColors.gray_light),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      SizedBox(width: 5.0),
                      Image.asset(CommonUtils.Local_Icon_prefix+'search_gray.png',width: 13,height: 14,fit: BoxFit.fill),
                      SizedBox(width: 5.0),
                      Expanded(
                        child:Text(model.currentKeyword,style: TextStyle(color: Color(YYColors.secondaryText),fontSize: YYSize.tip),overflow: TextOverflow.ellipsis,maxLines: 1)                   
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
                          SearchDetailCompositePage(),
                          SearchDetailBookPage(),
                          SearchDetailLessonPage(),
                          SearchDetailCoursePage(),
                        ]),
                        new CategoryWidget(leftIndex: model.currentCategoryLeftIndex,rightSection:model.currentCategoryRightSection,rightIndex: model.currentCategoryRightIndex,onPressed: (category,_leftIndex,_rightSection,_rightIndex){
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
        })
    );
  }
}

class SearchDetailModel extends Model {
  int _cid;
  String _keyword;
  int _categoryLeftIndex;
  int _categoryRightSection;
  int _categoryRightIndex;

  String get currentKeyword => _keyword;
  int get currentCid => _cid;
  int get currentCategoryLeftIndex => _categoryLeftIndex;
  int get currentCategoryRightSection => _categoryRightSection;
  int get currentCategoryRightIndex => _categoryRightIndex;

  static SearchDetailModel of(BuildContext context) => ScopedModel.of<SearchDetailModel>(context,rebuildOnChange: true);

  void setCurrentKeyword(String keyword) {
    _keyword = keyword;
    notifyListeners();
  }

  void setCurrentCid(int cid) {
    _cid = cid;
    notifyListeners();
  }

  void setCategoryIndex(int leftIndex,int rightSection,int rightIndex) {
    _categoryLeftIndex =leftIndex;
    _categoryRightSection =rightSection;
    _categoryRightIndex =rightIndex;
  }
}

