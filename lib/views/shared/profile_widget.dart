import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uni_online_shop/controllers/constant.dart';
import 'package:uni_online_shop/controllers/user_provider.dart';
import '../../controllers/image_path.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key, required this.user});

  final User? user;

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  File? _imageFile;
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      await UserProvider().saveProfileImage(pickedFile.path);
    }
  }

  @override
  void initState() {
    super.initState();
    UserProvider().getProfileImage().then((path) {
      if (path != null && File(path).existsSync()) {
        setState(() {
          _imageFile = File(path);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = widget.user;

    return Row(
      children: [
        currentUser != null
            ? Row(
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(1000),
                    ),
                    child: Center(
                      child:
                          _imageFile != null
                              ? ClipRRect(
                                borderRadius: BorderRadius.circular(1000),
                                child: Image.file(
                                  _imageFile!,
                                  width: 90,
                                  height: 90,
                                  fit: BoxFit.cover,
                                ),
                              )
                              : Image(
                                image: AssetImage(ImagePath.womanProfile),
                              ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currentUser.displayName ?? "no name",
                      style: kMainTextStyle,
                    ),
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
