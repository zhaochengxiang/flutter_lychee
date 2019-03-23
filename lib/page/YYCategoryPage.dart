import 'package:flutter/material.dart';
import 'package:lychee/common/util/YYCommonUtils.dart';

import 'package:lychee/widget/base/YYBaseState.dart';
import 'package:lychee/widget/base/YYBaseWidget.dart';
import 'package:lychee/common/model/YYCategory.dart';
import 'package:lychee/widget/YYCategoryLeftItemWidget.dart';
import 'package:lychee/widget/YYCategoryRightItemWidget.dart';

class YYCategoryPage extends StatefulWidget {
  @override
  State<YYCategoryPage> createState() {
    return _YYCategoryPagePageState();
  }
}

class _YYCategoryPagePageState extends State<YYCategoryPage>  with AutomaticKeepAliveClientMixin<YYCategoryPage>,YYBaseState<YYCategoryPage> {

  int leftIndex = 0;
  List<YYCategory> rightCategories;
  int rightSectionIndex = -1;
  int rightItemIndex = -1;

  @override
  remotePath() {
    return "/category/findAll";
  }

  @override
  generateRemoteParams() {
    return {};
  }

  @override
  jsonConvertToModel(Map<String,dynamic> json) {
    return YYCategory.fromJson(json);
  }

  @protected
  Widget _buildLeftListView() {
    if (baseWidgetControl.data == null) return new Container();

    return new ListView.builder(
      physics: ClampingScrollPhysics(),
      itemBuilder: (context, index) {
        return YYCategoryLeftItemWidget(category: baseWidgetControl.data[index],highlight: (index==leftIndex),onPress: (){
          setState(() {
            leftIndex = index;
            rightSectionIndex = -1;
            rightItemIndex = -1;
          });
        });
      },
      itemCount: baseWidgetControl.data.length,
    );
  }

  @protected
  Widget _buildRightListView() {
    if (baseWidgetControl.data == null) return new Container();

    rightCategories =baseWidgetControl.data[leftIndex].children;

    return new ListView.builder(
      physics: ClampingScrollPhysics(),
      itemBuilder: (context, index) {
        return YYCategoryRightItemWidget(
          category: rightCategories[index],
          isSectionHighlight: (index==rightSectionIndex&&rightItemIndex==-1),
          itemHighlightIndex: (index==rightSectionIndex)?rightItemIndex:-1,
          onSectionPress: () {
            setState(() {
              rightSectionIndex = index;
              rightItemIndex = -1;
            });
          },
          onItemPress: (_index) {
            setState(() {
              rightSectionIndex = index;
              rightItemIndex = _index;
            });
          },
        );
      },
      itemCount: rightCategories.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title:Text("分类"),
        actions: <Widget>[
          IconButton(
          icon: new Image.asset(YYCommonUtils.Local_Icon_prefix+"search.png",width: 24.0,height: 24.0),
          onPressed: () {

          })
        ],
        iconTheme: new IconThemeData(color: Colors.black),
      ),
      body: YYBaseWidget(
        control: baseWidgetControl,
        onRefresh: handleRefresh,
        child: Row(
          children: <Widget>[
            Container(
              width: 81.0,
              height: MediaQuery.of(context).size.height,
              child: _buildLeftListView(),
            ),
            Expanded(
              child: _buildRightListView(),
            ),
          ],
        ),
      ),
    );
  }
}