import 'package:flutter/material.dart';
import 'package:lychee/common/style/YYStyle.dart';

class YYSeparatorWidget extends StatelessWidget {
  YYSeparatorWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10.5,right: 10.5),
      child: Container(
        height: 0.5,
        color: Color(YYColors.divider)
      ),
    );
  }
}