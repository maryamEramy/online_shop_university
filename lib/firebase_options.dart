import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDoH0xblXDq0dL5PtlSzT9yTPjwWUnXOFE',
    appId: '1:231319355081:web:15e2cf2d126899e4721718',
    messagingSenderId: '231319355081',
    projectId: 'online-shop-38b07',
    authDomain: 'online-shop-38b07.firebaseapp.com',
    storageBucket: 'online-shop-38b07.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA8IcSeaLTgxjmaGls1EY8wNWbjeIXUbME',
    appId: '1:231319355081:android:20864c39030b9b86721718',
    messagingSenderId: '231319355081',
    projectId: 'online-shop-38b07',
    storageBucket: 'online-shop-38b07.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAT1LEeYV-SsGF6xiPyTrlC-NkexTvFsOI',
    appId: '1:231319355081:ios:abe112ea537c933a721718',
    messagingSenderId: '231319355081',
    projectId: 'online-shop-38b07',
    storageBucket: 'online-shop-38b07.firebasestorage.app',
    iosBundleId: 'com.example.uniOnlineShop',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAT1LEeYV-SsGF6xiPyTrlC-NkexTvFsOI',
    appId: '1:231319355081:ios:abe112ea537c933a721718',
    messagingSenderId: '231319355081',
    projectId: 'online-shop-38b07',
    storageBucket: 'online-shop-38b07.firebasestorage.app',
    iosBundleId: 'com.example.uniOnlineShop',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDoH0xblXDq0dL5PtlSzT9yTPjwWUnXOFE',
    appId: '1:231319355081:web:a76a1c36c19cc52d721718',
    messagingSenderId: '231319355081',
    projectId: 'online-shop-38b07',
    authDomain: 'online-shop-38b07.firebaseapp.com',
    storageBucket: 'online-shop-38b07.firebasestorage.app',
  );
}
