import 'package:flutter/material.dart';
import 'package:uni_online_shop/views/shared/appstyle.dart';

class CategoryBtn extends StatelessWidget {
  const CategoryBtn({
    super.key,
    this.onPress,
    required this.label,
    required this.buttonColor,
  });

  final void Function()? onPress;
  final Color buttonColor;
  final String label;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPress,
      child: Container(
        height: 40,
        width: MediaQuery.of(context).size.width * 0.24,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: buttonColor,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.all(Radius.circular(9)),
        ),
        child: Center(child: Text(label, style: appstyle(16, buttonColor, FontWeight.w600))),
      ),
    );
  }
}
