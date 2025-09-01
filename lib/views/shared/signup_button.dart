import 'package:flutter/material.dart';
import 'package:uni_online_shop/views/shared/roundedButton.dart';
import '../../controllers/constant.dart';
import '../ui/signup_page.dart';

class SignUpButton extends StatelessWidget {
  final VoidCallback? onPressed;
  const SignUpButton({
    super.key,
    this.onPressed,

  });

  @override
  Widget build(BuildContext context) {
    return RoundedButton(
      title: 'Signup',
      textColor: kSecondaryColor,
      color: kPrimaryColor,
      borderColor: kSecondaryColor,
      onPressed:  onPressed ??
              () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SignupPage()),
        );
      },
    );
  }
}
