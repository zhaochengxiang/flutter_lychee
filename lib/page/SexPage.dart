import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:lychee/widget/base/BaseListState.dart';
import 'package:lychee/widget/base/BaseListWidget.dart';
import 'package:lychee/widget/base/BaseState.dart';
import 'package:lychee/common/style/Style.dart';
import 'package:lychee/common/util/CommonUtils.dart';
import 'package:lychee/common/event/NeedRefreshEvent.dart';

class SexPage extends StatefulWidget {
  final int sex;
  SexPage({this.sex});
  @override
  State<SexPage> createState() {
    return _SexPageState(sex);
  }
}

class _SexPageState extends State<SexPage>  with AutomaticKeepAliveClientMixin<SexPage>,BaseState<SexPage>, BaseListState<SexPage> {

  int sex;
  _SexPageState(this.sex);

  @override
  bool get needRefreshHeader => false;

  @override
  bool get needRefreshFooter => false;

  @protected
  bool get needNetworkRequest => false;

  @override
  dynamic get getData => [
    SexModel(title:"男",id:1),
    SexModel(title:"女",id:0),
  ];

  _renderListItem(index) {
    SexModel item = control.data[index];
    return Container(
      height: 47,
      child: InkWell(
        child: ListTile(
          title: Text(item.title,style: TextStyle(color: Color(YYColors.primaryText),fontSize: YYSize.large), overflow: TextOverflow.ellipsis),
          trailing: (sex!=null&&sex==item.id)? Image.asset(CommonUtils.Local_Icon_prefix+"selected.png",width: 13,height: 13,fit:BoxFit.fill) : new SizedBox(width: 13,height:13)
        ),
        onTap: () {
          if (sex!=null&&sex == item.id) return;

          setState(() {
            sex = item.id;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        leading: IconButton(
          icon: new Image.asset(CommonUtils.Local_Icon_prefix+"back.png",width: 18.0,height: 18.0),
          onPressed: () {
            CommonUtils.closePage(context);
          }),
        title:Text("修改性别"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
          icon: new Icon(Icons.check,color: ((widget.sex==null&&sex!=null)||(widget.sex!=null&&sex!=widget.sex))?Color(YYColors.primary):Color(YYColors.disable)),
          onPressed: () async {
            if ((widget.sex==null&&sex!=null)||(widget.sex!=null&&sex!=widget.sex)) {
              var res = await handleNotAssociatedWithRefreshRequest("/user/updateSex", {"sex":sex});

              if (res!=null && res.result) {
                CommonUtils.closePage(context);
                Fluttertoast.showToast(msg: "修改性别成功",gravity: ToastGravity.CENTER);
                NeedRefreshEvent.refreshHandleFunction("MineInfoPage");
              }
            }
          }),
        ],
      ),
      body: BaseListWidget(
        control:control,
        refreshKey: refreshIndicatorKey,
        itemBuilder: (BuildContext context, int index) => _renderListItem(index),
      )
    );
  }
}

class SexModel {
  String title;
  int id;
  SexModel({this.title,this.id});
}