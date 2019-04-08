import 'package:flutter/material.dart';
import 'package:lychee/common/util/CommonUtils.dart';

enum IconTextDirection {
  row,
  column,
}

class IconText extends StatelessWidget {
  final IconTextDirection direction;
  final String iconAssetName;
  final String iconNetUrl;
  final double iconWidth;
  final double iconHeight;
  final ShapeBorder iconShapeBorder;
  final BoxFit iconFit;
  final String text;
  final TextStyle textStyle;
  final int maxLines;
  final double textLineHeight;
  final double padding;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;

  IconText({
    this.direction = IconTextDirection.row,
    this.iconAssetName = '',
    this.iconNetUrl = '',
    this.iconWidth,
    this.iconHeight,
    this.iconShapeBorder,
    this.iconFit = BoxFit.fill,
    this.text,
    this.textStyle,
    this.maxLines = 1,
    this.textLineHeight = 20.0,
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
        border: iconShapeBorder??null,
      ),
      child: Image.asset(CommonUtils.Local_Icon_prefix+iconAssetName,fit:iconFit),
    ) : new Container());

    widgetList.add((iconNetUrl.length!=0)?new Container(
      width: iconWidth,
      height:iconHeight,
      decoration: new BoxDecoration(
        border: iconShapeBorder??null,
      ),
      child: FadeInImage.assetNetwork(placeholder: CommonUtils.Local_Icon_prefix+'book_placeholder.png',image:iconNetUrl,fit:iconFit),
    ) : new Container());
    widgetList.add(new Padding(padding: new EdgeInsets.all(padding)));
    widgetList.add(new Container(width:iconWidth,height:maxLines*textLineHeight,child:Text(text,style: textStyle,overflow: TextOverflow.ellipsis,maxLines: maxLines,textAlign: TextAlign.center)));

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
    return (direction==IconTextDirection.row)?rowWidget():columnWidget();
  }
}
