import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:lychee/common/model/QRCode.dart';
import 'package:lychee/common/model/Shadow.dart';
import 'package:lychee/common/util/CommonUtils.dart';
import 'package:lychee/widget/base/BaseState.dart';
import 'package:lychee/widget/base/BaseWidget.dart';

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

    return new Scaffold(
      appBar: new AppBar(
        leading: IconButton(
          icon: new Image.asset(CommonUtils.Local_Icon_prefix+"back.png",width: 18.0,height: 18.0),
          onPressed: () {
            CommonUtils.closePage(context);
          }),
        title:Text("借书"),
        centerTitle: true,
      ),
      body: BaseWidget(
        control:control,
        onRefresh:handleRefresh,
        child: new QrImage(
          data: (shadow==null)?"":CommonUtils.QRCode_Prefix+shadow.type.toString()+shadow.id,
          size: 200.0,
        ),
      ),
    );
  }
}