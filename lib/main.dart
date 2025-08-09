import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_online_shop/conrollers/main_page_provider.dart';
import 'package:uni_online_shop/views/ui/main_page.dart';
import 'package:uni_online_shop/views/ui/splash_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MainPageNotifier()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: SplashScreen(),
      home: MainPage(),
    );
  }
}