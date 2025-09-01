import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF353F54);
const kSecondaryColor = Color(0xFF37B6E9);
const kWhiteColor = Color(0xFFFFFFFF);



final kPageTitleTextStyle = TextStyle(
  fontFamily: "Poppins",
  color: kSecondaryColor,
  fontWeight: FontWeight.bold,
  fontSize: 28.0,
);
final kMainTextStyle = TextStyle(
  fontFamily: "Poppins",
  color: kWhiteColor,
  fontWeight: FontWeight.w700,
  fontSize: 18.0,
);




var kChatEmailColor = Colors.white54;
var kSenderBoxColor = Colors.red[900];
var kSendButtonColor = Colors.grey;
var kLoginColor = Colors.purple[200];
var kRegistrationColor = Colors.orangeAccent[200];

const bubbleRadius = 20.0;




const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    bottom: BorderSide(color: Colors.grey, width: 1),
    top: BorderSide(color: Colors.grey, width: 1),
  ),
  borderRadius: BorderRadius.all(Radius.circular(200)),
  color: Colors.black,
);

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
);
