// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
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
    apiKey: 'AIzaSyBmLT8VyIbLpjCxepcg1J_o-QNuSVP651E',
    appId: '1:992644870393:web:a2c966b98c440fec2e7228',
    messagingSenderId: '992644870393',
    projectId: 'advfluttereaxm',
    authDomain: 'advfluttereaxm.firebaseapp.com',
    storageBucket: 'advfluttereaxm.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAqfxQJ8OklWWxNZvb58QA7JBodQgvHwn0',
    appId: '1:992644870393:android:7d42e833d40740252e7228',
    messagingSenderId: '992644870393',
    projectId: 'advfluttereaxm',
    storageBucket: 'advfluttereaxm.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD1Pa1C5qBJ3Kcl-ifTwUgf_aaXuJhN_Us',
    appId: '1:992644870393:ios:1110695fe8e9f6b62e7228',
    messagingSenderId: '992644870393',
    projectId: 'advfluttereaxm',
    storageBucket: 'advfluttereaxm.firebasestorage.app',
    iosBundleId: 'com.example.advflutterexam',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD1Pa1C5qBJ3Kcl-ifTwUgf_aaXuJhN_Us',
    appId: '1:992644870393:ios:1110695fe8e9f6b62e7228',
    messagingSenderId: '992644870393',
    projectId: 'advfluttereaxm',
    storageBucket: 'advfluttereaxm.firebasestorage.app',
    iosBundleId: 'com.example.advflutterexam',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBmLT8VyIbLpjCxepcg1J_o-QNuSVP651E',
    appId: '1:992644870393:web:899316e06e4718122e7228',
    messagingSenderId: '992644870393',
    projectId: 'advfluttereaxm',
    authDomain: 'advfluttereaxm.firebaseapp.com',
    storageBucket: 'advfluttereaxm.firebasestorage.app',
  );
}
