import 'package:flutter/material.dart';
import '../shared/appstyle.dart';

class CardPage extends StatefulWidget {
  const CardPage({super.key});

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('This is your card' , style: appstyle(40, Colors.black, FontWeight.bold),),
      ),
    );
  }
}
