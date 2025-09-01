import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uni_online_shop/controllers/constant.dart';
import 'package:uni_online_shop/views/shared/body_ui.dart';
import 'package:uni_online_shop/views/shared/roundedButton.dart';
import 'package:uni_online_shop/views/ui/cart_page.dart';
import 'package:uni_online_shop/views/ui/favorites_page.dart';
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
    return BodyUi(
      headerTitle: 'My Profile',
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              ProfileWidget(user: user),
              SizedBox(height: 90),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: kLightPrimaryColor,
                ),
                child: Column(
                  children: [
                    RoundedButton(
                      title: "Favorites",
                      color: Colors.transparent,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FavoritesPage(),
                          ),
                        );
                      },
                      textColor: kWhiteColor,
                    ),
                    RoundedButton(
                      title: "Your Basket",
                      color: Colors.transparent,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CartPage()),
                        );
                      },
                      textColor: kWhiteColor,
                    ),
                    RoundedButton(
                      title: "Questions",
                      color: Colors.transparent,
                      onPressed: () {},
                      textColor: kWhiteColor,
                    ),
                    RoundedButton(
                      title: "LogOUT",
                      color: Colors.transparent,
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfilePage(),
                          ),
                        );
                      },
                      textColor: kWhiteColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
