import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_online_shop/views/shared/password_text_field_widget.dart';
import '../../controllers/basket_provider.dart';
import '../../controllers/constant.dart';
import '../../controllers/favorites_provider.dart';
import '../../controllers/main_page_provider.dart';
import '../../controllers/user_provider.dart';
import '../ui/main_page.dart';
import 'email_text_field_widget.dart';
import 'login_button.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _showSpinner = false;
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          EmailTextFieldWidget(controller: widget.emailController),
          const SizedBox(height: 16),
          PasswordTextFieldWidget(controller: widget.passwordController),
          const SizedBox(height: 16),
          if (_errorMessage != null) ...[
            const SizedBox(height: 8),
            Text(_errorMessage!, textAlign: TextAlign.center, style: kErrorTextStyle),
          ],
          const SizedBox(height: 16),

          LogInButton(
            onPressed: () async {
              setState(() {
                _showSpinner = true;
                _errorMessage = null;
              });

              try {
                final userProvider = Provider.of<UserProvider>(context, listen: false);
                final cartProvider = Provider.of<BasketProvider>(context, listen: false);
                final favProvider = Provider.of<FavoritesNotifier>(context, listen: false);

                await userProvider.loginUser(
                  email: widget.emailController.text.trim(),
                  password: widget.passwordController.text.trim(),
                  cartProvider: cartProvider,
                  favoritesNotifier: favProvider,
                );

                if (!mounted) return;
                Provider.of<MainPageNotifier>(context, listen: false)
                    .pageIndex = 0;
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MainPage()));
              } catch (e) {
                if (!mounted) return;
                setState(() {
                  _errorMessage = e.toString().contains(']')
                      ? (e.toString().split('] ').length > 1 ? e.toString().split('] ')[1] : e.toString())
                      : e.toString();
                });
              } finally {
                if (!mounted) setState(() => _showSpinner = false);
              }
            },
            showSpinner: _showSpinner,
          )

        ],
      ),
    );
  }
}
