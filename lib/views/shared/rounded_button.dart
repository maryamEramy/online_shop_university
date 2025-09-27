import 'package:flutter/material.dart';
import '../../controllers/constant.dart';

class RoundedButton extends StatelessWidget {
  final Color color;
  final Color textColor;
  final String title;
  final VoidCallback onPressed;
  final double borderRadius;
  final Color borderColor;

  const RoundedButton({
    super.key,
    required this.title,
    required this.color,
    required this.textColor,
    required this.onPressed,
    this.borderRadius = 12.0,
    this.borderColor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 12.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: borderColor),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(borderRadius),
            onTap: onPressed,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14.0),
              child: Center(
                child: Text(
                  title,
                  style: kMainTextStyle.copyWith(color: textColor),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
