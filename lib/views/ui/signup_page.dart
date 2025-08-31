import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:uni_online_shop/views/ui/main_page.dart';

import '../../controllers/constant.dart';
import '../../services/auth_service.dart';
import '../shared/roundedButton.dart';

class SignupPage extends StatefulWidget {
  static const String id = 'registration_screen';

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
      backgroundColor: Colors.black12,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: 100),
                DefaultTextStyle(
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 45.0,
                    color: Colors.white,
                  ),
                  child: AnimatedTextKit(
                    totalRepeatCount: 1,
                    animatedTexts: [TypewriterAnimatedText('Register....')],
                  ),
                ),
                SizedBox(height: 48.0),

                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Enter your name',
                          labelText: 'Name',
                        ),
                        controller: _nameController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (name) {
                          return name != null && name.isNotEmpty
                              ? null
                              : 'Please enter your name';
                        },
                      ),
                      SizedBox(height: 8),
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
                          labelText: 'password',
                          suffixIcon: IconButton(
                            onPressed: () {
                              togglePasswordVisibility();
                            },
                            icon: Icon(
                              obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.white, // <--- رنگ آیکون را تنظیم کنید
                            ),
                          ),
                        ),
                        controller: _passwordController,
                        obscureText: obscureText,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (password) {
                          return password != null && password.length > 5
                              ? null
                              : 'The password should be at of 6 character at least.';
                        },
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
                SizedBox(height: 24.0),
                RoundedButton(
                  title: 'Register',
                  color: Colors.orangeAccent[200]!,
                  onPressed: () async {
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
                          senderName: _nameController.text, // <--- از displayName استفاده کنید
                        )
                            .then((Value) {
                          if (mounted) { // <--- اضافه کردن mounted check
                            Navigator.pop(context); // ممکن است در صفحه welcome_screen باشید
                            Navigator.push(context,  MaterialPageRoute(builder: (context) => MainPage()));
                          }
                        });
                        setState(() {
                          showSpinner = false;
                        });
                      } catch (e) {
                        setState(() {
                          showSpinner = false;
                          errorOccurred = true;
                          errorMessage = e.toString().contains(']') ? e.toString().split('] ')[1] : e.toString();
                        });
                      }
                    }
                    print('*********************************************************${_nameController.text}');
                  },
                ),
                SizedBox(height: MediaQuery.of(context).viewInsets.bottom > 0 ?
                MediaQuery.of(context).viewInsets.bottom + 20 :
                20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}