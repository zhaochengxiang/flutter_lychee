import 'package:flutter/material.dart';
import 'package:lychee/common/model/Book.dart';
import 'package:lychee/widget/IconText.dart';
import 'package:lychee/common/util/CommonUtils.dart';
import 'package:lychee/common/style/Style.dart';

typedef BookItemCallback = void Function(Book book);

class BookGrid extends StatelessWidget {
  static const double bookImageWidth = 93.5; 
  static const double bookImageHeight = 130.0;
  static const double bookItemHeight = 181.0;
  final int column;
  final List<Book> books;
  final BookItemCallback onPressed;
  BookGrid(this.books,{this.column=3,this.onPressed});

  List<Widget> _buildGridTiles() {
    List<Widget> lists = new List();
    for (int i=0;i<books.length;i++) {
      Book book = books[i];
      Widget tile = new InkWell( 
        child: Container( 
          child: new IconText(
              direction: IconTextDirection.column,
              iconNetUrl: CommonUtils.coverPath(book.cover,'s'),
              iconWidth: bookImageWidth,
              iconHeight: bookImageHeight,
              iconShapeBorder: Border.all(color:Color(YYColors.border),width: 0.3),
              text: book.title,
              textStyle: TextStyle(color: Color(YYColors.primarySection),fontSize: YYSize.medium),
              padding: 2.5,
              maxLines: 2,
              mainAxisAlignment: MainAxisAlignment.center,
            )
        ),
        onTap: () {onPressed?.call(book);},
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