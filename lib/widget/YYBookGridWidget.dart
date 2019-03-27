import 'package:flutter/material.dart';
import 'package:lychee/common/model/YYBook.dart';
import 'package:lychee/widget/YYIconTextWidget.dart';
import 'package:lychee/common/util/YYCommonUtils.dart';
import 'package:lychee/common/style/YYStyle.dart';

typedef BookItemCallback = void Function(YYBook book);

class YYBookGridWidget extends StatelessWidget {
  static const double bookImageWidth = 93.5; 
  static const double bookImageHeight = 130.0;
  static const double bookItemHeight = 181.0;
  final int column;
  final List<YYBook> books;
  final BookItemCallback onPressed;
  YYBookGridWidget(this.books,{this.column=3,this.onPressed});

  List<Widget> _buildGridTiles() {
    List<Widget> lists = new List();
    for (int i=0;i<books.length;i++) {
      YYBook book = books[i];
      Widget tile = new FlatButton( 
        padding: EdgeInsets.all(0),
        child: Container( 
          child: new YYIconTextWidget(
              iconNetUrl: YYCommonUtils.coverPath(book.cover,'s'),
              iconText: book.title,
              iconWidth: bookImageWidth,
              iconHeight: bookImageHeight,
              textStyle: TextStyle(color: Color(YYColors.primarySection),fontSize: YYSize.medium),
              type:2,
              padding: 2.5,
              maxLines: 2,
              mainAxisAlignment: MainAxisAlignment.center,
            )
        ),
        onPressed: () {onPressed?.call(book);},
      );

      lists.add(tile);
    }
    return lists;
  }

  @override
  Widget build(BuildContext context) {
    var contextWidth = (MediaQuery.of(context).size.width);
    var space = (contextWidth - bookImageWidth*column)/((column+1)*2);
    var bookItemWidth = (contextWidth-2*space)/column;
    var ratio = bookItemWidth/bookItemHeight;

    return (books==null||books.length==0)?new Container():new Padding(
      padding: EdgeInsets.only(left: space,right: space),
      child: GridView.count(
          primary: false,
          shrinkWrap: true,
          crossAxisSpacing: 0,
          crossAxisCount: column,
          mainAxisSpacing: 0,
          childAspectRatio: ratio,
          children: _buildGridTiles(),
          padding:EdgeInsets.all(0)
        ),
    );
  }
}