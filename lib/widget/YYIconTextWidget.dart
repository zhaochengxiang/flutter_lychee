import 'package:flutter/material.dart';
import 'package:lychee/common/util/YYCommonUtils.dart';
import 'package:lychee/common/style/YYStyle.dart';

/**
 * 带图标Icon的文本，可调节
 * Created by zcx
 * Date: 2019-03-05
 */
class YYIconTextWidget extends StatelessWidget {
  static const int row = 1;
  static const int column = 2;

  final int type;
  final String iconText;
  final String iconAssetName;
  final String iconNetUrl;
  final double iconWidth;
  final double iconHeight;
  final Color iconColor;
  final BoxFit iconFit;
  final TextStyle textStyle;
  final int maxLines;
  final double textLineHeight;
  final double padding;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;

  YYIconTextWidget({
    this.type = 1,
    this.iconAssetName = '',
    this.iconText,
    this.iconNetUrl = '',
    this.iconWidth,
    this.iconHeight,
    this.iconFit = BoxFit.fill,
    this.textStyle,
    this.maxLines = 1,
    this.textLineHeight = 20.0,
    this.iconColor,
    this.padding = 0.0,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  List<Widget> commonChildren() {
    List<Widget> widgetList = new List();

    widgetList.add((iconAssetName.length!=0)?new Container(
      width: iconWidth,
      height:iconHeight,
      decoration: new BoxDecoration(
        border: Border.all(color:Color(YYColors.border),width: 0.3),
      ),
      child: Image.asset(YYCommonUtils.Local_Icon_prefix+iconAssetName,fit:iconFit, color:iconColor),
    ) : new Container());

    widgetList.add((iconNetUrl.length!=0)?new Container(
      width: iconWidth,
      height:iconHeight,
      decoration: new BoxDecoration(
        border: Border.all(color:Color(YYColors.border),width: 0.3),
      ),
      child: FadeInImage.assetNetwork(placeholder: YYCommonUtils.Local_Icon_prefix+'book_placeholder.png',image:iconNetUrl,fit:iconFit),
    ) : new Container());
    widgetList.add(new Padding(padding: new EdgeInsets.all(padding)));
    widgetList.add(new Container(width:iconWidth,height:maxLines*textLineHeight,child:Text(iconText,style: textStyle,overflow: TextOverflow.ellipsis,maxLines: maxLines,textAlign: TextAlign.center)));

    return widgetList;
  }

  rowWidget() {
    return new Row(
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      children: commonChildren(),
    );
  }

  columnWidget() {
    return new Column(
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      children: commonChildren(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return (type==1)?rowWidget():columnWidget();
  }
}
