import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_online_shop/views/ui/login_page.dart';
import '../../controllers/basket_provider.dart';
import '../../controllers/favorites_provider.dart';
import '../../controllers/user_provider.dart';
import '../../controllers/constant.dart';
import 'main_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    super.initState();
    _initializeAndNavigate();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);

    controller.reverse(from: 1);
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse(from: 1);
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });

    controller.addListener(() {
      debugPrint(animation.value);
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> _initializeAndNavigate() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final cartProvider = Provider.of<BasketProvider>(context, listen: false);
    final favProvider = Provider.of<FavoritesNotifier>(context, listen: false);

    try {
      await userProvider.loadUserData();
      await Future.delayed(const Duration(seconds: 2));

      if (userProvider.user != null) {
        final userId = userProvider.user!.uid;
        await cartProvider.setUserId(userId);
        await favProvider.setUserId(userId);

        Navigator.of(
          context,
        ).pushReplacement(MaterialPageRoute(builder: (_) => const MainPage()));
      } else {
        Navigator.of(
          context,
        ).pushReplacement(MaterialPageRoute(builder: (_) => const LoginPage()));
      }
    } catch (e) {
      debugPrint("SplashScreen error: $e");
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => const LoginPage()));
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
            SizedBox(
              width: animation.value * 200,
              height: animation.value * 200,
              child: Image.asset('assets/logo/splash_screen_image.png'),
            ),
          ],
        ),
      ),
    );
  }
}
