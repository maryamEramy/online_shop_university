import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../controllers/image_path.dart';
import '../ui/d.dart';
import '../ui/registration_page.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({
    super.key,
    required this.user,
  });

  final User? user;

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    return SizedBox(
      child: user != null ?
      Column(
        children: [
          ListTile(
            leading: Container(
              width: 60,
              height: 60,
              // padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(2000),
                ),
              ),
              child: Center(
                child: Image(
                  image: AssetImage(ImagePath.womanProfile),
                  // fit: BoxFit.cover,
                ),
              ),
            ),
            title: Text(user.displayName ?? "no name",),
            subtitle: Text(
              "${user.email}",),
            trailing: IconButton( icon: Icon(Icons.logout),
              onPressed: ()async{
                await FirebaseAuth.instance.signOut();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(),
                  ),
                );
              },
              color: Colors.red, ),
          ),

        ],
      )
          : Column(
        children: [
          ListTile(
            leading: Container(
              width: 60,
              height: 60,
              // padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(2000),
                ),
              ),
              child: Center(
                child: Image(color: Colors.amber,
                  image: AssetImage(ImagePath.womanProfile,),
                  // fit: BoxFit.cover,
                ),
              ),
            ),
            title: Text("you have no account",),
            trailing: IconButton( icon: Icon(Icons.login),
              onPressed: ()async{
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Registration_page(),
                  ),
                );
              },
              color: Colors.red, ),
          ),
        ],
      ),
    );
  }
}
