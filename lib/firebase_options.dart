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
    apiKey: 'AIzaSyA6U4PI6CVTQe8AxbF--1zmfjyEphkBqrc',
    appId: '1:292939237316:web:a84ada78aaedfab2330691',
    messagingSenderId: '292939237316',
    projectId: 'recommendersaver',
    authDomain: 'recommendersaver.firebaseapp.com',
    storageBucket: 'recommendersaver.appspot.com',
    measurementId: 'G-9HW7X8YH0G',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC65Kw-jMjYJUi3N9q60nRZDCll3b1zRNM',
    appId: '1:292939237316:android:fc954ae37ec6f939330691',
    messagingSenderId: '292939237316',
    projectId: 'recommendersaver',
    storageBucket: 'recommendersaver.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBloemk9UIC9DzA2I4vjngfYLaDj3-LUq8',
    appId: '1:292939237316:ios:9fdffebe2af91366330691',
    messagingSenderId: '292939237316',
    projectId: 'recommendersaver',
    storageBucket: 'recommendersaver.appspot.com',
    iosBundleId: 'com.example.recommenderSaver',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBloemk9UIC9DzA2I4vjngfYLaDj3-LUq8',
    appId: '1:292939237316:ios:9fdffebe2af91366330691',
    messagingSenderId: '292939237316',
    projectId: 'recommendersaver',
    storageBucket: 'recommendersaver.appspot.com',
    iosBundleId: 'com.example.recommenderSaver',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyA6U4PI6CVTQe8AxbF--1zmfjyEphkBqrc',
    appId: '1:292939237316:web:9b3ca76efeaf75df330691',
    messagingSenderId: '292939237316',
    projectId: 'recommendersaver',
    authDomain: 'recommendersaver.firebaseapp.com',
    storageBucket: 'recommendersaver.appspot.com',
    measurementId: 'G-ZQXL3WGEYC',
  );
}
