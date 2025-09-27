import 'package:flutter/material.dart';
import '../../controllers/constant.dart';

class DividerWidget extends StatelessWidget {
  final Color color;
  final double thickness;
  final double indent;
  final double endIndent;

  const DividerWidget({
    super.key,
    this.color = kWhiteColor,
    this.thickness = 0.5,
    this.indent = 4.0,
    this.endIndent = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
      child: Divider(
        color: color,
        thickness: thickness,
        indent: indent,
        endIndent: endIndent,
      ),
    );
  }
}
