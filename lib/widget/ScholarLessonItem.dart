import 'package:flutter/material.dart';
import 'package:lychee/common/model/Lesson.dart';
import 'package:lychee/common/util/CommonUtils.dart';
import 'package:lychee/common/style/Style.dart';

class ScholarLessonItem extends StatelessWidget {
  final Lesson lesson;
  final VoidCallback onPressed;

  ScholarLessonItem(this.lesson,{this.onPressed});

  @override
    Widget build(BuildContext context) {
      return new InkWell(
        onTap: (){onPressed?.call();},
        child: Container(
          height: 47.0,
          child: Padding(
            padding: EdgeInsets.only(left: 10.5,right: 10.5),
            child:Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                (lesson.type== 1||lesson.type == 2)?Image.asset(CommonUtils.Local_Icon_prefix+'voice.png',width: 16.5,height: 16.5,fit:BoxFit.fill):new Container(),
                Expanded(child:(lesson.title!=null)?Text(lesson.title,style: TextStyle(color: Color(YYColors.primaryText),fontSize: YYSize.large),maxLines: 1,overflow: TextOverflow.ellipsis):new Container()),
              ],
            )
          )
        )
      );
    }
}