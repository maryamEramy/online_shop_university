import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:uni_online_shop/controllers/basket_provider.dart';
import 'package:uni_online_shop/controllers/favorites_provider.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get getCurrentUser => _firebaseAuth.currentUser;
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<UserCredential> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required BasketProvider cartProvider,
    required FavoritesNotifier favoritesNotifier,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) {
        User user = userCredential.user!;

        await user.updateDisplayName(name);
        await user.reload();
        user = _firebaseAuth.currentUser!;

        await _firestore.collection("users").doc(user.uid).set({
          "uid": user.uid,
          "name": name,
          "email": user.email,
          "createdAt": FieldValue.serverTimestamp(),
          "cart": [],
          "favorites": [],
        });

        await cartProvider.setUserId(user.uid);
        await favoritesNotifier.setUserId(user.uid);
      }

      return userCredential;
    } catch (e) {
      debugPrint("Error in createUserWithEmailAndPassword: $e");
      rethrow;
    }
  }

  Future<UserCredential> signInUserWithEmailAndPassword({
    required String email,
    required String password,
    required BasketProvider cartProvider,
    required FavoritesNotifier favoritesNotifier,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) {
        final uid = userCredential.user!.uid;

        await cartProvider.setUserId(uid);
        await favoritesNotifier.setUserId(uid);
      }

      return userCredential;
    } catch (e) {
      debugPrint("Error in signingUserWithEmailAndPassword: $e");
      rethrow;
    }
  }

  Future<void> signOutUserWithEmailAndPassword() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      debugPrint("Error in signOutUserWithEmailAndPassword: $e");
      rethrow;
    }
  }
}
