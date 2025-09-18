import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:uni_online_shop/views/shared/email_text_field_widget.dart';
import 'package:uni_online_shop/views/shared/passwoed_text_field_widget.dart';
import 'package:uni_online_shop/views/shared/signup_button.dart';
import 'package:uni_online_shop/views/ui/main_page.dart';
import '../../controllers/cart_provider.dart';
import '../../controllers/constant.dart';
import '../../controllers/favorites_provider.dart';
import '../../controllers/user_provider.dart';
import '../../models/user_model.dart';
import '../../services/auth_service.dart';
import '../shared/divider_widget.dart';
import '../shared/name_text_field_widget.dart';
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

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 10,
                    child: GestureDetector(
                      child: Icon(Icons.arrow_back_ios, color: kSecondaryColor),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  TextTitleWidget(text: 'SignUp'),
                  SizedBox(width: 10),
                ],
              ),
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
                  style: kErrorTextStyle,
                ),
              ),
              SizedBox(height: 16),
              Align(
                alignment: Alignment.bottomCenter,
                child: SignUpButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        setState(() {
                          errorOccurred = false;
                          showSpinner = true;
                        });
                        // ثبت نام با Email/Password و Name + ست کردن provider ها
                        final userCredential = await AuthService().createUserWithEmailAndPassword(
                          email: _emailController.text.trim(),
                          password: _passwordController.text.trim(),
                          name: _nameController.text.trim(),
                          cartProvider: Provider.of<CartProvider>(context, listen: false),
                          favoritesNotifier: Provider.of<FavoritesNotifier>(context, listen: false),
                        );

                        final user = userCredential.user;
                        if (user != null) {
                          // ✅ باز کردن باکس‌های کاربر (اگر باز نبود)
                          if(!Hive.isBoxOpen('cart_box_${user.uid}')){
                            await Hive.openBox('cart_box_${user.uid}');
                          }
                          if(!Hive.isBoxOpen('fav_box_${user.uid}')){
                            await Hive.openBox('fav_box_${user.uid}');
                          }

                          // ✅ ست کردن provider ها
                          final userProvider = Provider.of<UserProvider>(context, listen: false);
                          final newUser = UserModel(
                            uid: user.uid,
                            name: _nameController.text.trim(),
                            email: _emailController.text.trim(),
                          );
                          userProvider.setUser(newUser);

                          final cartProvider = Provider.of<CartProvider>(context, listen: false);
                          await cartProvider.setUserId(user.uid);

                          final favProvider = Provider.of<FavoritesNotifier>(context, listen: false);
                          await favProvider.setUserId(user.uid);

                          if (mounted) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => MainPage()),
                            );
                          }
                        }

                        setState(() {
                          showSpinner = false;
                        });
                      } catch (e) {
                        setState(() {
                          showSpinner = false;
                          errorOccurred = true;
                          errorMessage = e.toString().contains(']')
                              ? (e.toString().split('] ').length > 1 ? e.toString().split('] ')[1] : e.toString())
                              : e.toString();
                        });
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
