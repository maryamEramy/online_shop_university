import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/basket_provider.dart';
import '../../controllers/favorites_provider.dart';
import '../../controllers/user_provider.dart';
import '../../controllers/constant.dart';
import '../shared/email_text_field_widget.dart';
import '../shared/password_text_field_widget.dart';
import '../shared/name_text_field_widget.dart';
import '../shared/signup_button.dart';
import '../ui/main_page.dart';

class SignupForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const SignupForm({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
  });

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  bool _showSpinner = false;
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: widget.formKey,
          child: Column(
            children: [
              NameTextFieldWidget(nameController: widget.nameController),
              const SizedBox(height: 16),
              EmailTextFieldWidget(controller: widget.emailController),
              const SizedBox(height: 16),
              PasswordTextFieldWidget(controller: widget.passwordController),
            ],
          ),
        ),
        if (_errorMessage != null) ...[
          const SizedBox(height: 8),
          Text(_errorMessage!, textAlign: TextAlign.center, style: kErrorTextStyle),
        ],
        const SizedBox(height: 16),
        SignUpButton(
          onPressed: () async {
            if (!widget.formKey.currentState!.validate()) return;

            setState(() {
              _showSpinner = true;
              _errorMessage = null;
            });

            try {
              final userProvider = Provider.of<UserProvider>(context, listen: false);
              final cartProvider = Provider.of<BasketProvider>(context, listen: false);
              final favProvider = Provider.of<FavoritesNotifier>(context, listen: false);

              await userProvider.signupUser(
                name: widget.nameController.text.trim(),
                email: widget.emailController.text.trim(),
                password: widget.passwordController.text.trim(),
                cartProvider: cartProvider,
                favoritesNotifier: favProvider,
              );

              if (!mounted) return;
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MainPage()));
            } catch (e) {
              if (!mounted) return;
              setState(() {
                _errorMessage = e.toString().contains(']')
                    ? (e.toString().split('] ').length > 1
                    ? e.toString().split('] ')[1]
                    : e.toString())
                    : e.toString();
              });
            } finally {
              if (!mounted) setState(() => _showSpinner = false);
            }
          },
          showSpinner: _showSpinner,

        ),
      ],
    );
  }
}
