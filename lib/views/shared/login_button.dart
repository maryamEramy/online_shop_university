import 'package:flutter/material.dart';
import '../../controllers/constant.dart';
import '../shared/rounded_button.dart';

class LogInButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool showSpinner;

  const LogInButton({super.key, this.onPressed, this.showSpinner = false});

  @override
  Widget build(BuildContext context) {
    return RoundedButton(
      title: 'LogIn',
      textColor: kPrimaryColor,
      color: kSecondaryColor,
      onPressed: onPressed ?? () {},
      child:
          showSpinner
              ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2.0,
                  color: kPrimaryColor,
                ),
              )
              : null,
    );
  }
}
