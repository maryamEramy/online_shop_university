
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:uni_online_shop/views/ui/home_page.dart';
import 'package:uni_online_shop/views/ui/main_page.dart';
import '../../controllers/constant.dart';
import '../../services/auth_service.dart';
import '../shared/roundedButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  static const String id = 'login_screen';

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
      backgroundColor: Colors.black12,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              DefaultTextStyle(
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 45.0,
                  color: Colors.white,
                ),
                child: AnimatedTextKit(
                  totalRepeatCount: 1,
                  animatedTexts: [TypewriterAnimatedText('Log In....')],
                ),
              ),

              SizedBox(height: 48.0),
              Form(
                key: _formKey,
                child: Column(
                    children: [
                      TextFormField(
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Enter your email',
                          labelText: 'Email',
                        ),
                        controller: _emailController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (email) {
                          return email != null && EmailValidator.validate(email)
                              ? null
                              : 'Please enter a valid email';
                        },
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Enter your password',
                          labelText: 'Password',
                          suffixIcon: IconButton(
                            onPressed: () {
                              togglePasswordVisibility();
                            },
                            icon: Icon(
                              obscureText ? Icons.visibility_off : Icons.visibility,
                            ),
                          ),
                        ),
                        //pass security
                        obscureText: true,
                        controller: _passwordController,
                        //pass validation
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (password) {
                          return password != null && password.length > 5
                              ? null
                              : 'The password should be of 6 character at least';
                        },
                      ),
                    ]
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
              SizedBox(height: 24.0),
              RoundedButton(
                title: 'LogIn',
                color: Colors.purple[200]!,
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()));
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
