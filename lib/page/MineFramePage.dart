import 'package:flutter/material.dart';
import 'package:lychee/common/util/CommonUtils.dart';
import 'package:lychee/widget/MineFrame.dart';
import 'package:lychee/common/style/Style.dart';

class MineFramePage extends StatelessWidget {
@override 
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        title:Text("我的书架"),
        centerTitle: true, 
        leading: FlatButton(
          padding: EdgeInsets.all(0), 
          child: Image.asset(CommonUtils.Local_Icon_prefix+"back.png",width: 18,height: 18),
          onPressed: (){
            CommonUtils.closePage(context);
          },
        ),
      ),
      persistentFooterButtons: <Widget>[
        Container(
          height: 47.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              FlatButton(
                padding: EdgeInsets.zero,
                child: Container(
                  width: 104,
                  color: Color(YYColors.primary),
                  child: Center(
                    child: Text("添加书架",style:TextStyle(color: Colors.white,fontSize: YYSize.tip),overflow: TextOverflow.ellipsis)
                  ),
                ),
                onPressed: () {
              
                }
              )
            ],
          ),
        )
      ],
      body: MineFrame(needSlide: true),
    );
  } 
}

