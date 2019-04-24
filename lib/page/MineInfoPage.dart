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
import 'package:lychee/common/manager/HttpManager.dart';
import 'package:lychee/common/event/NeedRefreshEvent.dart';
import './SexPage.dart';
import './UpdatePage.dart';

class MineInfoPage extends StatefulWidget {
  @override
  State<MineInfoPage> createState() {
    return _MineInfoPageState();
  }
}

class _MineInfoPageState extends State<MineInfoPage>  with AutomaticKeepAliveClientMixin<MineInfoPage>,BaseState<MineInfoPage>,BaseListState<MineInfoPage> {

  User user;
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
    user =control.data;
    control.data = getItems();
  }

  @protected
  List getItems() {
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
    var res = await HttpManager.imageNetFetch(context,'/user/uploadAvatar',_image);
    Navigator.pop(context);
    if (res!=null && res.result && res.data!=null) {
      user = User.fromJson(res.data);
      if (isShow) {
        setState(() {
          control.data =getItems();     
        });
      }
      NeedRefreshEvent.refreshHandleFunction("MinePage");
    }
  }

  @protected
  _openCamera() async{
    PermissionStatus permission = await PermissionHandler().checkPermissionStatus(PermissionGroup.camera);
    if (permission ==PermissionStatus.unknown) {

      await PermissionHandler().requestPermissions([PermissionGroup.camera]);
      _openCamera();

    } else if (permission ==PermissionStatus.denied || permission ==PermissionStatus.restricted) {

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
      if (_image!=null) {
        _uploadFile();
      }
  
    }
  }

  @protected
  _openGallery() async {
    PermissionStatus permission = await PermissionHandler().checkPermissionStatus(PermissionGroup.photos);
    if (permission ==PermissionStatus.unknown) {

      await PermissionHandler().requestPermissions([PermissionGroup.photos]);
      _openGallery();

    } else if (permission == PermissionStatus.denied || permission == PermissionStatus.restricted) {

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
      if (_image!=null) {
        _uploadFile();
      }

    }
  }

  @protected
  _exit() {
    showCupertinoModalPopup<int>(context: context, builder:(cxt){
      return CupertinoActionSheet(
        title: Text("确定退出登录吗"),
        cancelButton: CupertinoActionSheetAction(
          onPressed: (){

            Navigator.pop(context);
          }, 
          child: Text("取消",style: TextStyle(color: Color(YYColors.primary)))
        ),
        actions: <Widget>[
          CupertinoActionSheetAction(onPressed: () async{

            Navigator.pop(context);

            var res = await handleNotAssociatedWithRefreshRequest("/user/logout", {});
            if (res!=null && res.result) {
              HttpManager.clearAuthorization();
              NeedRefreshEvent.refreshHandleFunction("MinePage");
              CommonUtils.closePage(context);
            }

          }, child: Text('确定',style: TextStyle(color: Color(YYColors.primary)))),
        ],
      );
    });
  }

  _renderListItem(index) {
    if (control.data != null && control.data.length>0) {
      Map item = control.data[index];
      if (index == 0) {

        return Container(
          height: 47,
          child: InkWell(
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
            onTap: () {

              showCupertinoModalPopup<int>(context: context, builder:(cxt){
                return CupertinoActionSheet(
                  cancelButton: CupertinoActionSheetAction(
                    onPressed: (){
                      
                      Navigator.pop(context);
                    
                    }, 
                    child: Text("取消",style: TextStyle(color: Color(YYColors.primary)))
                  ),
                  actions: <Widget>[
                    CupertinoActionSheetAction(onPressed: (){

                      Navigator.pop(context);
                      _openCamera();

                    }, child: Text('拍照',style: TextStyle(color: Color(YYColors.primary)))),
                    CupertinoActionSheetAction(onPressed: (){

                      Navigator.pop(context);
                      _openGallery();

                    }, child: Text('从手机相册选择',style: TextStyle(color: Color(YYColors.primary)))),
                  ],
                );
              });
            },
          ),
        );

      } else if (index == 1 || index == 2) {
        return Container(
          height: 47,
          child: InkWell(
            child: ListTile(
              title: Text(item['title'],style: TextStyle(color: Color(YYColors.primaryText),fontSize: YYSize.large), overflow: TextOverflow.ellipsis),
              trailing: Text(item['desc'],style: TextStyle(color: Color(YYColors.thirdText),fontSize: YYSize.tip), overflow: TextOverflow.ellipsis),
            ),
            onTap: () {
              if (index == 1) {

                CommonUtils.openPage(context, UpdatePage(type: 0,username: user.username));

              } else if (index == 2) {

                CommonUtils.openPage(context, SexPage(sex: user.sex));
              
              }
            },
          ),
        );

      } else if (index == 3) {

        return Container(
          height: 47,
          child: InkWell(
            child: Center(
              child: Text(item['title'],style: TextStyle(color: Color(YYColors.red),fontSize: YYSize.large), overflow: TextOverflow.ellipsis)
            ),
            onTap: () {
              _exit();
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
