import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import 'package:lychee/widget/base/BaseListState.dart';
import 'package:lychee/widget/base/BaseListWidget.dart';
import 'package:lychee/widget/base/BaseState.dart';
import 'package:lychee/common/style/Style.dart';
import 'package:lychee/common/util/CommonUtils.dart';
import 'package:lychee/common/model/User.dart';
import 'package:lychee/widget/SeparatorWidget.dart';

class MineInfoPage extends StatefulWidget {
  @override
  State<MineInfoPage> createState() {
    return _MineInfoPageState();
  }
}

class _MineInfoPageState extends State<MineInfoPage>  with AutomaticKeepAliveClientMixin<MineInfoPage>,BaseState<MineInfoPage>,BaseListState<MineInfoPage> {

  @override
  bool get needRefreshHeader => false;

  @override
  bool get needRefreshFooter => false;

  @override
  remotePath() {
    return "/user/getMyProfile";
  }

  @protected
  jsonConvertToModel(Map<String,dynamic> json) {
    return User.fromJson(json);
  }

  @override
  handleRefreshData(data) {
    super.handleRefreshData(data);
    User user =control.data;

    String sex = '';
    if (user.sex == 0) {
      sex = '女';
    } else if (user.sex == 1) {
      sex = '男';
    }

    List items = new List();
    items.addAll([
      {'title':'头像','desc':user.avatar},
      {'title':'昵称','desc':user.username??''},
      {'title':'性别','desc':sex},
      {'title':'退出'},
    ]);
    control.data = items;
  }

  _renderListItem(index) {
    if (control.data != null && control.data.length>0) {
      Map item = control.data[index];
      if (index == 0) {

        return Container(
          height: 47,
          child: FlatButton(
            padding:EdgeInsets.zero,
            child: ListTile(
              title: Text(item['title'],style: TextStyle(color: Color(YYColors.primaryText),fontSize: YYSize.large), overflow: TextOverflow.ellipsis),
              trailing: ClipOval(
                child: new FadeInImage.assetNetwork(
                  placeholder: CommonUtils.Local_Icon_prefix+'user_placeholder.png',
                  fit: BoxFit.fill,
                  image: CommonUtils.avatarPath(item['desc']),
                  width: 30.0,
                  height: 30.0,
                ),
              ),
            ),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext sheetContext) {
                  return new ListView.builder(
                    shrinkWrap: true,
                    physics: new NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      
                      return Column(
                        children: <Widget>[
                          Container(
                            height: 47,
                            child: FlatButton(
                              padding:EdgeInsets.zero,
                              child: Center(
                                child: Text((index==0)?'拍照':'从手机相册选择',style: TextStyle(color: Color(YYColors.red),fontSize: YYSize.large), overflow: TextOverflow.ellipsis)
                              ),
                              onPressed: () {
                                
                              },
                            ),
                          ),
                          SeparatorWidget()
                        ],
                      );
                    },
                    itemCount: 2,
                  );
                }
              );
            },
          ),
        );

      } else if (index == 1 || index == 2) {
        return Container(
          height: 47,
          child: FlatButton(
            padding:EdgeInsets.zero,
            child: ListTile(
              title: Text(item['title'],style: TextStyle(color: Color(YYColors.primaryText),fontSize: YYSize.large), overflow: TextOverflow.ellipsis),
              trailing: Text(item['desc'],style: TextStyle(color: Color(YYColors.thirdText),fontSize: YYSize.tip), overflow: TextOverflow.ellipsis),
            ),
            onPressed: () {
              
            },
          ),
        );

      } else if (index == 3) {

        return Container(
          height: 47,
          child: FlatButton(
            padding:EdgeInsets.zero,
            child: Center(
              child: Text(item['title'],style: TextStyle(color: Color(YYColors.red),fontSize: YYSize.large), overflow: TextOverflow.ellipsis)
            ),
            onPressed: () {
              
            },
          ),
        );

      }
    }    
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
        title:Text("我的资料"),
        centerTitle: true,
      ),
      body: BaseListWidget(
        control:control,
        itemBuilder: (BuildContext context, int index) => _renderListItem(index),
      )
    );
  }
}
