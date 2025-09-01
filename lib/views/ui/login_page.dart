import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:uni_online_shop/views/shared/login_button.dart';
import 'package:uni_online_shop/views/ui/home_page.dart';
import 'package:uni_online_shop/views/ui/main_page.dart';
import '../../controllers/constant.dart';
import '../../services/auth_service.dart';
import '../shared/divider_widget.dart';
import '../shared/email_text_field_widget.dart';
import '../shared/passwoed_text_field_widget.dart';
import '../shared/roundedButton.dart';
import '../shared/text_field_widget.dart';
import '../shared/text_title_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 40),
              TextTitleWidget(text: 'Login'),
              DividerWidget(),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    EmailTextFieldWidget(emailController: _emailController),
                    SizedBox(height: 16),
                    PasswordTextFieldWidget(passwordController: _passwordController)
                  ],
                ),
              ),
              SizedBox(height: 8),
              Visibility(
                visible: errorOccurred,
                child: Text(
                  errorMessage,
                  textAlign: TextAlign.center,
                  style: kErrorTextStyle,
                ),
              ),
              LogInButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      setState(() {
                        errorOccurred = false;
                        showSpinner = true;
                      });
                      await AuthService()
                          .signinUserWithEmailAndPassword(
                            email: _emailController.text,
                            password: _passwordController.text,
                          )
                          .then((Value) {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MainPage(),
                              ),
                            );
                          });
                      setState(() {
                        showSpinner = false;
                      });
                    } catch (e) {
                      setState(() {
                        showSpinner = false;
                        errorOccurred = true;
                        errorMessage = e.toString().split('] ')[1];
                      });
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


