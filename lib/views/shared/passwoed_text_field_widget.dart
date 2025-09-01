import 'package:flutter/cupertino.dart';
import 'package:uni_online_shop/views/shared/text_field_widget.dart';

class PasswordTextFieldWidget extends StatelessWidget {
  const PasswordTextFieldWidget({
    super.key,
    required TextEditingController passwordController,
  }) : _passwordController = passwordController;

  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return RoundedTextField(
      controller: _passwordController,
      hintText: 'Enter your password',
      validator:(password) {
        return password != null && password.length > 5
            ? null
            : 'The password should be of 6 character at least';
      },
    );
  }
}
