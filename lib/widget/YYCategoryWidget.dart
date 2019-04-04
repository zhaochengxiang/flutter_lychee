import 'package:flutter/material.dart';

import 'package:lychee/widget/base/YYBaseState.dart';
import 'package:lychee/widget/base/YYBaseWidget.dart';
import 'package:lychee/common/model/YYCategory.dart';
import 'package:lychee/widget/YYCategoryLeftItem.dart';
import 'package:lychee/widget/YYCategoryRightItem.dart';

typedef CategoryItemCallback = void Function(YYCategory category);

class YYCategoryWidget extends StatefulWidget {
  final String remotePath;
  final CategoryItemCallback onPressed;
  YYCategoryWidget({this.remotePath="/category/findAll",this.onPressed});

  @override
  _YYCategoryWidgetPageState createState() => _YYCategoryWidgetPageState();
}

class _YYCategoryWidgetPageState extends State<YYCategoryWidget>  with AutomaticKeepAliveClientMixin<YYCategoryWidget>,YYBaseState<YYCategoryWidget> {

  int leftIndex = 0;
  List<YYCategory> rightCategories;
  int rightSectionIndex = -1;
  int rightItemIndex = -1;

  @override
  remotePath() {
    return widget.remotePath;
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
    if (control.data == null||control.data.length==0) return new Container();

    return new ListView.builder(
      physics: ClampingScrollPhysics(),
      itemBuilder: (context, index) {
        return YYCategoryLeftItem(category: control.data[index],highlight: (index==leftIndex),onPress: (){
          setState(() {
            if (leftIndex == index) {
              widget.onPressed?.call(control.data[index]);
            } else {
              leftIndex = index;
              rightSectionIndex = -1;
              rightItemIndex = -1;
            }
          });
        });
      },
      itemCount: control.data.length,
    );
  }

  @protected
  Widget _buildRightListView() {
    if (control.data==null || control.data.length==0) return new Container();

    rightCategories = control.data[leftIndex].children;

    return new ListView.builder(
      physics: ClampingScrollPhysics(),
      itemBuilder: (context, index) {
        return YYCategoryRightItem(
          category: rightCategories[index],
          isSectionHighlight: (index==rightSectionIndex&&rightItemIndex==-1),
          itemHighlightIndex: (index==rightSectionIndex)?rightItemIndex:-1,
          onSectionPress: () {
            setState(() {
              rightSectionIndex = index;
              rightItemIndex = -1;
              widget.onPressed?.call(rightCategories[index]);
            });
          },
          onItemPress: (_index) {
            setState(() {
              rightSectionIndex = index;
              rightItemIndex = _index;

              YYCategory section = rightCategories[index];
              widget.onPressed?.call(section.children[_index]);
            });
          },
        );
      },
      itemCount: rightCategories.length,
    );
  }

  @override
  Widget build(BuildContext context) {

    return YYBaseWidget(
        control: control,
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
      );
  }
}