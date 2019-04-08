import 'package:flutter/material.dart';

import 'package:lychee/common/util/CommonUtils.dart';
import 'package:lychee/common/model/Receipt.dart';
import 'package:lychee/widget/BookItem.dart';
import 'package:lychee/common/model/Book.dart';

class BookRadioItem extends StatelessWidget {
  final Receipt receipt;
  final double height;
  final bool isSelected;
  final VoidCallback onPressed;
  BookRadioItem({@required this.receipt,this.height=146.0,this.isSelected=false,this.onPressed});

  @override
  Widget build(BuildContext context) {
    return new FlatButton(
      padding: EdgeInsets.zero,
      onPressed: (){onPressed?.call();},
      child: Container(
        height: height,
        child: Padding(
          padding: EdgeInsets.only(left: 10.5,right: 10.5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Image.asset(CommonUtils.Local_Icon_prefix+((isSelected==true)?"checkbox.png":"checkbox_empty.png"),width: 17.5,height: 17.5,fit: BoxFit.fill),
              SizedBox(width: 10.5),
              Expanded(child: BookItem(book:Book(0, 0, "", "", receipt.title, receipt.author, receipt.date, receipt.cover, "", "", receipt.press, receipt.wantReadQuantity, receipt.haveReadQuantity, receipt.collectionQuantity, receipt.noteQuantity, "", false),height: height))
            ],
          ),
        ),
      ),
    );
  }
}