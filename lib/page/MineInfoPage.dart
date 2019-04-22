import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:lychee/widget/base/BaseListState.dart';
import 'package:lychee/widget/base/BaseListWidget.dart';
import 'package:lychee/widget/base/BaseState.dart';
import 'package:lychee/common/style/Style.dart';
import 'package:lychee/common/util/CommonUtils.dart';
import 'package:lychee/common/model/User.dart';
import 'package:lychee/widget/SeparatorWidget.dart';
import 'package:lychee/common/manager/HttpManager.dart';
import 'package:lychee/common/event/NeedRefreshEvent.dart';

class MineInfoPage extends StatefulWidget {
  @override
  State<MineInfoPage> createState() {
    return _MineInfoPageState();
  }
}

class _MineInfoPageState extends State<MineInfoPage>  with AutomaticKeepAliveClientMixin<MineInfoPage>,BaseState<MineInfoPage>,BaseListState<MineInfoPage> {

  File _image;

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
    control.data = getItems(user);
  }

  @protected
  List getItems(User user) {
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
    return items;
  }

  @protected
  _uploadFile() async {
    if (control.isLoading) {
      return new ResultData(null, false);
    }

    CommonUtils.showLoadingDialog(context);
    var res = await HttpManager.imageNetFetch('/user/uploadAvatar',_image);
    Navigator.pop(context);
    if (res!=null && res.result && res.data!=null) {
      User user = User.fromJson(res.data);
      if (isShow) {
        setState(() {
          control.data =getItems(user);     
        });
      }
      NeedRefreshEvent.refreshHandleFunction("MinePage");
    }
  }

  @protected
  _openCamera() async{
    PermissionStatus permission = await PermissionHandler().checkPermissionStatus(PermissionGroup.camera);
    if (permission ==PermissionStatus.unknown) {

      Navigator.pop(context);
      await PermissionHandler().requestPermissions([PermissionGroup.camera]);
      _openCamera();

    } else if (permission ==PermissionStatus.denied || permission ==PermissionStatus.restricted) {

      Navigator.pop(context);
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text("相机服务未开启"),
            content: Text("请在系统设置中开启相机服务"),
            actions: <Widget>[
              CupertinoDialogAction(
                onPressed: (){Navigator.pop(context);},
                child: Text("确定"),
              )
            ],
          );
        }
      );

    } else {
  
      _image =await ImagePicker.pickImage(source: ImageSource.camera,maxWidth: 200,maxHeight: 200);
      Navigator.pop(context);
      if (_image!=null) {
        _uploadFile();
      }
  
    }
  }

  @protected
  _openGallery() async {
    PermissionStatus permission = await PermissionHandler().checkPermissionStatus(PermissionGroup.photos);
    if (permission ==PermissionStatus.unknown) {

      Navigator.pop(context);
      await PermissionHandler().requestPermissions([PermissionGroup.photos]);
      _openGallery();

    } else if (permission == PermissionStatus.denied || permission == PermissionStatus.restricted) {

      Navigator.pop(context);
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text("照片服务未开启"),
            content: Text("请在系统设置中开启照片服务"),
            actions: <Widget>[
              CupertinoDialogAction(
                onPressed: (){Navigator.pop(context);},
                child: Text("确定"),
              )
            ],
          );
        }
      );

    } else {

      _image =await ImagePicker.pickImage(source: ImageSource.gallery,maxWidth: 200,maxHeight: 200);
      Navigator.pop(context);
      if (_image!=null) {
        _uploadFile();
      }

    }
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

              showCupertinoModalPopup<int>(context: context, builder:(cxt){
                return CupertinoActionSheet(
                  cancelButton: CupertinoActionSheetAction(
                    onPressed: (){}, 
                    child: Text("取消")
                  ),
                  actions: <Widget>[
                    CupertinoActionSheetAction(onPressed: (){

                      _openCamera();

                    }, child: Text('拍照')),
                    CupertinoActionSheetAction(onPressed: (){

                      _openGallery();

                    }, child: Text('从手机相册选择')),
                  ],
                );
              });
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
