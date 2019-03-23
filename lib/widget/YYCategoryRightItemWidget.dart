import 'package:flutter/material.dart';
import 'package:lychee/common/model/YYCategory.dart';
import 'package:lychee/common/style/YYStyle.dart';

typedef CategoryItemCallback = void Function(int index);

class YYCategoryRightItemWidget extends StatefulWidget {
  final YYCategory category;
  final bool isSectionHighlight;
  final int itemHighlightIndex;
  final VoidCallback onSectionPress;
  final CategoryItemCallback onItemPress;

  YYCategoryRightItemWidget({this.category,this.isSectionHighlight,this.itemHighlightIndex,this.onSectionPress,this.onItemPress});

  @override
  _YYCategoryRightItemWidgetState createState() => _YYCategoryRightItemWidgetState();
}

class _YYCategoryRightItemWidgetState extends State<YYCategoryRightItemWidget> {

  static const double crossAxisSpacing = 1.0;
  static const int crossAxisCount = 3;
  static const double mainAxisSpacing = 1.0;

  static const double sectionHeight = 47.0;
  static const double gridTileHeight = 39.5;

  List<Widget> _buildGridTiles() {
    List<Widget> lists = new List();
    for (int i=0;i<widget.category.children.length;i++) {
      YYCategory category =widget.category.children[i];
      Widget tile = new FlatButton( 
        padding: EdgeInsets.all(0),
        child: Container( 
          color: (widget.itemHighlightIndex==i)?Colors.white:Color(YYColors.gray),
          child: Center(
            child: Text(category.name,style: TextStyle(color: (widget.itemHighlightIndex==i)?Color(YYColors.primary):Color(YYColors.secondaryText),fontSize: YYSize.tip), overflow: TextOverflow.ellipsis)
          )
        ),
        onPressed: () {widget.onItemPress?.call(i);},
      );
      lists.add(tile);
    }
    return lists;
  }

  @override
  Widget build(BuildContext context) {
    double ratio = ((MediaQuery.of(context).size.width-(crossAxisCount-1)*crossAxisSpacing)/crossAxisCount)/gridTileHeight;

    return Column(
      children: <Widget>[
        Container(
          height: sectionHeight,
          child: FlatButton(
            padding:EdgeInsets.all(0),
            child: Text(widget.category.name,style: TextStyle(color: widget.isSectionHighlight?Color(YYColors.primary):Color(YYColors.primaryText),fontSize: YYSize.large), overflow: TextOverflow.ellipsis),
            onPressed: () {widget.onSectionPress?.call();},
          )
        ),
        GridView.count(
          primary: false,
          shrinkWrap: true,
          crossAxisSpacing: crossAxisSpacing,
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: mainAxisSpacing,
          childAspectRatio: ratio,
          children: _buildGridTiles(),
        ),
      ],
    );
  }
}