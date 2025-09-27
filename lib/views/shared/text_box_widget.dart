import 'package:flutter/material.dart';

class TextBoxWidget extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry padding;

  const TextBoxWidget({
    super.key,
    required this.text,
    this.textStyle,
    this.padding = const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22.0),
      child: Container(
        width: double.infinity,
        padding: padding,
        child: Text(text, style: textStyle),
      ),
    );
  }
}
