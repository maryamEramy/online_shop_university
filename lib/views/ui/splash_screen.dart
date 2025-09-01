import 'package:flutter/material.dart';
import 'package:uni_online_shop/controllers/constant.dart';
import 'package:uni_online_shop/views/ui/registration_page.dart';
import 'dart:async';

import 'main_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // بعد از 3 ثانیه به صفحه اصلی می‌رویم
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const Registration_page()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: Image.asset(
          'assets/logo/splash_screen_image.png', // لوگوی خودت
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}
