import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:lychee/widget/base/BaseListState.dart';
import 'package:lychee/widget/base/BaseListWidget.dart';
import 'package:lychee/widget/base/BaseState.dart';
import 'package:lychee/common/style/Style.dart';
import 'package:lychee/common/model/Library.dart';
import 'package:lychee/widget/SeparatorWidget.dart';

typedef LibraryItemCallback = void Function(Library library);

class MineLibraryPage extends StatefulWidget {

  final String remotePath;
  final LibraryItemCallback onPressed;
  MineLibraryPage({@required this.remotePath,this.onPressed});

  @override
  State<MineLibraryPage> createState() {
    return _MineLibraryPageState();
  }
}

class _MineLibraryPageState extends State<MineLibraryPage>  with AutomaticKeepAliveClientMixin<MineLibraryPage>,BaseState<MineLibraryPage>, BaseListState<MineLibraryPage> {

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
    return Library.fromJson(json);
  }

  _renderListItem(index) {
    Library library = control.data[index];

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
            SeparatorWidget()
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
      child: BaseListWidget(
        refreshKey: refreshIndicatorKey,
        control: control,
        itemBuilder:(BuildContext context, int index)=>_renderListItem(index),
      )
    );
  }
}