import 'package:flutter/material.dart';
import 'package:uni_online_shop/views/shared/text_box_widget.dart';
import '../../controllers/constant.dart';

class RoundedTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;

  const RoundedTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextBoxWidget(text: hintText, textStyle: kRegularTextStyle,padding:  EdgeInsets.zero),
        SizedBox(height: 6,),
        TextFormField(
          controller: controller,
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style: kRegularTextStyle.copyWith(color: kPrimaryColor),
          decoration: InputDecoration(
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
