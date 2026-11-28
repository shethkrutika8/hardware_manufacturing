// File generated for project1-3c90c
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
    apiKey: 'AIzaSyAyPrn5YVm7RNGNlsGKplWfKA2_-aO-KUg',
    appId: '1:976705814308:web:b0b043d4d64e69277fbdb1',
    messagingSenderId: '976705814308',
    projectId: 'project1-3c90c',
    authDomain: 'project1-3c90c.firebaseapp.com',
    storageBucket: 'project1-3c90c.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAyPrn5YVm7RNGNlsGKplWfKA2_-aO-KUg',
    appId: '1:976705814308:android:b0b043d4d64e69277fbdb1',
    messagingSenderId: '976705814308',
    projectId: 'project1-3c90c',
    storageBucket: 'project1-3c90c.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAyPrn5YVm7RNGNlsGKplWfKA2_-aO-KUg',
    appId: '1:976705814308:ios:b0b043d4d64e69277fbdb1',
    messagingSenderId: '976705814308',
    projectId: 'project1-3c90c',
    storageBucket: 'project1-3c90c.firebasestorage.app',
    iosBundleId: 'com.example.hardwareManufacturing',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAyPrn5YVm7RNGNlsGKplWfKA2_-aO-KUg',
    appId: '1:976705814308:ios:b0b043d4d64e69277fbdb1',
    messagingSenderId: '976705814308',
    projectId: 'project1-3c90c',
    storageBucket: 'project1-3c90c.firebasestorage.app',
    iosBundleId: 'com.example.hardwareManufacturing',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAyPrn5YVm7RNGNlsGKplWfKA2_-aO-KUg',
    appId: '1:976705814308:web:b0b043d4d64e69277fbdb1',
    messagingSenderId: '976705814308',
    projectId: 'project1-3c90c',
    authDomain: 'project1-3c90c.firebaseapp.com',
    storageBucket: 'project1-3c90c.firebasestorage.app',
  );
}
