import 'package:flutter/material.dart';

class TextBoxWidget extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  // final Color backgroundColor;
  final EdgeInsetsGeometry padding;
  // final double borderRadius;

  const TextBoxWidget({
    Key? key,
    required this.text,
    this.textStyle,
    // this.backgroundColor = Colors.white,
    this.padding = const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    // this.borderRadius = 12.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22.0),
      child: Container(
        width: double.infinity,
        padding: padding,
        // decoration: BoxDecoration(
        //   // color: backgroundColor,
        //   // borderRadius: BorderRadius.circular(borderRadius),
        //   boxShadow: [
        //     BoxShadow(
        //       color: Colors.black12,
        //       blurRadius: 4,
        //       offset: Offset(0, 2),
        //     ),
        //   ],
        // ),
        child: Text(
          text,
          style: textStyle,
        ),
      ),
    );
  }
}
