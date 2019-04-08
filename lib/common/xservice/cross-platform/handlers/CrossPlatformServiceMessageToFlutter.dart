import 'dart:async';

import 'package:flutter/services.dart';
import 'package:xservice_kit/ServiceCallHandler.dart';
import 'package:xservice_kit/ServiceGateway.dart';

class CrossPlatformServiceMessageToFlutter extends ServiceCallHandler {

  static void regsiter() {
    ServiceGateway.sharedInstance().registerHandler(new CrossPlatformServiceMessageToFlutter());
  }

  @override
  String name() {
    return "MessageToFlutter";
  }

  @override
  String service() {
    return "CrossPlatformService";
  }

  @override
  Future<Map> onMethodCall(MethodCall call) {
    return onCall(call.arguments["message"]);
  }

//==============================================Do not edit code above!
  Future<Map> onCall(String message) async{
    //TODO:Add you handler code here.
    return null;
  }
}
