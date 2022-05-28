// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
    apiKey: 'AIzaSyCm-4S3iPUPCwz0JPXFyvdhB4-YX6l7r8U',
    appId: '1:335758002689:web:592b4499de990bb9688e00',
    messagingSenderId: '335758002689',
    projectId: 'face-attenda',
    authDomain: 'face-attenda.firebaseapp.com',
    storageBucket: 'face-attenda.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBdpGPbIBHvFM8b8yEmxJCPgoypXcUu8RE',
    appId: '1:335758002689:android:87766899270240c5688e00',
    messagingSenderId: '335758002689',
    projectId: 'face-attenda',
    storageBucket: 'face-attenda.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAkOoJXhN6sk2Y1IRv4-Unb112lU47PGu8',
    appId: '1:335758002689:ios:d9206adbd75675c0688e00',
    messagingSenderId: '335758002689',
    projectId: 'face-attenda',
    storageBucket: 'face-attenda.appspot.com',
    iosClientId: '335758002689-kdv8fk92uld0ggilckdj0se27cfnlgpo.apps.googleusercontent.com',
    iosBundleId: 'com.example.faceAttendence',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAkOoJXhN6sk2Y1IRv4-Unb112lU47PGu8',
    appId: '1:335758002689:ios:d9206adbd75675c0688e00',
    messagingSenderId: '335758002689',
    projectId: 'face-attenda',
    storageBucket: 'face-attenda.appspot.com',
    iosClientId: '335758002689-kdv8fk92uld0ggilckdj0se27cfnlgpo.apps.googleusercontent.com',
    iosBundleId: 'com.example.faceAttendence',
  );
}