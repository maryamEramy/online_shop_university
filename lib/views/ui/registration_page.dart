
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uni_online_shop/views/ui/login_page.dart';
import 'package:uni_online_shop/views/ui/signup_page.dart';

import '../shared/roundedButton.dart';

class Registration_page extends StatefulWidget {
  static const String id = 'welcome_screen';

  const Registration_page({super.key});
  @override
  State<Registration_page> createState() => _Registration_pageState();
}

class _Registration_pageState extends State<Registration_page>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 40),
            RoundedButton(
              title: 'LogIn',
              color: Colors.purple[200]!,
              onPressed: () {
                Navigator.push(context,  MaterialPageRoute(builder: (context) => LoginPage()));
              },
            ),
            SizedBox(height: 8,),
            RoundedButton(
              color: Colors.orangeAccent[200]!,
              onPressed: () {
                Navigator.push(context,  MaterialPageRoute(builder: (context) => SignupPage()));
              },
              title: 'Signup',
            ),
          ],
        ),
      ),
    );
  }
}

