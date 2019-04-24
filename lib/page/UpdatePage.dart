import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:lychee/widget/base/BaseState.dart';
import 'package:lychee/widget/InputWidget.dart';
import 'package:lychee/common/style/Style.dart';
import 'package:lychee/common/util/CommonUtils.dart';
import 'package:lychee/common/event/NeedRefreshEvent.dart';
import 'package:lychee/widget/SeparatorWidget.dart';

class UpdatePage extends StatefulWidget {
  static int UPDATE_USERNAME = 0;

  final int type;
  final String username;
  UpdatePage({this.type,this.username});

  @override
  _UpdatePageState createState() => _UpdatePageState(username);
}

class _UpdatePageState extends State<UpdatePage> with AutomaticKeepAliveClientMixin<UpdatePage>,BaseState<UpdatePage> {

  String username;
  final TextEditingController editController = new TextEditingController();
  _UpdatePageState(this.username);

  @override
  Future<bool> needNetworkRequest() async {
    return false;
  }

  @protected
  _title() {
    if (widget.type == 0) {
      return "修改称呼";
    }

    return "";
  }

  @protected
  _canEdit() {
    if (widget.type == 0) {
      return ((widget.username==null&&username!=null&&username.length!=0)||(widget.username!=null&&username!=null&&username.length!=0&&username!=widget.username));
    }

    return false;
  }

  @override
  void initState() {
    super.initState();
    editController.text = username;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title:Text(_title()),
        centerTitle: true,
        leading: IconButton(
          icon: Image.asset(CommonUtils.Local_Icon_prefix+"back.png",width: 18,height: 18),
          onPressed: (){
            CommonUtils.closePage(context);
          },
        ),
        actions: <Widget>[
          IconButton(
          icon: new Icon(Icons.check,color: _canEdit()?Color(YYColors.primary):Color(YYColors.disable)),
          onPressed: () async {
            if (_canEdit()) {
              var res = await handleNotAssociatedWithRefreshRequest(context, "/user/updateUsername", {"username":username});

              if (res!=null && res.result) {
                CommonUtils.closePage(context);
                Fluttertoast.showToast(msg: "修改称呼成功",gravity: ToastGravity.CENTER);
                NeedRefreshEvent.refreshHandleFunction("MineInfoPage");
              }
            }
          }),
        ]
      ),
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 20.5),
          Padding(
            padding: EdgeInsets.only(left: 10.5,right: 10.5),
            child: new InputWidget(
              onChanged: (String value) {
                if (isShow) {
                  setState(() {
                    username = value;
                  });
                }
              },
              autofocus: true,
              controller: editController,
            )
          ),
          SeparatorWidget()
        ],
      ),
    );
  }

}