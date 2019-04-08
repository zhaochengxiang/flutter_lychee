import 'package:flutter/material.dart';
import 'package:lychee/common/model/Lesson.dart';
import 'package:lychee/common/util/CommonUtils.dart';
import 'package:lychee/common/style/Style.dart';

class ScholarItem extends StatelessWidget {
  final String avatar;
  final String author;
  final String honor;
  final VoidCallback onPressed;

  ScholarItem({this.avatar,this.author,this.honor,this.onPressed});

  @override
    Widget build(BuildContext context) {
      return new FlatButton(
        padding: EdgeInsets.all(0),
        onPressed: (){onPressed?.call();},
        child: Container(
          height: 62.5,
          child: Padding(
            padding: EdgeInsets.only(left: 10.5,right: 10.5), 
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ClipOval(
                  child: new FadeInImage.assetNetwork(
                    placeholder: CommonUtils.Local_Icon_prefix+'user_placeholder.png',
                    fit: BoxFit.fill,
                    image: CommonUtils.avatarPath(avatar),
                    width: 52.0,
                    height: 52.0,
                  ),
                ),
                SizedBox(width: 10.5),
                Expanded(
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      (author==null||author.length==0)?new Container():Text(author,style: TextStyle(color: Color(YYColors.primaryText),fontSize: YYSize.large),maxLines: 1,overflow: TextOverflow.ellipsis),
                      SizedBox(height: (author==null||author.length==0)?0:5),
                      (honor==null||honor.length==0)?new Container():Text(honor,style: TextStyle(color: Color(YYColors.secondaryText),fontSize: YYSize.medium),maxLines: 1,overflow: TextOverflow.ellipsis),
                    ],  
                  )
                ),
                SizedBox(width: 10.5,),
                Image.asset(CommonUtils.Local_Icon_prefix+"arrow_more.png",width: 13,height: 13,fit:BoxFit.fill)
              ],
            )
          )
        )
      );
    }
}