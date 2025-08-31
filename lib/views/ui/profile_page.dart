import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uni_online_shop/controllers/image_path.dart';
import 'package:uni_online_shop/views/ui/registration_page.dart';
import 'package:uni_online_shop/views/ui/signup_page.dart';
import '../shared/appstyle.dart';
import '../shared/profile_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipPath(
              child: SizedBox(
                height: 600,
                child: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(16, 20, 0, 0),
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/logo/top_of_screen.png"),
                          alignment: Alignment.topCenter,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          'My Profile',
                          style: appstyle(36, Colors.black, FontWeight.bold),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(height: 90),
                        ProfileWidget(user: user)
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

