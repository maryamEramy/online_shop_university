import 'package:flutter/material.dart';
import '../../controllers/constant.dart';
import '../shared/roundedButton.dart';
import '../ui/login_page.dart';

class LogInButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const LogInButton({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return RoundedButton(
      title: 'LogIn',
      textColor: kPrimaryColor,
      color: kSecondaryColor,
      onPressed: onPressed ??
              () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          },
    );
  }
}
