import 'package:flutter/material.dart';
import 'package:uni_online_shop/views/shared/body_ui.dart';
import '../shared/signup_form.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return BodyUi(
      headerTitle: 'SignUp',
      showBackIcon: true,
      children: [
        SignupForm(
          formKey: formKey,
          nameController: nameController,
          emailController: emailController,
          passwordController: passwordController,
        ),
      ],
    );
  }
}
