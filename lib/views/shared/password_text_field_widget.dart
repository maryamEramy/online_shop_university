import 'package:flutter/material.dart';
import 'rounded_text_field_widget.dart';

class PasswordTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;

  const PasswordTextFieldWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return RoundedTextFieldWidget(
      controller: controller,
      hintText: 'Enter your password',
      isPasswordField: true,
      validator:
          (password) =>
              password != null && password.length > 5
                  ? null
                  : 'Password must be at least 6 characters',
    );
  }
}
