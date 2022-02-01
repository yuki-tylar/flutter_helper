import 'package:flutter/material.dart';

class TextBlock extends StatelessWidget {
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final TextStyle? style;
  final TextAlign align;
  final String text;
  final Matrix4? transform;

  const TextBlock(
    this.text, {
    Key? key,
    this.margin,
    this.padding,
    this.style,
    this.align = TextAlign.start,
    this.transform,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      transform: transform,
      margin: margin,
      padding: padding,
      child: Text(
        text,
        style: style,
        textAlign: align,
      ),
    );
  }
}
