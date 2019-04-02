import 'package:flutter/material.dart';
import 'package:lychee/common/util/YYCommonUtils.dart';

import 'package:lychee/widget/YYCategoryWidget.dart';

class YYCategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title:Text("分类"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
          icon: new Image.asset(YYCommonUtils.Local_Icon_prefix+"search.png",width: 24.0,height: 24.0),
          onPressed: () {

          })
        ],
        iconTheme: new IconThemeData(color: Colors.black),
      ),
      body: YYCategoryWidget(onPressed: (category) {

      }),
    );
  }
}