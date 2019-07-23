import 'dart:collection';
import 'dart:io';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:lychee/common/util/CommonUtils.dart';
import 'package:lychee/common/local/LocalStorage.dart';
import 'package:lychee/common/event/HttpErrorEvent.dart';
import 'package:lychee/common/event/NeedRefreshEvent.dart';
import 'package:lychee/page/LoginPage.dart';

class ResultData {
  var data;
  bool result;

  ResultData(this.data, this.result);
}

///http请求
class HttpManager {
  static const String host = "https://rest.lizhiketang.com";
  static const CONTENT_TYPE_FORM = "application/x-www-form-urlencoded";

  static Map optionParams = {
    "timeoutMs": 10000,
    "authorizationCode": null,
  };

  ///发起网络请求
  ///[ url] 请求url
  ///[ params] 请求参数
  ///[ header] 外加头
  ///[ option] 配置
  static netFetch(context,url, params, Map<String, String> header, Options option, {noTip = false}) async {

    var connectivityResult = await (new Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return new ResultData(HttpErrorEvent.errorHandleFunction("无网络链接请检查网络", noTip), false);
    }

    Map<String, String> headers = new HashMap();
    if (header != null) {
      headers.addAll(header);
    }

    //授权码
    if (optionParams["authorizationCode"] == null) {
      var authorizationCode = await LocalStorage.get(CommonUtils.TOKEN_KEY);
      if (authorizationCode != null) {
        optionParams["authorizationCode"] = authorizationCode;
      }
    }

    headers["Access-Token"] = optionParams["authorizationCode"];

    if (option != null) {
      option.headers = headers;
    } else{
      option = new Options(method: "post");
      option.headers = headers;
    }

    option.contentType = ContentType.parse(CONTENT_TYPE_FORM);

    ///超时
    option.connectTimeout = optionParams["timeoutMs"];

    Dio dio = new Dio();
    Response response;
    try {
      response = await dio.request("$host$url", data: params, options: option);
    } on DioError catch (e) {      
      if (e.type == DioErrorType.CONNECT_TIMEOUT) {
        e.message = "与服务器连接超时";
      } else {
        e.message = "与服务器连接发生错误";
      }

      if (CommonUtils.DEBUG) {
        print('请求异常: ' + e.toString());
        print('请求异常url: ' + url);
        if (params != null) {
          print('请求异常参数: ' + params.toString());
        }
      }
      return new ResultData(HttpErrorEvent.errorHandleFunction( e.message, noTip), false);
    }

    if (CommonUtils.DEBUG) {
      print('请求url: ' + url);
      print('请求头: ' + option.headers.toString());
      if (params != null) {
        print('请求参数: ' + params.toString());
      }
      if (response != null) {
        print('返回参数: ' + response.toString());
      }
      if (optionParams["authorizationCode"] != null) {
        print('authorizationCode: ' + optionParams["authorizationCode"]);
      }
    }

    var responseData = response.data;

    ///账号被踢 服务器返回的String类型 应该返回Map类型 未保持一直
    ///我们先强制转换吧!!!
    if (responseData is String) {
      responseData = json.decode(responseData);
    }
    
    //账号被踢
    if (responseData['code'] == 401) {
      
      HttpManager.accountKick(context);

    } else if (responseData['code'] == 200) {

      return new ResultData(responseData['data'], true);

    }

    return new ResultData(HttpErrorEvent.errorHandleFunction(responseData['message'], noTip), false);
  }

  static imageNetFetch(context,url,File file, {noTip = false}) async {

    var connectivityResult = await (new Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return new ResultData(HttpErrorEvent.errorHandleFunction("无网络链接请检查网络", noTip), false);
    }

    if (optionParams["authorizationCode"] == null) {
      var authorizationCode = await LocalStorage.get(CommonUtils.TOKEN_KEY);
      if (authorizationCode != null) {
        optionParams["authorizationCode"] = authorizationCode;
      }
    }

    Options option = new Options(headers: {"Access-Token": optionParams["authorizationCode"]});

    FormData formData = new FormData.from({
      "file": new UploadFileInfo(file, file.uri.pathSegments.last)
    });

    Dio dio = new Dio();
    Response response;
    try {
      response = await dio.post("$host$url", data: formData, options: option);
    } on DioError catch (e) {      
      if (e.type == DioErrorType.CONNECT_TIMEOUT) {
        e.message = "与服务器连接超时";
      } else {
        e.message = "与服务器连接发生错误";
      }

      if (CommonUtils.DEBUG) {
        print('请求异常: ' + e.toString());
        print('请求异常url: ' + url);
      }
      return new ResultData(HttpErrorEvent.errorHandleFunction( e.message, noTip), false);
    }

    if (CommonUtils.DEBUG) {
      print('请求url: ' + url);
      print('请求头: ' + option.headers.toString());
  
      if (response != null) {
        print('返回参数: ' + response.toString());
      }
      if (optionParams["authorizationCode"] != null) {
        print('authorizationCode: ' + optionParams["authorizationCode"]);
      }
    }

    var responseData = response.data;

    if (responseData is String) {
      responseData = json.decode(responseData);
    }

    if (responseData['code'] == 401) {

      HttpManager.accountKick(context);

    } else if (responseData['code'] == 200) {
      
      return new ResultData(responseData['data'], true);
    
    }

    return new ResultData(HttpErrorEvent.errorHandleFunction(responseData['message'], noTip), false);
  }

  static accountKick(BuildContext context) {
    HttpManager.clearAuthorization();
    NeedRefreshEvent.refreshHandleFunction("MinPage");

    if (Navigator.canPop(context) == true) {
      return Navigator.of(context)
      ..pop()
      ..push(new CupertinoPageRoute(builder: (context) => LoginPage()));
    } else {
      Navigator.push(context, new CupertinoPageRoute(builder: (context) => LoginPage()));
    }
  }

  ///清除授权
  static clearAuthorization() {
    optionParams["authorizationCode"] = null;
    LocalStorage.remove(CommonUtils.TOKEN_KEY);
  }
}
