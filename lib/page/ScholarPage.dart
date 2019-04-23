import 'package:flutter/material.dart';
import 'package:lychee/common/util/CommonUtils.dart';
import 'package:lychee/common/style/Style.dart';
import 'package:lychee/widget/base/BaseState.dart';
import 'package:lychee/widget/base/BaseWidget.dart';
import 'package:lychee/common/model/Scholar.dart';
import './ScholarHomePage.dart';
import './ScholarBookPage.dart';
import './ScholarLessonPage.dart';
import './ScholarCoursePage.dart';
import './SearchPage.dart';
import './SearchScholarPage.dart';
import 'package:lychee/common/model/Search.dart';

class ScholarPage extends StatefulWidget {

  final int id;
  ScholarPage(this.id);

  @override
  _ScholarPageState createState() => _ScholarPageState();
}

class _ScholarPageState extends State<ScholarPage> with AutomaticKeepAliveClientMixin<ScholarPage>,BaseState<ScholarPage>,SingleTickerProviderStateMixin {
  static const double topHeight = 187.5;
  static const double topBgHeight = 114.5;

  Scholar scholar;
  List tabTitles = ["主页","图书","小讲","短课"];
  int tabIndex = 0;
  TabController _tabController;

  @override
  remotePath() {
    return "/scholar/get";
  }

  @override
  generateRemoteParams() {
    return {"id":widget.id};
  }

  @override
  jsonConvertToModel(Map<String,dynamic> json) {
     return Scholar.fromJson(json);
  }

  @override
  void initState() {
    super.initState();

    _tabController =  TabController(vsync: this, length: tabTitles.length);
    _tabController.addListener((){
      setState(() {
        tabIndex = _tabController.index;
      });
    });
  }

  List<Widget> _buildTabsWidget() {
    List<Widget> tabs = new List();
    for (int i=0;i<tabTitles.length;i++) {
      String title =tabTitles[i];
      tabs.add(Tab(child: Text(title,style:TextStyle(color: (tabIndex==i)?Color(YYColors.primary):Color(YYColors.secondaryText),fontSize: YYSize.large),overflow: TextOverflow.ellipsis,maxLines: 1)));
    }

    return tabs;
  }

  Widget _buildTop() {
    if (scholar ==null) return new Container();

    return Container(
      height: topHeight,
      child:Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: topBgHeight,
            child: new Image.asset(CommonUtils.Local_Icon_prefix+'mine_top_bg.png',fit:BoxFit.fill)
          ),
          Positioned(
            width: MediaQuery.of(context).size.width,
            top: CommonUtils.sStaticBarHeight,
            child: new Container(
              height: 44,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  InkWell(
                    onTap: () {CommonUtils.closePage(context);},
                    child: Container(
                      width: 44,
                      height: 44,
                      child: Center(
                        child: Image.asset(CommonUtils.Local_Icon_prefix+"arrow_left_white.png",width: 19,height: 19,fit: BoxFit.fill),
                      ),
                    ),
                  ),
                  Expanded(
                    child: new Container(),
                  ),
                  InkWell(
                    onTap: () {
                      CommonUtils.openPage(context, SearchPage(type: Search.SEARCH_SCHOLAR,onPressed:(keyword) {
                        CommonUtils.openPage(context, SearchScholarPage(id:widget.id,keyword: keyword));
                      }));
                    },
                    child: Container(
                      width: 44,
                      height: 44,
                      child: Center(
                        child: Image.asset(CommonUtils.Local_Icon_prefix+"search_white.png",width: 19,height: 19,fit: BoxFit.fill),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            width: MediaQuery.of(context).size.width,
            bottom: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ClipOval(
                  child:Container(
                    width: 77,
                    height: 77,
                    color: Colors.white,
                    child: Center( 
                      child: ClipOval(
                        child: new FadeInImage.assetNetwork(
                          placeholder: CommonUtils.Local_Icon_prefix+'user_placeholder.png',
                          fit: BoxFit.fill,
                          image: CommonUtils.avatarPath(scholar.avatar),
                          width: 73.0,
                          height: 73.0,
                        ),
                      )
                    ),
                  )
                ),
                Padding(padding: EdgeInsets.all(5.0)),
                Text(scholar.name,style: TextStyle(color: Color(YYColors.primaryText),fontSize: YYSize.large), overflow: TextOverflow.ellipsis),
                Padding(padding: EdgeInsets.all(2.5)),
                Text(scholar.honor,style: TextStyle(color: Color(YYColors.secondaryText),fontSize: YYSize.medium), overflow: TextOverflow.ellipsis)
              ],
            ),
          )
        ],
      )
    );
  }

  @override 
  Widget build(BuildContext context) {
    scholar = control.data;

    return new Scaffold(
      body: SafeArea( 
        top: false,
        child: BaseWidget(
          control:control,
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildTop(),
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
                  child: (scholar==null)?new Container():new TabBarView(controller: _tabController, children: <Widget>[
                      ScholarHomePage(id: widget.id),
                      ScholarBookPage(id: widget.id),
                      ScholarLessonPage(id: widget.id),
                      ScholarCoursePage(id: widget.id),
                    ]
                  )
              )
            ]
          ),
        )
      ),
    );
  } 
}
