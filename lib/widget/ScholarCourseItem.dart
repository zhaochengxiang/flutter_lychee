import 'package:flutter/material.dart';
import 'package:lychee/common/model/Course.dart';
import 'package:lychee/common/style/Style.dart';

class ScholarCourseItem extends StatelessWidget {
  final Course course;
  final VoidCallback onPressed;
  ScholarCourseItem(this.course,{this.onPressed});

  @override
    Widget build(BuildContext context) {
      return new InkWell(
        onTap: (){onPressed?.call();},
        child: Container(
          height: 67.5,
          child: Padding(
            padding: EdgeInsets.only(left:10.5,right:10.5),
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(child:(course.title!=null)?Padding(padding: EdgeInsets.only(bottom:10.5), child:Text(course.title,style: TextStyle(color: Color(YYColors.primaryText),fontSize: YYSize.large),maxLines: 1,overflow: TextOverflow.ellipsis)):new Container()),
                  ],
                ),
                Row(
                  children: <Widget>[  
                    Expanded(child:Text("共${course.lessonQuantity}讲",style: TextStyle(color: Color(YYColors.secondaryText),fontSize: YYSize.medium),maxLines: 1,overflow: TextOverflow.ellipsis)),
                  ],
                )
              ],  
            )
          )
        )
      );
    }
}