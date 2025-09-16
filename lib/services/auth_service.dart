import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get getCurrentUser => _firebaseAuth.currentUser;
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  // ✅ ثبت نام با ایمیل، پسورد و نام
  Future<UserCredential> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      // ایجاد کاربر در Firebase Auth
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) {
        User user = userCredential.user!;

        // ذخیره اطلاعات کامل کاربر در Firestore
        await _firestore.collection("users").doc(user.uid).set({
          "uid": user.uid,
          "name": name,
          "email": user.email,
          "createdAt": FieldValue.serverTimestamp(),
          "cart": [],
          "favorites": [],
        });
      }

      return userCredential;
    } catch (e) {
      print("Error in createUserWithEmailAndPassword: $e");
      rethrow;
    }
  }

  Future<UserCredential> signinUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
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
}
