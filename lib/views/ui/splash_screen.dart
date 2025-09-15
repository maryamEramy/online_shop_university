import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/user_provider.dart';
import '../../controllers/constant.dart';
import 'main_page.dart';
import 'registration_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _initializeAndNavigate();
  }

  Future<void> _initializeAndNavigate() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      // 1. لود کردن اطلاعات کاربر از Firestore
      await userProvider.loadUserData();

      // 2. تاخیر 3 ثانیه برای نمایش اسپلش
      await Future.delayed(const Duration(seconds: 3));

      // 3. هدایت به صفحه مناسب
      if (userProvider.user != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const MainPage()),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const Registration_page()),
        );
      }
    } catch (e) {
      debugPrint("SplashScreen error: $e");
      // در صورت خطا هم کاربر رو به صفحه ثبت‌نام هدایت کن
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const Registration_page()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo/splash_screen_image.png',
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
