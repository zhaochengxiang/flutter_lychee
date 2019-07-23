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
 
  final int type;
  final int id;
  final String text;
  UpdatePage({this.type,this.id,this.text});

  @override
  _UpdatePageState createState() => _UpdatePageState(this.id,this.text);
}

class _UpdatePageState extends State<UpdatePage> with AutomaticKeepAliveClientMixin<UpdatePage>,BaseState<UpdatePage> {

  int id;
  String text;
  final TextEditingController editController = new TextEditingController();
 
  _UpdatePageState(this.id,this.text);

  @protected
  bool get needNetworkRequest => false;

  @protected
  _title() {
    if (widget.type == UpDateModel.UPDATE_USERNAME) {
      return "修改称呼";
    } else if (widget.type ==UpDateModel.ADD_FRAME) {
      return "添加书架";
    } else if (widget.type ==UpDateModel.UPDATE_FRAME) {
      return "修改书架名称";
    }

    return "";
  }

  @protected
  _message() {
    if (widget.type == UpDateModel.UPDATE_USERNAME) {
      return "修改称呼成功";
    } else if (widget.type ==UpDateModel.ADD_FRAME) {
      return "添加书架成功";
    } else if (widget.type ==UpDateModel.UPDATE_FRAME) {
      return "修改书架成功";
    }

    return "";
  }

  @protected
  _canEdit() {
    return ((widget.text==null&&text!=null&&text.length!=0)||(widget.text!=null&&text!=null&&text.length!=0&&text!=widget.text));
  }

  @protected
  _edit() async {
    if (_canEdit()) {
      
      var res;

      if (widget.type == UpDateModel.UPDATE_USERNAME) {

        res = await handleNotAssociatedWithRefreshRequest("/user/updateUsername", {"username":text});
      
      } else if (widget.type == UpDateModel.ADD_FRAME) {
                
        res = await handleNotAssociatedWithRefreshRequest("/frame/createMy", {"name":text});

      } else if (widget.type == UpDateModel.UPDATE_FRAME) {

        res = await handleNotAssociatedWithRefreshRequest("/frame/update", {"id":id,"name":text});

      }

      if (res!=null && res.result) {
        CommonUtils.closePage(context);
        Fluttertoast.showToast(msg: _message(),gravity: ToastGravity.CENTER);
        
        if (widget.type == UpDateModel.UPDATE_USERNAME) {
          NeedRefreshEvent.refreshHandleFunction("MineInfoPage");
        } else if (widget.type == UpDateModel.ADD_FRAME || widget.type == UpDateModel.UPDATE_FRAME) {
          NeedRefreshEvent.refreshHandleFunction("MineFrame");
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    editController.text = text;
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
          onPressed: () {
            _edit();
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
                    text = value;
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

class UpDateModel {
  static int UPDATE_USERNAME = 0;
  static int ADD_FRAME = 1;
  static int UPDATE_FRAME = 2;
}