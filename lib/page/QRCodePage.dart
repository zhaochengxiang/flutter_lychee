import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:lychee/common/model/QRCode.dart';
import 'package:lychee/common/model/Shadow.dart';
import 'package:lychee/common/util/CommonUtils.dart';
import 'package:lychee/widget/base/BaseState.dart';
import 'package:lychee/widget/base/BaseWidget.dart';
import 'package:lychee/common/style/Style.dart';

class QRCodePage extends StatefulWidget {
  final QRCode qrCode;

  QRCodePage(this.qrCode);
  @override
  _QRCodePageState createState() => _QRCodePageState();
}

class _QRCodePageState extends State<QRCodePage> with AutomaticKeepAliveClientMixin<QRCodePage>,BaseState<QRCodePage> {

  @override
  remotePath() {
    return "/shadow/save";
  }

  @override
  generateRemoteParams() {
    Map params = new Map();
    params["type"] = widget.qrCode.type;
    params["lid"] = widget.qrCode.lid;

    params["list"] = widget.qrCode.list.toSet();
    return params;
  }

  @override
  jsonConvertToModel(Map<String,dynamic> json) {
    return Shadow.fromJson(json);
  }
 
  @override
  Widget build(BuildContext context) {
    Shadow shadow = control.data;

    String _title = "",_desc = "";
    if (widget.qrCode.type == QRCode.TYPE_BORROW_FROM_ORGANIZE || widget.qrCode.type == QRCode.TYPE_BORROW_FROM_PERSON) {
      _title = "借书";
    } else if (widget.qrCode.type ==QRCode.TYPE_RETURN_TO_ORGANIZE || widget.qrCode.type == QRCode.TYPE_RETURN_TO_PERSON) {
      _title = "还书";
    }

    if (widget.qrCode.type == QRCode.TYPE_BORROW_FROM_ORGANIZE || widget.qrCode.type == QRCode.TYPE_RETURN_TO_ORGANIZE) {
      _desc = "请将二维码给图书管理员扫描";
    } else if (widget.qrCode.type == QRCode.TYPE_BORROW_FROM_PERSON || widget.qrCode.type == QRCode.TYPE_RETURN_TO_PERSON) {
      _desc = "请将二维码给图书主人扫描";
    }

    return new Scaffold(
      appBar: new AppBar(
        leading: IconButton(
          icon: new Image.asset(CommonUtils.Local_Icon_prefix+"back.png",width: 18.0,height: 18.0),
          onPressed: () {
            CommonUtils.closePage(context);
          }),
        title:Text(_title),
        centerTitle: true,
      ),
      body: BaseWidget(
        control:control,
        onRefresh:handleRefresh,
        child: Center( 
          child: new Column(
            children: <Widget>[
              SizedBox(height: 52),
              QrImage(
                data: (shadow==null)?"":CommonUtils.QRCode_Prefix+shadow.type.toString()+shadow.id,
                size: 208.0
              ),
              SizedBox(height: 21),
              Text(_desc,style: TextStyle(color: Color(YYColors.secondaryText),fontSize: YYSize.tip),overflow: TextOverflow.ellipsis)
            ],
          )
        ),
      )
    );
  }
}