import 'package:flutter/material.dart';

import 'package:lychee/widget/base/BaseState.dart';
import 'package:lychee/widget/base/BaseWidget.dart';
import 'package:lychee/common/model/Category.dart';
import 'package:lychee/widget/CategoryLeftItem.dart';
import 'package:lychee/widget/CategoryRightItem.dart';
import 'package:lychee/common/util/CommonUtils.dart';
import 'package:lychee/common/event/CategoryIndexChangeEvent.dart';
import 'package:lychee/page/SearchDetailPage.dart';

typedef CategoryItemCallback = void Function(Category category,int leftIndex,int rightSection,int rightIndex);

class CategoryWidget extends StatefulWidget {
  final String remotePath;
  final CategoryItemCallback onPressed;
  final int leftIndex;
  final int rightSection;
  final int rightIndex;

  CategoryWidget({this.remotePath="/category/findAll",this.leftIndex=0,this.rightSection=-1,this.rightIndex=-1,this.onPressed});

  @override
  _CategoryWidgetPageState createState() => _CategoryWidgetPageState(leftIndex:this.leftIndex,rightSection:this.rightSection,rightIndex:this.rightIndex);
}

class _CategoryWidgetPageState extends State<CategoryWidget>  with AutomaticKeepAliveClientMixin<CategoryWidget>,BaseState<CategoryWidget> {

  int leftIndex;
  List<Category> rightCategories;
  int rightSection;
  int rightIndex;

  _CategoryWidgetPageState({this.leftIndex,this.rightSection,this.rightIndex});

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

    return ScrollConfiguration(
      behavior: ScrollBehavior(),
      child: new ListView.builder(
        itemBuilder: (context, index) {
          return CategoryLeftItem(category: control.data[index],highlight: (index==leftIndex),onPress: (){
            setState(() {
              if (leftIndex == index) {
                widget.onPressed?.call(control.data[index],leftIndex,rightSection,rightIndex);
              } else {
                leftIndex = index;
                rightSection = -1;
                rightIndex = -1;
              }
            });
          });
        },
        itemCount: control.data.length,
      )
    );
  }

  @protected
  Widget _buildRightListView() {
    if (control.data==null || control.data.length==0) return new Container();

    return ScrollConfiguration(
      behavior: ScrollBehavior(),
      child: new ListView.builder(
        itemBuilder: (context, index) {
          return CategoryRightItem(
            category: rightCategories[index],
            isSectionHighlight: (index==rightSection&&rightIndex==-1),
            itemHighlightIndex: (index==rightSection)?rightIndex:-1,
            onSectionPress: () {
              setState(() {
                rightSection = index;
                rightIndex = -1;
                widget.onPressed?.call(rightCategories[index],leftIndex,rightSection,rightIndex);
              });
            },
            onItemPress: (_index) {
              setState(() {
                rightSection = index;
                rightIndex = _index;

                Category section = rightCategories[index];
                widget.onPressed?.call(section.children[_index],leftIndex,rightSection,rightIndex);
              });
            },
          );
        },
        itemCount: rightCategories.length,
      )
    );
  }

  @override
  void initState() {
    super.initState();
    refreshEventStream =  CommonUtils.eventBus.on<CategoryIndexChangeEvent>().listen((event) {
      setState(() {
        leftIndex = SearchDetailModel.of(context).currentCategoryLeftIndex;
        rightSection =SearchDetailModel.of(context).currentCategoryRightSection;
        rightIndex =SearchDetailModel.of(context).currentCategoryRightIndex;
      });
    });
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