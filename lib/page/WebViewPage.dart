import 'package:flutter/material.dart';

import 'package:lychee/common/util/CommonUtils.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {

  final String url;
  WebViewPage({this.url});

  @override
  State<WebViewPage> createState() {
    return _WebViewPageState();
  }
}

class _WebViewPageState extends State<WebViewPage> {
  WebViewController _controller;
  String title;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        leading: IconButton(
          icon: new Image.asset(CommonUtils.Local_Icon_prefix+"back.png",width: 18.0,height: 18.0),
          onPressed: () {
            CommonUtils.closePage(context);
          }),
        title:Text(title??""),
        centerTitle: true,
      ),
      body: WebView(
        initialUrl: widget.url??"",
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller = webViewController;
        },
        onPageFinished: (String url) {
          _controller.evaluateJavascript('document.title').then((value) {
            setState(() {
              title = value.replaceAll('\"','');
            });
          });
        },
      )
    );
  }
}