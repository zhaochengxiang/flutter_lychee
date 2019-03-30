import 'package:flutter/material.dart';

import 'package:lychee/common/style/YYStyle.dart';
import 'package:lychee/common/util/YYCommonUtils.dart';
import 'package:lychee/common/model/YYBook.dart';

class YYBookItem extends StatelessWidget {
  final YYBook book;
  final double height;
  final VoidCallback onPressed;
  YYBookItem({@required this.book,this.height,this.onPressed});

  Widget _buildContent() {
    return Container(
      height: height,
      child: Padding(
        padding: EdgeInsets.all(10.5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            FlatButton(
              padding: EdgeInsets.zero,
              onPressed: () {
              
              },
              child: Container(
                width: 90,
                height: 125,
                child: FadeInImage.assetNetwork(
                  placeholder: YYCommonUtils.Local_Icon_prefix+'book_placeholder.png',
                  fit: BoxFit.fill,
                  image: YYCommonUtils.coverPath(book.cover,'s'),
                ),
              ),
            ),
            SizedBox(width:10.5),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(book.title,style:TextStyle(color: Color(YYColors.primaryText),fontSize: YYSize.large),overflow: TextOverflow.ellipsis,maxLines:2),
                  SizedBox(height: 6),
                  Expanded(
                    child: Text(book.author,style:TextStyle(color: Color(YYColors.secondaryText),fontSize: YYSize.medium),overflow: TextOverflow.ellipsis,maxLines:2),
                  ),
                  Text(book.press??""+book.date??"",style:TextStyle(color: Color(YYColors.secondaryText),fontSize: YYSize.medium),overflow: TextOverflow.ellipsis),
                  SizedBox(height: 6),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(child:Text("想读"+book.wantReadQuantity.toString(),style:TextStyle(color: Color(YYColors.thirdText),fontSize: YYSize.small),overflow: TextOverflow.ellipsis)),
                      Expanded(child:Text("读过"+book.haveReadQuantity.toString(),style:TextStyle(color: Color(YYColors.thirdText),fontSize: YYSize.small),overflow: TextOverflow.ellipsis)),
                      Expanded(child:Text("收藏"+book.collectionQuantity.toString(),style:TextStyle(color: Color(YYColors.thirdText),fontSize: YYSize.small),overflow: TextOverflow.ellipsis)),
                      Expanded(child:Text("笔记"+book.noteQuantity.toString(),style:TextStyle(color: Color(YYColors.thirdText),fontSize: YYSize.small),overflow: TextOverflow.ellipsis)),
                    ],
                  )
                ],
              ),
            )
          ],
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return (onPressed==null)?_buildContent():new FlatButton(
      padding: EdgeInsets.zero,
      onPressed: (){onPressed?.call();},
      child: _buildContent(),
    );
  }
}