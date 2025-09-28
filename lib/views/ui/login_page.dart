import 'package:flutter/material.dart';
import 'package:uni_online_shop/views/shared/body_ui.dart';
import '../../controllers/constant.dart';
import '../shared/login_form.dart';
import '../shared/signup_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return BodyUi(
      headerTitle: 'Welcome to Nozama!',
      animatedText: true,
      children: [
        Expanded(
          child: LoginForm(
            formKey: formKey,
            emailController: emailController,
            passwordController: passwordController,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            children: [
              Text(
                "If you don't have account let's SignUp!",
                style: kRegularTextStyle,
              ),
              const SignUpButton(),
            ],
          ),
        ),
      ],
    );
  }
}
