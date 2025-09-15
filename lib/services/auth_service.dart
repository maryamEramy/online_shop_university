import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get getCurrentUser => _firebaseAuth.currentUser;
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<UserCredential> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      // ایجاد کاربر در Firebase Auth
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) {
        User user = userCredential.user!;

        // ذخیره اطلاعات کاربر در Firestore
        await _firestore.collection("users").doc(user.uid).set({
          "uid": user.uid,
          "email": user.email,
          "createdAt": FieldValue.serverTimestamp(),
          "cart": [],
          "favorites": [],
        });
      }

      return userCredential;

    } catch (e) {
      // مدیریت خطا و پرتاب مجدد آن
      print("Error in createUserWithEmailAndPassword: $e");
      rethrow;
    }
  }

  Future<UserCredential> signinUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      // ورود کاربر
      return await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print("Error in signinUserWithEmailAndPassword: $e");
      rethrow;
    }
  }

  Future<void> signOutUserWithEmailAndPassword() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      print("Error in signOutUserWithEmailAndPassword: $e");
      rethrow;
    }
  }

  // متد کمکی برای بررسی وجود کاربر
  Future<bool> userExists(String uid) async {
    try {
      final doc = await _firestore.collection("users").doc(uid).get();
      return doc.exists;
    } catch (e) {
      print("Error checking if user exists: $e");
      return false;
    }
  }

  // متد برای به روزرسانی پروفایل کاربر
  // در AuthService - متد updateUserProfile
  Future<void> updateUserProfile({
    required String uid,
    String? name,
  }) async {
    try {
      Map<String, dynamic> updateData = {};

      if (name != null) updateData['name'] = name;

      await _firestore.collection("users").doc(uid).update(updateData);

    } catch (e) {
      print("Error updating user profile: $e");
      rethrow;
    }
  }
}