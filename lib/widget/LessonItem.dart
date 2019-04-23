import 'package:flutter/material.dart';
import 'package:lychee/common/model/Lesson.dart';
import 'package:lychee/common/util/CommonUtils.dart';
import 'package:lychee/common/style/Style.dart';

class LessonItem extends StatelessWidget {
  final Lesson lesson;
  final VoidCallback onPressed;

  LessonItem(this.lesson,{this.onPressed});

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
                      image: CommonUtils.avatarPath(lesson.avatar),
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
                          (lesson.type== 1||lesson.type == 2)?Padding(padding: EdgeInsets.only(bottom:10.5), child:Image.asset(CommonUtils.Local_Icon_prefix+'voice.png',width: 16.5,height: 16.5,fit:BoxFit.fill)):new Container(),
                          Expanded(child:(lesson.title!=null)?Padding(padding: EdgeInsets.only(bottom:10.5), child:Text(lesson.title,style: TextStyle(color: Color(YYColors.primaryText),fontSize: YYSize.large),maxLines: 1,overflow: TextOverflow.ellipsis)):new Container()),
                        ],
                      ),
                      Row(
                        children: <Widget>[  
                          (lesson.author!=null)?Padding(padding:EdgeInsets.only(right:10.5),child:Text(lesson.author,style: TextStyle(color: Color(YYColors.secondaryText),fontSize: YYSize.medium),maxLines: 1,overflow: TextOverflow.ellipsis)):new Container(),
                          Expanded(child:(lesson.honor!=null)?Text(lesson.honor,style: TextStyle(color: Color(YYColors.secondaryText),fontSize: YYSize.medium),maxLines: 1,overflow: TextOverflow.ellipsis):new Container()),
                          (lesson.salePrice > 0)?Text("￥"+lesson.salePrice.toString(),style: TextStyle(color: Color(YYColors.secondaryText),fontSize: YYSize.medium,),maxLines: 1,overflow: TextOverflow.ellipsis,):new Container(),
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