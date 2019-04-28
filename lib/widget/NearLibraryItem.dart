import 'package:flutter/material.dart';
import 'package:lychee/common/util/CommonUtils.dart';
import 'package:lychee/common/style/Style.dart';
import 'package:lychee/common/model/Library.dart';

class NearLibraryItem extends StatelessWidget {
  final Library library;
  final VoidCallback onPressed;

  NearLibraryItem(this.library,{this.onPressed});

  @protected
  String _distance() {
    if (library.distance<1000) {
        return "离我"+library.distance.toString()+" 米";
    } else {
      double distance = library.distance/1000;
      return "离我"+distance.toString()+" 公里";
    }
  }

  @override
    Widget build(BuildContext context) {
      return new InkWell(
        onTap: (){onPressed?.call();},
        child: Container(
          height: 82.5,
          child: Padding(
            padding: EdgeInsets.only(left: 15.0), 
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
      
                Expanded(
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(library.name,style: TextStyle(color: Color(YYColors.primaryText),fontSize: YYSize.large),maxLines: 1,overflow: TextOverflow.ellipsis),
                      SizedBox(width: 10.5),
                      Text(library.address,style: TextStyle(color: Color(YYColors.secondaryText),fontSize: YYSize.medium),maxLines: 1,overflow: TextOverflow.ellipsis),
                      SizedBox(width: 10.5),
                      Text(_distance(),style: TextStyle(color: Color(YYColors.thirdText),fontSize: YYSize.small),maxLines: 1,overflow: TextOverflow.ellipsis),
                    ],  
                  )
                ),
                SizedBox(width: 10.5,),
                InkWell(
                  onTap: (){},
                  child: Container(
                    width: 44.5,
                    height:MediaQuery.of(context).size.height,
                    child: Center(
                      child: Image.asset(CommonUtils.Local_Icon_prefix+"icon_locate.png",width: 13.5,height: 13.5,fit:BoxFit.fill)
                    )
                  ),
                ),
              ],
            )
          )
        )
      );
    }
}