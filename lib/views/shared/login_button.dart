import 'package:flutter/material.dart';
import 'package:uni_online_shop/views/shared/roundedButton.dart';
import '../../controllers/constant.dart';
import '../ui/login_page.dart';

class LogInButton extends StatelessWidget {
  const LogInButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RoundedButton(
      title: 'LogIn',
      textColor: kPrimaryColor,
      color: kSecondaryColor,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      },
    );
  }
}
