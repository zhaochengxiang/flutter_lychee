import 'package:sharesdk/sharesdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lychee/common/util/CommonUtils.dart';
import 'package:lychee/common/style/Style.dart';

class ShareManager {

  factory ShareManager() => _instance ??= ShareManager._();

  ShareManager._() {
    register.setupWechat(wxAppId, wxAppSecret);
    ShareSDK.regist(register);
  }

  static ShareManager _instance;

  final ShareSDKRegister register =ShareSDKRegister();
   String wxAppId = 'wxcb24d644e340e9cc';
  final String wxAppSecret = '34a7656f86280f75e16cd9094a8a1f54';
  final Map<String, dynamic> supportPlatformsInfo = {'wechat_session':{'id':22,'name':'微信好友','assetName':'book.png'},'wechat_timeline':{'id':23,'name':'微信朋友圈','assetName':'book.png'}};

  List<Widget> buildMenuList(BuildContext context,BuildContext sheetContext, List<String> platforms,List<Widget> customMenuItems,SSDKMap params) {
    List<Widget> widgetList = new List();
    for (int i = 0; i < platforms.length; i++) {
      widgetList.add(buildMenuItem(context,sheetContext,platforms[i],params));
    }

    if (customMenuItems!=null && customMenuItems.length!=0) {
      widgetList.addAll(customMenuItems);
    }

    return widgetList;
  }
 
  Widget buildMenuItem(BuildContext context,BuildContext sheetContext,String platform,SSDKMap params) {
    String name,assetName;
    int id;
    supportPlatformsInfo.forEach((String colName, dynamic value) {
      if (colName ==platform) {
        id = value['id'];
        name = value['name'];
        assetName = value['assetName'];
      }
    });

    return FlatButton(
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(CommonUtils.Local_Icon_prefix+assetName,width:30.0,height:30.0,fit: BoxFit.fill),
          Text(name,style: TextStyle(color: Color(YYColors.secondaryText),fontSize: YYSize.medium), overflow: TextOverflow.ellipsis,),
        ],
      ),
      onPressed: () {
        Navigator.pop(sheetContext);
        ShareSDK.share(ShareSDKPlatform(name: name, id: id), params, (SSDKResponseState state, Map userData, Map contentEntity, SSDKError error){
            showToast(state); 
        }
       );
      },
    );
  }

  showMenu(context,{platforms=const ['wechat_session','wechat_timeline'],customMenuItems,title='我正在使用“荔枝课堂”，推荐给你。',desc='打造个人专属知识管理和分享平台，轻松重启学习之路',url='https://lizhiketang.com/download.html',thumbImage,type = 3}) {
    SSDKMap params = SSDKMap()
                ..setGeneral(
                    title,
                    desc,
                    thumbImage,
                    null,
                    null,
                    null,
                    url,
                    null,
                    null,
                    null,
                    SSDKContentType(value:type));

    showModalBottomSheet(
      context: context,
      builder: (BuildContext sheetContext) {
        return GridView.count(
                shrinkWrap: true,
                physics: new NeverScrollableScrollPhysics(),
                primary: false,
                padding: const EdgeInsets.only(left: 0.0,top:10.5,right: 0.0,bottom: 10.5),
                crossAxisSpacing: 2.0,
                mainAxisSpacing: 2.0,
                crossAxisCount: 3,
                children: buildMenuList(context,sheetContext,platforms,customMenuItems,params),
              );
      }
    );
  }

  void authToWechat(BuildContext context) {
    ShareSDK.auth(
        ShareSDKPlatforms.wechatSession, null, (SSDKResponseState state,
        Map user, SSDKError error) {
      showToast(state);
    });
  }

  void showToast(SSDKResponseState state) {
    String title = "失败";
    switch (state) {
      case SSDKResponseState.Success:
        title = "成功";
        break;
      case SSDKResponseState.Fail:
        title = "失败";
        break;
      case SSDKResponseState.Cancel:
        title = "取消";
        break;
      default:
        title = state.toString();
        break;
    }
    Fluttertoast.showToast(msg: title,gravity: ToastGravity.CENTER);
  }
}