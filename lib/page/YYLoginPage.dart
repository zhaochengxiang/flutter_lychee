import 'dart:async';
import 'package:flutter/material.dart';

import 'package:lychee/widget/base/YYBaseState.dart';
import 'package:lychee/widget/YYInputWidget.dart';
import 'package:lychee/common/style/YYStyle.dart';
import 'package:lychee/common/util/YYCommonUtils.dart';
import 'package:lychee/common/local/YYLocalStorage.dart';
import 'package:lychee/common/event/YYNeedRefreshEvent.dart';

class YYLoginPage extends StatefulWidget {

  @override
  _YYLoginPageState createState() => _YYLoginPageState();
}

class _YYLoginPageState extends State<YYLoginPage> with AutomaticKeepAliveClientMixin<YYLoginPage>,YYBaseState<YYLoginPage> {
  bool isPhoneValid = false;
  bool isLoginValid = false;
  bool showCountDown = false;

  String phone = '';
  String captha = '';
  int countDownNum;
  Timer _countdownTimer;

  final TextEditingController phoneController = new TextEditingController();
  final TextEditingController capthaController = new TextEditingController();

  @override
  bool get needNetworkRequest => false;

  capthaPressd(context) async {
    if (isPhoneValid) {

      var res = await handleNotAssociatedWithRefreshRequest(context,'/user/sendCaptcha',{"phone":phone.replaceAll(' ', '').replaceAll('-', '')});
      if (res!=null && res.result) {
        setState(() {
          showCountDown = true;
          countDownNum = 60;
        });

        _countdownTimer = new Timer.periodic(new Duration(seconds: 1), (timer){
          setState(() {
            if (countDownNum > 1) {
              countDownNum--;
            } else {
              showCountDown = false;
              _countdownTimer.cancel();
              _countdownTimer = null;
            }
          });
        });
      }
    }
  }

  loginPressed(context) async {
    if (isLoginValid) {
      var res = await handleNotAssociatedWithRefreshRequest(context,'/user/validateCaptcha',{'phone':phone.replaceAll(' ', '').replaceAll('-', ''),'captcha':captha});
      
      if (res!=null && res.result) {
        YYLocalStorage.save(YYCommonUtils.TOKEN_KEY, res.data['token']);
        YYNeedRefreshEvent.refreshHandleFunction('YYMinePage');
        Navigator.pop(context);
      }
    }
  }

  manageState() {
    setState(() {
      isPhoneValid = YYCommonUtils.isPhoneNo(phone);
      isLoginValid = (isPhoneValid&&captha.length==4);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        appBar: new AppBar(
          title:Text("用手机登录"),
          iconTheme: new IconThemeData(color: Colors.black),
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 15.5,right: 15.5), 
          child: Column(
            children: <Widget>[
              Padding(padding:EdgeInsets.all(26.0)),
              Column(
                children: <Widget>[
                  new YYInputWidget(
                    hintText: '请输入手机号',
                    onChanged: (String value) {
                      phone = value;
                      manageState();
                    },
                    textInputType: TextInputType.phone,
                    controller: phoneController,
                  ),
                  Container(
                    height: 1,
                    color:Color(YYColors.divider)
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        YYInputWidget(
                          hintText: '请输入验证码',
                          onChanged: (String value) {
                            captha = value;
                            manageState();
                          },
                          obscureText: true,
                          textInputType: TextInputType.phone,
                          controller: capthaController,
                        ),
                        Container(
                          height: 1,
                          color:Color(YYColors.divider)
                        )
                      ],
                    ),
                  ),
                  showCountDown? Container(
                    width: 104,
                    height: 41.5,
                    decoration: BoxDecoration(
                      color: Color(YYColors.primary),
                      borderRadius: BorderRadius.all(Radius.circular(4.0))
                    ),
                    child:Center(
                      child: Text('$countDownNum秒后重发',style: TextStyle(color: Colors.white,fontSize: YYSize.tip),overflow: TextOverflow.ellipsis)
                    )
                  ):FlatButton(
                    padding:EdgeInsets.all(0),
                    onPressed: (){capthaPressd?.call(context);},
                    child: Container(
                      width: 104,
                      height: 41.5,
                      decoration: BoxDecoration(
                        color: isPhoneValid?Color(YYColors.primary):Color(YYColors.disable),
                        borderRadius: BorderRadius.all(Radius.circular(4.0))
                      ),
                      child:Center(
                        child: Text('获取验证码',style: TextStyle(color: Colors.white,fontSize: YYSize.tip),overflow: TextOverflow.ellipsis)
                      )
                    )
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.all(20)),
              FlatButton(
                padding:EdgeInsets.all(0),
                onPressed: (){loginPressed?.call(context);},
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 47,
                  decoration: BoxDecoration(
                    color: isLoginValid?Color(YYColors.primary):Color(YYColors.disable),
                    borderRadius: BorderRadius.all(Radius.circular(4.0))
                  ),
                  child:Center(
                    child: Text('登录',style: TextStyle(color: Colors.white,fontSize: YYSize.navigation),overflow: TextOverflow.ellipsis)
                  )
                )
              )
            ],
          )
        ),
      )
    );
  }

  @override
  void dispose() {
    if (_countdownTimer != null) {
      _countdownTimer.cancel();
      _countdownTimer = null;
    }
    super.dispose();
  }
}