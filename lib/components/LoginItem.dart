import 'package:flutter/material.dart';
import 'package:flutter_application/common/component_index.dart';

class LoginItem extends StatefulWidget {
  final IconData prefixIcon;
  final bool hasSuffixIcon;
  final String hintText;
  final TextEditingController controller;

  const LoginItem({
    Key key,
    this.prefixIcon,
    this.hasSuffixIcon = false,
    this.hintText,
    this.controller,
  }):super(key: key);

  @override
  _LoginItemState createState() => _LoginItemState();
}

class _LoginItemState extends State<LoginItem> {
  bool _obscureText;

 @override
 void initState() {
   super.initState();
   _obscureText = widget.hasSuffixIcon;
 }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          iconSize: 28,
          icon: Icon(
            widget.prefixIcon,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: (){},
        ),
        Gaps.hGap30,
        Expanded(
          child: TextField(
            obscureText: _obscureText, // 是否是密码框
            controller: widget.controller,
            style: TextStyle(color: Colours.gray_66, fontSize: 14),
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: TextStyle(color: Colours.gray_99, fontSize: 14),
              suffixIcon: widget.hasSuffixIcon
                ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    color: Colours.gray_66,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
                : null,
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colours.green_de)
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colours.green_de)
              ),
            ),
          ),
        ),
      ],
    );
  }
}