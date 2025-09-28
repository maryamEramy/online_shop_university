import 'package:flutter/material.dart';
import 'package:uni_online_shop/views/shared/rounded_button.dart';
import '../../controllers/constant.dart';
import '../ui/signup_page.dart';

class SignUpButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool showSpinner;

  const SignUpButton({super.key, this.onPressed, this.showSpinner = false});

  @override
  Widget build(BuildContext context) {
    return RoundedButton(
      title: 'Signup',
      textColor: kSecondaryColor,
      color: kPrimaryColor,
      borderColor: kSecondaryColor,
      onPressed:
          onPressed ??
          () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignupPage()),
            );
          },
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
