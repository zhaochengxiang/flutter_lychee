import 'package:flutter/material.dart';
import 'package:lychee/common/style/YYStyle.dart';

/// 带图标的输入框
class YYInputWidget extends StatefulWidget {
  final bool obscureText;

  final String hintText;

  final Image icon;

  final ValueChanged<String> onChanged;

  final TextStyle textStyle;

  final TextEditingController controller;

  final TextInputType textInputType;

  YYInputWidget({Key key, this.hintText, this.icon, this.onChanged, this.textStyle, this.controller, this.obscureText = false, this.textInputType = TextInputType.text}) : super(key: key);

  @override
  _YYInputWidgetState createState() => new _YYInputWidgetState();
}

/// State for [YYInputWidget] widgets.
class _YYInputWidgetState extends State<YYInputWidget> {

  _YYInputWidgetState() : super();

  @override
  Widget build(BuildContext context) {
    return new TextField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      obscureText: widget.obscureText,
      keyboardType: widget.textInputType,
      cursorColor: Color(YYColors.primary),
      decoration: new InputDecoration(
        hintText: widget.hintText,
        icon: widget.icon == null ? null : widget.icon,
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
      ),
    );
  }
}
