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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyAM7c0WqqkWDwB7B7iygM3g07xHFsMV48Y',
    appId: '1:132947146602:web:840d991f49313b5dda1713',
    messagingSenderId: '132947146602',
    projectId: 'twitter-ggomdong',
    authDomain: 'twitter-ggomdong.firebaseapp.com',
    storageBucket: 'twitter-ggomdong.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDs8RvrNewZye_nJvcYVlZH93_M8dBU330',
    appId: '1:132947146602:android:e92524a4bf219fffda1713',
    messagingSenderId: '132947146602',
    projectId: 'twitter-ggomdong',
    storageBucket: 'twitter-ggomdong.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA9kA2FK8_4XsH3rN7wPtV_odcYia0WGiE',
    appId: '1:132947146602:ios:26966975fd3c5445da1713',
    messagingSenderId: '132947146602',
    projectId: 'twitter-ggomdong',
    storageBucket: 'twitter-ggomdong.firebasestorage.app',
    iosBundleId: 'com.example.twitter',
  );

}