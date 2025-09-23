import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uni_online_shop/controllers/basket_provider.dart';
import 'package:uni_online_shop/controllers/favorites_provider.dart';

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
    required BasketProvider cartProvider,
    required FavoritesNotifier favoritesNotifier,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) {
        User user = userCredential.user!;

        // ✅ ست کردن displayName روی User
        await user.updateDisplayName(name);
        await user.reload(); // بروزرسانی اطلاعات کاربر بعد از تغییر displayName
        user = _firebaseAuth.currentUser!; // آپدیت متغیر user با اطلاعات جدید

        // ذخیره اطلاعات در Firestore
        await _firestore.collection("users").doc(user.uid).set({
          "uid": user.uid,
          "name": name,
          "email": user.email,
          "createdAt": FieldValue.serverTimestamp(),
          "cart": [],
          "favorites": [],
        });

        // ✅ ست کردن Box های Hive برای یوزر جدید
        await cartProvider.setUserId(user.uid);
        await favoritesNotifier.setUserId(user.uid);
      }

      return userCredential;
    } catch (e) {
      print("Error in createUserWithEmailAndPassword: $e");
      rethrow;
    }
  }

  // Future<UserCredential> createUserWithEmailAndPassword({
  //   required String email,
  //   required String password,
  //   required String name,
  //   required CartProvider cartProvider,
  //   required FavoritesNotifier favoritesNotifier,
  // }) async {
  //   try {
  //     UserCredential userCredential = await _firebaseAuth
  //         .createUserWithEmailAndPassword(email: email, password: password);
  //
  //     if (userCredential.user != null) {
  //       User user = userCredential.user!;
  //
  //       // ذخیره اطلاعات در Firestore
  //       await _firestore.collection("users").doc(user.uid).set({
  //         "uid": user.uid,
  //         "name": name,
  //         "email": user.email,
  //         "createdAt": FieldValue.serverTimestamp(),
  //         "cart": [],
  //         "favorites": [],
  //       });
  //
  //       // ✅ ست کردن Box های Hive برای یوزر جدید
  //       await cartProvider.setUserId(user.uid);
  //       await favoritesNotifier.setUserId(user.uid);
  //     }
  //
  //     return userCredential;
  //   } catch (e) {
  //     print("Error in createUserWithEmailAndPassword: $e");
  //     rethrow;
  //   }
  // }

  // ✅ ورود
  Future<UserCredential> signinUserWithEmailAndPassword({
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

        // ✅ ست کردن Box های Hive برای یوزر وارد شده
        await cartProvider.setUserId(uid);
        await favoritesNotifier.setUserId(uid);
      }

      return userCredential;
    } catch (e) {
      print("Error in signinUserWithEmailAndPassword: $e");
      rethrow;
    }
  }

  // خروج
  Future<void> signOutUserWithEmailAndPassword() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      print("Error in signOutUserWithEmailAndPassword: $e");
      rethrow;
    }
  }
}
