import 'package:flutter/material.dart';
import 'package:lychee/common/util/CommonUtils.dart';

import 'package:lychee/widget/CategoryWidget.dart';
import './SearchPage.dart';
import './SearchDetailPage.dart';

class CategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title:Text("分类"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
          icon: new Image.asset(CommonUtils.Local_Icon_prefix+"search.png",width: 18.0,height: 18.0),
          onPressed: () {
            CommonUtils.openPage(context, SearchPage(onPressed:(keyword) {
              CommonUtils.openPage(context, SearchDetailPage(keyword: keyword));
            }));
          })
        ],
        iconTheme: new IconThemeData(color: Colors.black),
      ),
      body: CategoryWidget(onPressed: (category,leftIndex,rightSection,rightIndex) {
        CommonUtils.openPage(context, SearchDetailPage(category: category,leftIndex: leftIndex,rightSection: rightSection,rightIndex: rightIndex));
      }),
    );
  }
}