import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'rounded_text_field_widget.dart';

class EmailTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;

  const EmailTextFieldWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return RoundedTextFieldWidget(
      controller: controller,
      hintText: 'Enter your email',
      validator:
          (email) =>
              email != null && EmailValidator.validate(email)
                  ? null
                  : 'Please enter a valid email',
    );
  }
}
