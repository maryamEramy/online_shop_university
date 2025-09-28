import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';
import 'basket_provider.dart';
import 'favorites_provider.dart';

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

  Future<UserModel> signupUser({
    required String name,
    required String email,
    required String password,
    required BasketProvider cartProvider,
    required FavoritesProvider favoritesNotifier,
  }) async {
    final userCredential = await AuthService().createUserWithEmailAndPassword(
      name: name,
      email: email,
      password: password,
      cartProvider: cartProvider,
      favoritesNotifier: favoritesNotifier,
    );

    final user = userCredential.user;
    if (user == null) throw Exception("User not found");

    // open Hive Boxes
    if (!Hive.isBoxOpen('cart_box_${user.uid}')) {
      await Hive.openBox('cart_box_${user.uid}');
    }
    if (!Hive.isBoxOpen('fav_box_${user.uid}')) {
      await Hive.openBox('fav_box_${user.uid}');
    }
    if (!Hive.isBoxOpen('userProfile${user.uid}')) {
      await Hive.openBox('userProfile${user.uid}');
    }

    final newUser = UserModel(uid: user.uid, name: name, email: email);

    // update Providers
    setUser(newUser);
    await cartProvider.setUserId(user.uid);
    await favoritesNotifier.setUserId(user.uid);

    return newUser;
  }

  Future<UserModel> loginUser({
    required String email,
    required String password,
    required BasketProvider cartProvider,
    required FavoritesProvider favoritesNotifier,
  }) async {
    final credential = await AuthService().signInUserWithEmailAndPassword(
      email: email,
      password: password,
      cartProvider: cartProvider,
      favoritesNotifier: favoritesNotifier,
    );

    final user = credential.user;
    if (user == null) throw Exception("User not found");

    final doc =
        await FirebaseFirestore.instance
            .collection("users")
            .doc(user.uid)
            .get();
    if (!doc.exists) throw Exception("User data not found");

    final loggedInUser = UserModel.fromMap(doc.data()!);

    // update providers
    setUser(loggedInUser);
    await cartProvider.setUserId(user.uid);
    await favoritesNotifier.setUserId(user.uid);

    return loggedInUser;
  }
}
