import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:lychee/widget/base/YYBaseListState.dart';
import 'package:lychee/widget/base/YYBaseListWidget.dart';
import 'package:lychee/widget/base/YYBaseState.dart';
import 'package:lychee/common/style/YYStyle.dart';
import 'package:lychee/common/model/YYLibrary.dart';
import 'package:lychee/widget/YYSeparatorWidget.dart';

typedef LibraryItemCallback = void Function(YYLibrary library);

class YYMineLibraryPage extends StatefulWidget {

  final String remotePath;
  final LibraryItemCallback onPressed;
  YYMineLibraryPage({@required this.remotePath,this.onPressed});

  @override
  State<YYMineLibraryPage> createState() {
    return _YYMineLibraryPageState();
  }
}

class _YYMineLibraryPageState extends State<YYMineLibraryPage>  with AutomaticKeepAliveClientMixin<YYMineLibraryPage>,YYBaseState<YYMineLibraryPage>, YYBaseListState<YYMineLibraryPage> {

  @override
  bool get needRefreshHeader => false;

  @override
  bool get needRefreshFooter => false;

  @override
  remotePath() {
    return widget.remotePath;
  }

  @override
  generateRemoteParams() {
    return {};
  }

  @override
  jsonConvertToModel(Map<String,dynamic> json) {
    return YYLibrary.fromJson(json);
  }

  _renderListItem(index) {
    YYBaseListWidgetControl control = baseWidgetControl;

    YYLibrary library = control.data[index];

    return FlatButton( 
      padding: EdgeInsets.all(0),
      child:Container(
        height: 47.0, 
        child:new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child:ListTile(
                title: Text(library.name,style: TextStyle(color: Color(YYColors.primaryText),fontSize: YYSize.large), overflow: TextOverflow.ellipsis)
              )
            ),
            YYSeparatorWidget()
          ],
        )
      ),
      onPressed: () {
        widget.onPressed?.call(library);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: YYBaseListWidget(
        refreshKey: refreshIndicatorKey,
        control: baseWidgetControl,
        itemBuilder:(BuildContext context, int index)=>_renderListItem(index),
      )
    );
  }
}