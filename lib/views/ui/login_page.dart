import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:uni_online_shop/views/shared/login_button.dart';
import 'package:uni_online_shop/views/ui/main_page.dart';
import '../../controllers/cart_provider.dart';
import '../../controllers/constant.dart';
import '../../controllers/favorites_provider.dart';
import '../../controllers/user_provider.dart';
import '../../models/user_model.dart';
import '../../services/auth_service.dart';
import '../shared/divider_widget.dart';
import '../shared/email_text_field_widget.dart';
import '../shared/passwoed_text_field_widget.dart';
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 40),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 10,
                  child: GestureDetector(
                    child: Icon(Icons.arrow_back_ios, color: kSecondaryColor),
                    onTap: (){
                      Navigator.pop(context);
                    },
                  ),
                ),
                TextTitleWidget(text: 'Login'),
                SizedBox(width: 10),
              ],
            ),
            DividerWidget(),
            Form(
              key: _formKey,
              child: Column(
                children: [
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
            LogInButton(

              // login_page.dart - بخش onPressed دکمه Login
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  try {
                    setState(() {
                      errorOccurred = false;
                      showSpinner = true;
                    });

                    // تغییر این قسمت
                    // final credential = await AuthService().signinUserWithEmailAndPassword(
                    //   email: _emailController.text.trim(),
                    //   password: _passwordController.text.trim(),
                    // );
                    final credential = await AuthService().signinUserWithEmailAndPassword(
                      email: _emailController.text.trim(),
                      password: _passwordController.text.trim(),
                      cartProvider: Provider.of<CartProvider>(context, listen: false),
                      favoritesNotifier: Provider.of<FavoritesNotifier>(context, listen: false),
                    );


                    final user = credential.user;

                    if (user != null) {
                      // باز کردن باکس‌های مخصوص کاربر
                      await Hive.openBox('cart_box_${user.uid}');
                      await Hive.openBox('fav_box_${user.uid}');

                      // دریافت اطلاعات کاربر از Firestore
                      final doc = await FirebaseFirestore.instance
                          .collection("users")
                          .doc(user.uid)
                          .get();

                      if (doc.exists) {
                        final data = doc.data()!;
                        final loggedInUser = UserModel.fromMap(data);

                        final userProvider = Provider.of<UserProvider>(context, listen: false);
                        userProvider.setUser(loggedInUser);

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
                    }

                    setState(() {
                      showSpinner = false;
                    });
                  } catch (e) {
                    setState(() {
                      showSpinner = false;
                      errorOccurred = true;
                      // تصحیح این خط - احتمالاً خط 164
                      errorMessage = e.toString().contains(']')
                          ? (e.toString().split('] ').length > 1
                          ? e.toString().split('] ')[1]
                          : e.toString())
                          : e.toString();
                    });
                  }
                }
              },
            ),

          ],
        ),
      ),
    );
  }
}
