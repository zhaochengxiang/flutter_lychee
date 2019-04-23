import 'package:flutter/material.dart';

import 'package:lychee/widget/base/BaseListState.dart';
import 'package:lychee/widget/base/BaseState.dart';
import 'package:lychee/widget/base/BaseBookListState.dart';
import 'package:lychee/widget/base/BaseBookListWidget.dart';
import 'package:lychee/common/util/CommonUtils.dart';
import 'package:lychee/common/event/NeedRefreshEvent.dart';
import 'package:lychee/common/style/Style.dart';
import './SearchPage.dart';
import 'package:lychee/common/model/LessonResult.dart';
import 'package:lychee/common/model/Lesson.dart';
import 'package:lychee/widget/LessonItem.dart';
import './LessonDetailPage.dart';
import 'package:lychee/common/model/Search.dart';

class SearchLessonPage extends StatefulWidget {
  final String keyword;
  SearchLessonPage({this.keyword});

  @override
  _SearchLessonPageState createState() => _SearchLessonPageState();
}

class _SearchLessonPageState extends State<SearchLessonPage> with AutomaticKeepAliveClientMixin<SearchLessonPage>,BaseState<SearchLessonPage>, BaseListState<SearchLessonPage>,BaseBookListState<SearchLessonPage> {

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
    return "/lesson/search";
  }

  @override
  jsonConvertToModel(Map<String,dynamic> json) {
    return LessonResult.fromJson(json);
  }

  @override
  handleRefreshData(data) {
    control.data = new List();
    LessonResult lessonResult = jsonConvertToModel(data);
    control.last = lessonResult.last;
    control.offset = lessonResult.offset;
    control.hasNext = lessonResult.hasNext;
    if (lessonResult.list!=null&&lessonResult.list.length>0) {
      control.data.addAll(lessonResult.list);
    }
  }

  @override
  handleMoreData(data) {
    LessonResult lessonResult = jsonConvertToModel(data);
    control.last = lessonResult.last;
    control.offset = lessonResult.offset;
    control.hasNext = lessonResult.hasNext;
    if (lessonResult.list!=null&&lessonResult.list.length>0) {
      control.data.addAll(lessonResult.list);
    }
  }

  _searchPageOnPressed(value) {
    setState(() {
      control.keyword = value;
    });
    NeedRefreshEvent.refreshHandleFunction("SearchLessonPage");
  }

  @override
  renderListItem(index) {
    Lesson lesson = control.data[index];
    return new LessonItem(lesson,onPressed: (){
      CommonUtils.openPage(context, LessonDetailPage({"uuid":lesson.uuid}));
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
        title:InkWell(
          onTap: (){CommonUtils.openPage(context, SearchPage(type: Search.SEARCH_LESSON, onPressed: _searchPageOnPressed));},
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
        emptyTip: "没有搜索到相关小讲",
        itemBuilder: (BuildContext context, int index) => renderListItem(index),
      )
    );
  }
}