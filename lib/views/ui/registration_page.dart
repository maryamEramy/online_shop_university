import 'package:flutter/material.dart';
import 'package:uni_online_shop/controllers/constant.dart';
import 'package:uni_online_shop/views/shared/divider_widget.dart';
import 'package:uni_online_shop/views/shared/text_box_widget.dart';
import '../shared/login_button.dart';
import '../shared/signup_button.dart';
import '../shared/text_title_widget.dart';

class Registration_page extends StatefulWidget {
  const Registration_page({super.key});
  @override
  State<Registration_page> createState() => _Registration_pageState();
}

class _Registration_pageState extends State<Registration_page>
    with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            TextTitleWidget(text: 'Registration'),
            DividerWidget(),
            TextBoxWidget(
              text:
                  'Hi! Welcome to our Shop!\nPlease choose one of the login methods provided below',
              textStyle: kMainTextStyle,
            ),
            SizedBox(height: 40),
            LogInButton(),
            SignUpButton(),
          ],
        ),
      ),
    );
  }
}


