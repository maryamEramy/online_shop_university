import 'package:flutter/material.dart';
import 'package:uni_online_shop/views/shared/text_box_widget.dart';
import '../../controllers/constant.dart';

class RoundedTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  final bool? isPasswordField;

  const RoundedTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator,
    this.isPasswordField = false
  });

  @override
  State<RoundedTextField> createState() => _RoundedTextFieldState();
}

class _RoundedTextFieldState extends State<RoundedTextField> {

  bool obscureText = true;
  void togglePasswordVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextBoxWidget(text: widget.hintText, textStyle: kRegularTextStyle,padding:  EdgeInsets.zero),
        SizedBox(height: 6,),
        TextFormField(
          obscureText: widget.isPasswordField == true ? obscureText : false,
          controller: widget.controller,
          validator: widget.validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style: kRegularTextStyle.copyWith(color: kPrimaryColor),
          decoration: InputDecoration(

            suffixIcon: widget.isPasswordField == true ? IconButton(
                onPressed: (){
                  togglePasswordVisibility();
                },
                icon: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                )
            ) : null,
            filled: true,
            fillColor: kWhiteColor,

            contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),

            errorStyle: kErrorTextStyle.copyWith(height: 1.2),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: kWhiteColor, width: 1.0),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: kSecondaryColor, width: 2.0),
            ),

            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(color: kErrorColor, width: 1.5),
            ),

            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(color: kErrorColor, width: 2.0),
            ),
          ),
        ),
      ],
    );
  }
}
