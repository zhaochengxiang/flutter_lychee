import 'package:flutter/material.dart';

import 'package:lychee/widget/base/BaseListState.dart';
import 'package:lychee/widget/base/BaseState.dart';
import 'package:lychee/widget/base/BaseBookListState.dart';
import 'package:lychee/widget/base/BaseBookListWidget.dart';
import 'package:lychee/common/util/CommonUtils.dart';
import 'package:lychee/common/event/NeedRefreshEvent.dart';
import 'package:lychee/common/style/Style.dart';
import './SearchPage.dart';
import 'package:lychee/common/model/CourseResult.dart';
import 'package:lychee/common/model/Course.dart';
import 'package:lychee/widget/CourseItem.dart';
import './CourseDetailPage.dart';
import 'package:lychee/common/model/Search.dart';

class SearchCoursePage extends StatefulWidget {
  final String keyword;
  SearchCoursePage({this.keyword});

  @override
  _SearchCoursePageState createState() => _SearchCoursePageState();
}

class _SearchCoursePageState extends State<SearchCoursePage> with AutomaticKeepAliveClientMixin<SearchCoursePage>,BaseState<SearchCoursePage>, BaseListState<SearchCoursePage>,BaseBookListState<SearchCoursePage> {

  @override
  bool get needFrame => false;

  @override
  bool get needLibrary => false;

  @override
  bool get needCount => false;

  @override
  String get searchKeyword => widget.keyword;
  
  @override
  remotePath() {
    return "/course/search";
  }

  @override
  jsonConvertToModel(Map<String,dynamic> json) {
    return CourseResult.fromJson(json);
  }

  @override
  handleRefreshData(data) {
    control.data = new List();
    CourseResult courseResult = jsonConvertToModel(data);
    control.last = courseResult.last;
    control.offset = courseResult.offset;
    control.hasNext = courseResult.hasNext;
    if (courseResult.list!=null&&courseResult.list.length>0) {
      control.data.addAll(courseResult.list);
    }
  }

  @override
  handleMoreData(data) {
    CourseResult courseResult = jsonConvertToModel(data);
    control.last = courseResult.last;
    control.offset = courseResult.offset;
    control.hasNext = courseResult.hasNext;
    if (courseResult.list!=null&&courseResult.list.length>0) {
      control.data.addAll(courseResult.list);
    }
  }

  _searchPageOnPressed(value) {
    setState(() {
      control.keyword = value;
    });
    NeedRefreshEvent.refreshHandleFunction("SearchCoursePage");
  }

  @override
  renderListItem(index) {
    Course course = control.data[index];
    return new CourseItem(course,onPressed: (){
      CommonUtils.openPage(context, CourseDetailPage({"uuid":course.uuid}));
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        leading: IconButton(
          icon: new Image.asset(CommonUtils.Local_Icon_prefix+"back.png",width: 18.0,height: 18.0),
          onPressed: () {
            CommonUtils.closePage(context);
          }),
        title:FlatButton(
          padding: EdgeInsets.zero,
          onPressed: (){CommonUtils.openPage(context, SearchPage(type: Search.SEARCH_COURSE, onPressed: _searchPageOnPressed));},
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
                  child:Text(control.keyword,style: TextStyle(color: Color(YYColors.secondaryText),fontSize: YYSize.tip),overflow: TextOverflow.ellipsis,maxLines: 1)                   
                ),
                SizedBox(width: 5.0)
              ],
            ),
          )
        ),
      ),
      body: BaseBookListWidget(
        control:control,
        onRefresh: handleRefresh,
        onLoadMore: onLoadMore,
        refreshKey: refreshIndicatorKey,
        widgetName: widget.runtimeType.toString(),
        emptyTip: "没有搜索到相关短课",
        itemBuilder: (BuildContext context, int index) => renderListItem(index),
      )
    );
  }
}