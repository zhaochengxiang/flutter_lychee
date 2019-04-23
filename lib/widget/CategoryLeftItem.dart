import 'package:flutter/material.dart';
import 'package:lychee/common/model/Category.dart';
import 'package:lychee/common/style/Style.dart';

class CategoryLeftItem extends StatefulWidget {
  final Category category;
  final bool highlight;
  final VoidCallback onPress;

  CategoryLeftItem({this.category,this.highlight,this.onPress});

  @override
  _CategoryLeftItemState createState() => _CategoryLeftItemState();
}

class _CategoryLeftItemState extends State<CategoryLeftItem> {
  @override
  Widget build(BuildContext context) {

    return  InkWell(
      onTap:() {widget.onPress?.call();},
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 44,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 3,
              height: 36.5,
              color: widget.highlight?Color(YYColors.primary):Colors.transparent
            ),
            Expanded(
              child:Center(
                child: Text(widget.category.name,style: TextStyle(color: widget.highlight?Color(YYColors.primary):Color(YYColors.primaryText),fontSize: YYSize.large), overflow: TextOverflow.ellipsis)
              )
            )
          ],
        ),
      )
    );
  }
}