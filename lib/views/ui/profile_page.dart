import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_online_shop/controllers/constant.dart';
import 'package:uni_online_shop/views/shared/body_ui.dart';
import 'package:uni_online_shop/views/shared/rounded_button.dart';
import 'package:uni_online_shop/views/ui/login_page.dart';
import '../../controllers/main_page_provider.dart';
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
                        Provider.of<MainPageNotifier>(context, listen: false)
                            .pageIndex = 2;
                      },
                      textColor: kWhiteColor,
                    ),
                    RoundedButton(
                      title: "Your Basket",
                      color: Colors.transparent,
                      onPressed: () {
                        Provider.of<MainPageNotifier>(context, listen: false)
                            .pageIndex = 3;
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
                      title: user != null ? "LogOUT" : "Registration",
                      color: Colors.transparent,
                      onPressed: () {
                        if (user != null) {
                          FirebaseAuth.instance.signOut();

                          Provider.of<MainPageNotifier>(context, listen: false)
                              .pageIndex = 4;
                          setState(() {

                          });
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => ProfilePage(),
                          //   ),
                          // );

                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        }
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
