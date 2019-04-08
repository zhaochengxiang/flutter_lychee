import 'package:sharesdk/sharesdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lychee/common/util/CommonUtils.dart';
import 'package:lychee/common/style/Style.dart';

class ShareManager {
  static ShareSDKRegister register =ShareSDKRegister();
  static String wxAppId = 'wxcb24d644e340e9cc';
  static String wxAppSecret = '34a7656f86280f75e16cd9094a8a1f54';
  static Map<String, dynamic> platformsInfo = {'wechat_session':{'name':'微信好友','assetName':'book.png'},'wechat_timeline':{'name':'微信朋友圈','assetName':'book.png'}};

  static void init() {
    register.setupWechat(wxAppId, wxAppSecret);
    ShareSDK.regist(register);
  }

  static List<Widget> buildMenuList(BuildContext context,BuildContext sheetContext, List<String> platforms,SSDKMap params) {
    List<Widget> widgetList = new List();
    for (int i = 0; i < platforms.length; i++) {
      widgetList.add(buildMenuItem(context,sheetContext,platforms[i],params));
    }

    return widgetList;
  }
 
  static Widget buildMenuItem(BuildContext context,BuildContext sheetContext,String platform,SSDKMap params) {
    String name,assetName;
    platformsInfo.forEach((String colName, dynamic value) {
      if (colName ==platform) {
        name = value['name'];
        assetName = value['assetName'];
      }
    });

    return FlatButton(
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(CommonUtils.Local_Icon_prefix+assetName,width:65.0,height:65.0),
          Text(name,style: TextStyle(color: Color(YYColors.secondaryText),fontSize: YYSize.medium), overflow: TextOverflow.ellipsis,),
        ],
      ),
      onPressed: () {
        Navigator.pop(sheetContext);
          ShareSDK.share(ShareSDKPlatforms.wechatSession, params, (SSDKResponseState state, Map userData, Map contentEntity, SSDKError error){
            showToast(state); 
          }
       );
      },
    );
  }

  static showMenu(context,platforms,title,desc,url,{type = 3}) {
    SSDKMap params = SSDKMap()
                ..setGeneral(
                    title,
                    desc,
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
                children: buildMenuList(context,sheetContext,platforms,params),
              );
      }
    );
  }

  static void authToWechat(BuildContext context) {
    ShareSDK.auth(
        ShareSDKPlatforms.wechatSession, null, (SSDKResponseState state,
        Map user, SSDKError error) {
      showToast(state);
    });
  }

  static void showToast(SSDKResponseState state) {
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