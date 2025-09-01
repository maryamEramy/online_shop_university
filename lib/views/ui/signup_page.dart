import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:uni_online_shop/views/shared/email_text_field_widget.dart';
import 'package:uni_online_shop/views/shared/passwoed_text_field_widget.dart';
import 'package:uni_online_shop/views/shared/signup_button.dart';
import 'package:uni_online_shop/views/ui/main_page.dart';
import '../../controllers/constant.dart';
import '../../services/auth_service.dart';
import '../shared/divider_widget.dart';
import '../shared/name_text_field_widget.dart';
import '../shared/roundedButton.dart';
import '../shared/text_field_widget.dart';
import '../shared/text_title_widget.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String errorMessage = '';
  bool errorOccurred = false, showSpinner = false;

  bool obscureText = true;
  void togglePasswordVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 40),
              TextTitleWidget(text: 'SignUp'),
              DividerWidget(),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    NameTextFieldWidget(nameController: _nameController),
                    SizedBox(height: 16),
                    EmailTextFieldWidget(emailController: _emailController),
                    SizedBox(height: 16),
                    PasswordTextFieldWidget(
                      passwordController: _passwordController,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Visibility(
                visible: errorOccurred,
                child: Text(
                  errorMessage,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.red, fontSize: 14),
                ),
              ),
              SizedBox(height: 16),
              SignUpButton(onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  try {
                    setState(() {
                      errorOccurred = false;
                      showSpinner = true;
                    });
                    await AuthService()
                        .createUserWithEmailAndPassword(
                      email: _emailController.text,
                      password: _passwordController.text,
                      senderName:
                      _nameController
                          .text,
                    )
                        .then((Value) {
                      if (mounted) {
                        Navigator.pop(
                          context,
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainPage(),
                          ),
                        );
                      }
                    });
                    setState(() {
                      showSpinner = false;
                    });
                  } catch (e) {
                    setState(() {
                      showSpinner = false;
                      errorOccurred = true;
                      errorMessage =
                      e.toString().contains(']')
                          ? e.toString().split('] ')[1]
                          : e.toString();
                    });
                  }
                }
              },),
            ],
          ),
        ),
      ),
    );
  }
}
