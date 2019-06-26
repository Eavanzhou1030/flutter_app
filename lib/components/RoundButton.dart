import 'package:flutter/material.dart';
// import 'package:flutter_application/common/component_index.dart';

class RoundButton extends StatelessWidget {
  final double width;
  final double height;
  final EdgeInsetsGeometry margin;
  final double radius;
  final Color bgColor;
  final Color highlightColor;
  final Color splashColor;
  final Widget child;
  final String text;
  final TextStyle style;
  final VoidCallback onPressed;

  const RoundButton({
    Key key,
    this.width,
    this.height = 50,
    this.margin,
    this.radius,
    this.bgColor,
    this.highlightColor,
    this.splashColor,
    this.child,
    this.text,
    this.style,
    this.onPressed
  }):super(key:key);

  @override
  Widget build(BuildContext context) {
    Color _bgColor = bgColor ?? Theme.of(context).primaryColor;
    BorderRadius _borderRadius = BorderRadius.circular(radius ?? (height / 2));
    return Container(
      width: width,
      height: height,
      margin: margin,
      child: Material(
        borderRadius: _borderRadius,
        color: _bgColor,
        child: InkWell(
          borderRadius: _borderRadius,
          onTap: () => onPressed(),
          child: child ?? Center(
            child: Text(
              text,
              style: style ?? TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}