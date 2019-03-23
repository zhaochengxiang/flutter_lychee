import 'package:flutter/material.dart';
import 'package:lychee/common/model/YYBook.dart';
import 'package:lychee/widget/YYIconTextWidget.dart';
import 'package:lychee/common/util/YYCommonUtils.dart';
import 'package:lychee/common/style/YYStyle.dart';

typedef BookItemCallback = void Function(YYBook book);

class YYBookItemWidget extends StatelessWidget {
  static int defaultColumn = 3;
  final int column;
  final List<YYBook> books;
  final BookItemCallback onPressed;
  YYBookItemWidget(this.books,{this.column=3,this.onPressed});

  List<Widget> _itemChildren() {
    List<Widget> widgetList = new List();
    int i;
    for (i = 0;i< books.length;i++) {
      YYBook book = books[i];
      widgetList.add(
        new Expanded(
          flex: 1,
          child:new FlatButton(
            padding: EdgeInsets.all(0),
            onPressed: (){onPressed?.call(book);},
            child: new YYIconTextWidget(
              iconNetUrl: YYCommonUtils.coverPath(book.cover,'s'),
              iconText: book.title,
              iconWidth: 93.5,
              iconHeight: 130.0,
              textStyle: TextStyle(color: Color(YYColors.primarySection),fontSize: YYSize.medium),
              type:2,
              padding: 2.5,
              maxLines: 2,
              mainAxisAlignment: MainAxisAlignment.center,
            ),
      )));
    }

    if (i<column) {
      for (;i<=column;i++) {
        widgetList.add(Expanded(flex: 1,child: new Container()));
      }
    }

    return widgetList;
  }

  @override
  Widget build(BuildContext context) {
    return (books==null||books.length==0)?new Container():new Row(
      children: _itemChildren(),
    );
  }
}