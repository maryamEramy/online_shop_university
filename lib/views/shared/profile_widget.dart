import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uni_online_shop/controllers/constant.dart';
import '../../controllers/image_path.dart';
class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key, required this.user});

  final User? user;

  @override
  Widget build(BuildContext context) {
    // از user پاس داده شده استفاده کنید
    final currentUser = user;

    return Row(
      children: [
        currentUser != null
            ? Row(
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(1000),
              ),
              child: Center(
                child: Image(image: AssetImage(ImagePath.womanProfile)),
              ),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(currentUser.displayName ?? "no name", style: kMainTextStyle),
                Text("${currentUser.email}", style: kSecondTextStyle),
              ],
            ),
          ],
        )
            : Row(
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(1000),
              ),
              child: Center(
                child: Image(
                  color: kSecondaryColor,
                  image: AssetImage(ImagePath.womanProfile),
                ),
              ),
            ),
            SizedBox(width: 10),
            Text("you have no account", style: kMainTextStyle),
          ],
        ),
      ],
    );
  }
}

// class ProfileWidget extends StatelessWidget {
//   const ProfileWidget({super.key, required this.user});
//
//   final User? user;
//
//   @override
//   Widget build(BuildContext context) {
//
//     final User? user = this.user; // بجای FirebaseAuth.instance.currentUser
//
//     // final User? user = FirebaseAuth.instance.currentUser;
//
//     return Row(
//       children: [
//         user != null
//             ? Row(
//               children: [
//                 Container(
//                   width: 90,
//                   height: 90,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(1000),
//                   ),
//                   child: Center(
//                     child: Image(image: AssetImage(ImagePath.womanProfile)),
//                   ),
//                 ),
//                 SizedBox(width: 10,),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(user.displayName ?? "no name", style: kMainTextStyle),
//                     Text("${user.email}", style: kSecondTextStyle),
//                   ],
//                 ),
//               ],
//             )
//             : Row(
//               children: [
//                 Container(
//                   width: 90,
//                   height: 90,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(1000),
//                   ),
//                   child: Center(
//                     child: Image(
//                       color: kSecondaryColor,
//                       image: AssetImage(ImagePath.womanProfile),
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 10,),
//                 Text("you have no account", style: kMainTextStyle),
//               ],
//             ),
//       ],
//     );
//   }
// }
