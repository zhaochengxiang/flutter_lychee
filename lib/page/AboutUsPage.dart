import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:package_info/package_info.dart';

import 'package:lychee/widget/base/BaseListState.dart';
import 'package:lychee/widget/base/BaseListWidget.dart';
import 'package:lychee/widget/base/BaseState.dart';
import 'package:lychee/common/style/Style.dart';
import 'package:lychee/common/util/CommonUtils.dart';
import './WebViewPage.dart';

class AboutUsPage extends StatefulWidget {
  @override
  State<AboutUsPage> createState() {
    return _AboutUsPageState();
  }
}

class _AboutUsPageState extends State<AboutUsPage>  with AutomaticKeepAliveClientMixin<AboutUsPage>,BaseState<AboutUsPage>, BaseListState<AboutUsPage> {

  static String privacyUrl = 'https://lizhiketang.com/privacy.html';
  static String serviceUrl = 'https://lizhiketang.com/service.html';
  bool loadVersion = false;

  @override
  bool get needRefreshHeader => false;

  @override
  bool get needRefreshFooter => false;

  @override
  Future<bool> needNetworkRequest() async {
    return false;
  }

  @override
  dynamic get getData => [
    AboutModel(title:"当前版本",desc:""),
    AboutModel(title:"公众号",desc:"荔枝课堂"),
    AboutModel(title:"微博",desc:"荔枝课堂"),
    AboutModel(title:"客服邮箱",desc:"service@wanjuanlink.com"),
    AboutModel(title:"隐私申明"),
    AboutModel(title:"服务协议")
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (loadVersion == false) {
      getPlatformVersion().then((value) {
        loadVersion = true;
        AboutModel firstItem = control.data[0];
        setState(() {
          firstItem.desc = value;
        });
      });
    }
  }

  @protected
  getPlatformVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  _renderListItem(index) {
    AboutModel item = control.data[index];
    return Container(
      height: 47,
      child: InkWell(
        child: ListTile(
          title: Text(item.title,style: TextStyle(color: Color(YYColors.primaryText),fontSize: YYSize.large), overflow: TextOverflow.ellipsis),
          trailing: (item.desc==null)? Image.asset(CommonUtils.Local_Icon_prefix+"arrow_more.png",width: 13,height: 13,fit:BoxFit.fill) : Text(item.desc,style: TextStyle(color: Color(YYColors.thirdText),fontSize: YYSize.tip), overflow: TextOverflow.ellipsis)
        ),
        onTap: () {
          if (index == 4) {
            CommonUtils.openPage(context, WebViewPage(url:privacyUrl));
          } else if (index == 5) {
            CommonUtils.openPage(context, WebViewPage(url:serviceUrl));
          }
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
        title:Text("关于我们"),
        centerTitle: true,
      ),
      body: BaseListWidget(
        control:control,
        refreshKey: refreshIndicatorKey,
        itemBuilder: (BuildContext context, int index) => _renderListItem(index),
      )
    );
  }
}

class AboutModel {
  String title;
  String desc;
  AboutModel({this.title,this.desc});
}