// =======================
// RoundedTextFieldWidget.dart
// =======================
import 'package:flutter/material.dart';
import '../../controllers/constant.dart';
import 'text_box_widget.dart';

class RoundedTextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  final bool isPasswordField;

  const RoundedTextFieldWidget({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator,
    this.isPasswordField = false,
  });

  @override
  State<RoundedTextFieldWidget> createState() => _RoundedTextFieldWidgetState();
}

class _RoundedTextFieldWidgetState extends State<RoundedTextFieldWidget> {
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() => _obscureText = !_obscureText);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextBoxWidget(text: widget.hintText, textStyle: kSecondTextStyle, padding: EdgeInsets.zero),
          const SizedBox(height: 6),
          TextFormField(
            controller: widget.controller,
            obscureText: widget.isPasswordField ? _obscureText : false,
            validator: widget.validator,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            style: kRegularTextStyle.copyWith(color: kPrimaryColor),
            decoration: InputDecoration(
              suffixIcon: widget.isPasswordField
                  ? IconButton(
                onPressed: _togglePasswordVisibility,
                icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
              )
                  : null,
              filled: true,
              fillColor: kWhiteColor,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              errorStyle: kErrorTextStyle.copyWith(height: 1.2),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: kWhiteColor, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: kSecondaryColor, width: 2),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: kErrorColor, width: 1.5),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: kErrorColor, width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}