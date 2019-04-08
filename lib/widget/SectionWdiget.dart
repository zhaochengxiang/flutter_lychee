import 'package:flutter/material.dart';

import 'package:lychee/common/style/Style.dart';
import 'package:lychee/common/util/CommonUtils.dart';

class SectionWidget extends StatelessWidget {
  final String title;
  final TextStyle titleTextStyle;
  final String subtitle;
  final TextStyle subtitleTextStyle;
  final double height;
  final VoidCallback onPressed;
  SectionWidget({@required this.title,this.titleTextStyle,this.subtitle,this.subtitleTextStyle,this.height = 40.5,this.onPressed});

  Widget _buildContent() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Text(title,style: titleTextStyle??TextStyle(color: Color(YYColors.primarySection),fontSize: YYSize.large)),
        ),
        (subtitle==null)?new Container():new Row(
          children: <Widget>[
            Text(subtitle,style: subtitleTextStyle??TextStyle(color: Color(YYColors.secondarySection),fontSize: YYSize.small)),
            Image.asset(CommonUtils.Local_Icon_prefix+"arrow_more.png",width: 13,height: 13,fit:BoxFit.fill)
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: height,
      child: new Padding(
        padding: new EdgeInsets.only(left:10.5,right:10.5),
        child: (onPressed==null)?_buildContent():FlatButton(
          padding: EdgeInsets.all(0),
          onPressed: () {onPressed?.call();},
          child: _buildContent()
        )
      ),
    );
  }
}