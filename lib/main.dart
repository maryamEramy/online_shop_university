import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_online_shop/conrollers/main_page_provider.dart';
import 'package:uni_online_shop/conrollers/product_provider.dart';
import 'package:uni_online_shop/views/ui/main_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MainPageNotifier()),
        ChangeNotifierProvider(create: (context) => ProductNotifier()),
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