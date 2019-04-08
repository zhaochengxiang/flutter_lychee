import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:lychee/widget/base/BaseBookListState.dart';
import 'package:lychee/common/model/ReceiptResult.dart';
import 'package:lychee/widget/BookHeaderItem.dart';
import 'package:lychee/widget/BookRadioItem.dart';
import 'package:lychee/widget/SeparatorWidget.dart';
import 'package:lychee/widget/base/BaseBookRadioListWidget.dart';

mixin BaseBookRadioListState<T extends StatefulWidget> on BaseBookListState<T>,AutomaticKeepAliveClientMixin<T>  {

  @override
  bool get needRefreshHeader => false;

  @override
  bool get needRefreshFooter => false;

  @override
  bool get needCategory => false;

  @override
  bool get needLibrary => false;

  @override
  bool get needFrame => false;

  @override
  bool get needCount => false;

  @override
  bool get needSearch => false;

  @protected
  String get buttonName => "";

  @protected
  buttonOnPressed() {

  }

  @override
  options() {
    int options = 0;
    return options;
  } 

  @override
  jsonConvertToModel(Map<String,dynamic> json) {
    return ReceiptResult.fromJson(json);
  }

  _headerItemOnSelected(receiptResult,index) {
    if (control.section == index) {
      setState(() {
        control.section = -1;
        control.indexPaths.clear();
      });
    } else {
      bool isNotSamePerson = false;

      for (int i=0;i<control.indexPaths.length;i++) {
        Map map = control.indexPaths[i];
        if (map["section"] != index) {
          isNotSamePerson = true;
          break;
        }
      }

      if (isNotSamePerson) {
        Fluttertoast.showToast(msg: "只能选择同一个人的图书",gravity: ToastGravity.CENTER);
      } else {
        setState(() {
          control.section = index;
          control.indexPaths.clear();
          if (receiptResult.receiptList!=null) { 
            for (int i=0;i<receiptResult.receiptList.length;i++) {
              control.indexPaths.add({"section":index,"row":i});
            }
          }
        });
      } 
    }
  }

  _renderBookRadioItem(receipt,section,row) {
    bool isNotSamePerson = false, isExist = false;
    int existIndex = -1;

    for (int i=0;i<control.indexPaths.length;i++) {
      Map map =control.indexPaths[i];
      if (map["section"] != section) {
        isNotSamePerson = true;
        break;
      }
      if (map["section"] == section && map["row"] == row) {
        isExist = true;
        existIndex = i;
        break;
      }
    }

    return BookRadioItem(receipt: receipt,isSelected: (row==existIndex),onPressed: (){
      if (isNotSamePerson) {
        Fluttertoast.showToast(msg: "只能选择同一个人的图书",gravity: ToastGravity.CENTER);
      } else {
        if (isExist) {
          setState(() {
            control.indexPaths.removeAt(existIndex);
          });
        } else {
          setState(() {
            control.indexPaths.add({"section":section,"row":row});
          });
        }
      }
    });
  }

  @protected
  renderListItem(context,index) {
    ReceiptResult receiptResult = control.data[index]; 
    return Column(
      children: <Widget>[
        BookHeaderItem(receiptResult: receiptResult,isSelected: (control.section==index), onPressed: (){
          _headerItemOnSelected(receiptResult, index);
        }),
        new ListView.separated(
          shrinkWrap: true,
          physics: new NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index)=>SeparatorWidget(),
          itemBuilder: (context, _index) => _renderBookRadioItem(receiptResult.receiptList[_index], index, _index),
          itemCount: (receiptResult.receiptList==null)?0:receiptResult.receiptList.length,
        )  
      ],
    );
  }

  @override
  void initControl() {
    control = new BaseBookRadioListWidgetControl();
  }

  @override
  void setControl() {
    super.setControl();
    control.buttonName = buttonName;
    control.buttonOnPressed = buttonOnPressed;
  }
}
