import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:uni_online_shop/views/shared/text_field_widget.dart';

class EmailTextFieldWidget extends StatelessWidget {
  const EmailTextFieldWidget({
    super.key,
    required TextEditingController emailController,
  }) : _emailController = emailController;

  final TextEditingController _emailController;

  @override
  Widget build(BuildContext context) {
    return RoundedTextField(
      controller: _emailController,
      hintText: 'Enter your email',
      validator: (email) {
        return email != null && EmailValidator.validate(email)
            ? null
            : 'Please enter a valid email';
      },
    );
  }
}
