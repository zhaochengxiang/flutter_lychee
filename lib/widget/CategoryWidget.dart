import 'package:flutter/material.dart';

import 'package:lychee/widget/base/BaseState.dart';
import 'package:lychee/widget/base/BaseWidget.dart';
import 'package:lychee/common/model/Category.dart';
import 'package:lychee/widget/CategoryLeftItem.dart';
import 'package:lychee/widget/CategoryRightItem.dart';

typedef CategoryItemCallback = void Function(Category category);

class CategoryWidget extends StatefulWidget {
  final String remotePath;
  final CategoryItemCallback onPressed;
  CategoryWidget({this.remotePath="/category/findAll",this.onPressed});

  @override
  _CategoryWidgetPageState createState() => _CategoryWidgetPageState();
}

class _CategoryWidgetPageState extends State<CategoryWidget>  with AutomaticKeepAliveClientMixin<CategoryWidget>,BaseState<CategoryWidget> {

  int leftIndex = 0;
  List<Category> rightCategories;
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
    return Category.fromJson(json);
  }

  @protected
  Widget _buildLeftListView() {
    if (control.data == null||control.data.length==0) return new Container();

    rightCategories = control.data[leftIndex].children;

    return new ListView.builder(
      physics: ClampingScrollPhysics(),
      itemBuilder: (context, index) {
        return CategoryLeftItem(category: control.data[index],highlight: (index==leftIndex),onPress: (){
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

    return new ListView.builder(
      physics: ClampingScrollPhysics(),
      itemBuilder: (context, index) {
        return CategoryRightItem(
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

              Category section = rightCategories[index];
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

    return BaseWidget(
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