import 'package:flutter/material.dart';
import 'package:lychee/common/util/CommonUtils.dart';
import 'package:lychee/common/style/Style.dart';
import 'package:lychee/common/model/Copy.dart';

class CopyItem extends StatelessWidget {
  final Copy copy;
  final VoidCallback onWantBorrowPressed;
  CopyItem(this.copy,{this.onWantBorrowPressed});

  _buildAvatar() {
    if (copy.location!=null&&copy.location.length!=0) {
      return Image.asset(CommonUtils.Local_Icon_prefix+"icon_locate2.png",width: 26,height: 26);
    } else if (copy.username!=null&&copy.username.length!=0) {
      return ClipOval(
        child: new FadeInImage.assetNetwork(
          placeholder: CommonUtils.Local_Icon_prefix+'user_placeholder.png',
          fit: BoxFit.fill,
          image: CommonUtils.avatarPath(copy.avatar),
          width: 26.0,
          height: 26.0,
        ),
      );
    }

    return new Container();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 47.0,
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left:10.5,right:10.5),
            child: Align(
              alignment: Alignment.centerLeft,
              child: _buildAvatar()
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
                      Expanded(child:Text((copy.location!=null&&copy.location.length>0)?copy.location:copy.username,style: TextStyle(color: Color(YYColors.primaryText),fontSize: YYSize.large),maxLines: 1,overflow: TextOverflow.ellipsis)),
                      SizedBox(width: 10.5),
                      (copy.state==0)?Text("已借出",style: TextStyle(color: Color(YYColors.tip),fontSize: YYSize.small)):new Container(),
                      (copy.state==0)?SizedBox(width: 10.5):new Container(),
                      InkWell(
                        onTap: () {onWantBorrowPressed?.call();},
                        child: Container(
                          padding: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(4.0)),
                            color:Color(YYColors.primary),
                          ),
                          child: Text("想借",style: TextStyle(color: Colors.white,fontSize: YYSize.medium)),
                        )
                      )
                    ],
                  ),
                ],  
              )
            )
          ),
        ],
      )
    );
  }
}