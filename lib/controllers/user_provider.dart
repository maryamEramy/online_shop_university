import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/adapters.dart';
import '../models/user_model.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  Future<void> loadUserData() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      if (!Hive.isBoxOpen('cart_box_${currentUser.uid}')) {
        await Hive.openBox('cart_box_${currentUser.uid}');
      }
      if (!Hive.isBoxOpen('fav_box_${currentUser.uid}')) {
        await Hive.openBox('fav_box_${currentUser.uid}');
      }

      final doc =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(currentUser.uid)
              .get();

      if (doc.exists) {
        _user = UserModel.fromMap(doc.data()!);
      }

      notifyListeners();
    }
  }

  Future<void> saveProfileImage(String path) async {
    final box = Hive.box('userProfile');
    await box.put('profileImagePath', path);
  }

  Future<String?> getProfileImage() async {
    final box = Hive.box('userProfile');
    return box.get('profileImagePath');
  }

  void setUser(UserModel user) {
    _user = user;
    notifyListeners();
  }

  void clearUser() {
    _user = null;
    notifyListeners();
  }
}
