import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:lychee/widget/base/BaseListState.dart';
import 'package:lychee/widget/base/BaseListWidget.dart';
import 'package:lychee/widget/base/BaseState.dart';
import 'package:lychee/common/style/Style.dart';
import 'package:lychee/common/model/Library.dart';

typedef LibraryItemCallback = void Function(Library library);

class MineLibrary extends StatefulWidget {

  final String remotePath;
  final LibraryItemCallback onPressed;
  MineLibrary({@required this.remotePath,this.onPressed});

  @override
  State<MineLibrary> createState() {
    return _MineLibraryState();
  }
}

class _MineLibraryState extends State<MineLibrary>  with AutomaticKeepAliveClientMixin<MineLibrary>,BaseState<MineLibrary>, BaseListState<MineLibrary> {

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

    return InkWell( 
      child:Container(
        height: 47.0, 
        child: ListTile(
          title: Text(library.name,style: TextStyle(color: Color(YYColors.primaryText),fontSize: YYSize.large), overflow: TextOverflow.ellipsis)
        )
      ),
      onTap: () {
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