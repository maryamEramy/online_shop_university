import 'package:flutter/material.dart';
import '../shared/appstyle.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('This is your add' , style: appstyle(40, Colors.black, FontWeight.bold),),
      ),
    );
  }
}
