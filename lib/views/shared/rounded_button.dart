import 'package:flutter/material.dart';
import '../../controllers/constant.dart';

class RoundedButton extends StatelessWidget {
  final Color? color;
  final Color textColor;
  final String? title;
  final Widget? child;
  final VoidCallback onPressed;
  final double borderRadius;
  final Color borderColor;
  final EdgeInsetsGeometry outSidePadding;
  final EdgeInsetsGeometry inSidePadding;
  final double? width;

  const RoundedButton({
    super.key,
    this.title,
    this.color = kPrimaryColor,
    this.textColor = kLightSecondaryColor,
    required this.onPressed,
    this.child,
    this.borderRadius = 12.0,
    this.borderColor = Colors.transparent,
    this.outSidePadding = const EdgeInsets.symmetric(horizontal: 22.0, vertical: 12.0),
    this.inSidePadding = const EdgeInsets.symmetric(vertical: 14.0 , horizontal: 14.0),
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: outSidePadding,
      child: Container(
        width: width ?? double.infinity,
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
              padding: inSidePadding,
              child: Center(
                child: child ??
                    (title != null
                        ? Text(
                      title!,
                      style: kMainTextStyle.copyWith(color: textColor),
                      textAlign: TextAlign.center,
                    )
                        : const SizedBox.shrink()),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

