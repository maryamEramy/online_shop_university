import 'package:flutter/material.dart';
import '../shared/appstyle.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),

      body: Center(
        child: Text('This is your add' , style: appstyle(40, Colors.black, FontWeight.bold),),
      ),
    );
  }
}
