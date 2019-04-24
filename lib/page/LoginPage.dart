import 'dart:async';
import 'package:flutter/material.dart';

import 'package:lychee/widget/base/BaseState.dart';
import 'package:lychee/widget/InputWidget.dart';
import 'package:lychee/common/style/Style.dart';
import 'package:lychee/common/util/CommonUtils.dart';
import 'package:lychee/common/local/LocalStorage.dart';
import 'package:lychee/common/event/NeedRefreshEvent.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with AutomaticKeepAliveClientMixin<LoginPage>,BaseState<LoginPage> {
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
  Future<bool> needNetworkRequest() async {
    return false;
  }

  capthaPressd() async {
    if (isPhoneValid) {

      var res = await handleNotAssociatedWithRefreshRequest('/user/sendCaptcha',{"phone":phone.replaceAll(' ', '').replaceAll('-', '')});
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

  loginPressed() async {
    if (isLoginValid) {
      var res = await handleNotAssociatedWithRefreshRequest('/user/validateCaptcha',{'phone':phone.replaceAll(' ', '').replaceAll('-', ''),'captcha':captha});
      
      if (res!=null && res.result) {
        LocalStorage.save(CommonUtils.TOKEN_KEY, res.data['token']);
        NeedRefreshEvent.refreshHandleFunction('MinePage');
        CommonUtils.closePage(context);
      }
    }
  }

  manageState() {
    setState(() {
      isPhoneValid = CommonUtils.isPhoneNo(phone);
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
          leading: IconButton(
            icon: Image.asset(CommonUtils.Local_Icon_prefix+"back.png",width: 18,height: 18),
            onPressed: (){
              CommonUtils.closePage(context);
            },
          )
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 15.5,right: 15.5), 
          child: Column(
            children: <Widget>[
              Padding(padding:EdgeInsets.all(26.0)),
              Column(
                children: <Widget>[
                  new InputWidget(
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
                        InputWidget(
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
                  ):InkWell(
                    onTap: (){capthaPressd?.call();},
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
              InkWell(
                onTap: (){loginPressed?.call();},
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