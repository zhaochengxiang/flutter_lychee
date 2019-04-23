import 'package:flutter/material.dart';
import 'package:lychee/common/model/Course.dart';
import 'package:lychee/common/util/CommonUtils.dart';
import 'package:lychee/common/style/Style.dart';

class CourseItem extends StatelessWidget {
  final Course course;
  final VoidCallback onPressed;
  CourseItem(this.course,{this.onPressed});

  @override
    Widget build(BuildContext context) {
      return new InkWell(
        onTap: (){onPressed?.call();},
        child: Container(
          height: 62.0,
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left:10.5,right:10.5),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child:ClipOval(
                    child: new FadeInImage.assetNetwork(
                      placeholder: CommonUtils.Local_Icon_prefix+'user_placeholder.png',
                      fit: BoxFit.fill,
                      image: CommonUtils.avatarPath(course.avatar),
                      width: 52.0,
                      height: 52.0,
                    ),
                  )
                )
              ),
              Expanded(
                child:Padding(
                  padding: EdgeInsets.only(right:10.5),
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
                          (course.author!=null)?Padding(padding:EdgeInsets.only(right:10.5),child:Text(course.author,style: TextStyle(color: Color(YYColors.secondaryText),fontSize: YYSize.medium),maxLines: 1,overflow: TextOverflow.ellipsis)):new Container(),
                          (course.honor!=null)?Padding(padding:EdgeInsets.only(right: 10.5),child:Text(course.honor,style: TextStyle(color: Color(YYColors.secondaryText),fontSize: YYSize.medium),maxLines: 1,overflow: TextOverflow.ellipsis)):new Container(),
                          Expanded(child:Text("共${course.lessonQuantity}讲",style: TextStyle(color: Color(YYColors.secondaryText),fontSize: YYSize.medium),maxLines: 1,overflow: TextOverflow.ellipsis)),
                          (course.salePrice > 0)?Text("￥"+course.salePrice.toString(),style: TextStyle(color: Color(YYColors.secondaryText),fontSize: YYSize.medium,),maxLines: 1,overflow: TextOverflow.ellipsis,):new Container(),
                        ],
                      )
                    ],  
                  )
                )
              ),
            ],
          )
        )
      );
    }
}