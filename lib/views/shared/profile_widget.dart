import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uni_online_shop/controllers/constant.dart';

import '../../controllers/image_path.dart';
import '../ui/profile_page.dart';
import '../ui/registration_page.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key, required this.user});

  final User? user;

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    return SizedBox(
      child:
          user != null
              ? ListTile(
                leading: Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(2000)),
                  ),
                  child: Center(
                    child: Image(
                      image: AssetImage(ImagePath.womanProfile),
                      // fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: Text(user.displayName ?? "no name" , style: kMainTextStyle,),
                subtitle: Text("${user.email}" , style: kSecondTextStyle,),
              )
              : ListTile(
                leading: Container(
                  width: 90,
                  height: 90,
                  // padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(2000)),
                  ),
                  child: Center(
                    child: Image(
                      color: kSecondaryColor,
                      image: AssetImage(ImagePath.womanProfile),
                      // fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: Text("you have no account" , style: kMainTextStyle,),
                trailing: IconButton(
                  icon: Icon(Icons.login),
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Registration_page(),
                      ),
                    );
                  },
                ),
              ),
    );
  }
}
