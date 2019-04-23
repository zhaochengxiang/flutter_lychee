import 'package:flutter/material.dart';

import 'package:lychee/common/style/Style.dart';
import 'package:lychee/common/util/CommonUtils.dart';
import 'package:lychee/common/model/ReceiptResult.dart';

class BookHeaderItem extends StatelessWidget {
  final ReceiptResult receiptResult;
  final double height;
  final bool isSelected;
  final VoidCallback onPressed;
  BookHeaderItem({@required this.receiptResult,this.height=40.5,this.isSelected=false,this.onPressed});

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: (){onPressed?.call();},
      child: Container(
        height: height,
        color: Color(YYColors.gray),
        child: Padding(
          padding: EdgeInsets.only(left: 10.5,right: 10.5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Image.asset(CommonUtils.Local_Icon_prefix+((isSelected==true)?"checkbox.png":"checkbox_empty.png"),width: 17.5,height: 17.5,fit: BoxFit.fill),
              SizedBox(width: 10.5),
              Text(receiptResult.name,style: TextStyle(color: Color(YYColors.primaryText),fontSize: YYSize.large),overflow: TextOverflow.ellipsis)
            ],
          ),
        ),
      ),
    );
  }
}