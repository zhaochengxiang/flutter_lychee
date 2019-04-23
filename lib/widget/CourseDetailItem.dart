import 'package:flutter/material.dart';
import 'package:lychee/common/model/Lesson.dart';
import 'package:lychee/common/style/Style.dart';

class CourseDetailItem extends StatelessWidget {
  final Lesson lesson;
  final int row;
  final VoidCallback onPressed;
  CourseDetailItem(this.lesson,this.row,{this.onPressed});

  @override
    Widget build(BuildContext context) {
      return new InkWell(
        onTap: (){onPressed?.call();},
        child: Container(
          height: 44.0,
          child: Padding( 
            padding: EdgeInsets.only(left: 10.5,right: 10.5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                    height: 18.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                      color: Color(YYColors.primary)
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 5.5,right: 5.5),
                      child: Center(
                        child: Text((row+1).toString(),style:TextStyle(color: Colors.white,fontSize: YYSize.medium),maxLines: 1,overflow: TextOverflow.ellipsis),
                      ),
                    ),
                ),
                SizedBox(width: 5.0),
                Expanded(
                  child: (lesson.title==null)?new Container():Text(lesson.title,style: TextStyle(color: Color(YYColors.primaryText),fontSize: YYSize.large),maxLines: 1,overflow: TextOverflow.ellipsis)
                ),
              ],
            )
          )
        )
      );
    }
}