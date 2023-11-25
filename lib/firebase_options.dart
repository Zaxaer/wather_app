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
    apiKey: 'AIzaSyCw8t1sm0C8zEJBnJsopPr_5brgaSz8d-I',
    appId: '1:384783753847:web:3c1fe0f27240fdc7a89c72',
    messagingSenderId: '384783753847',
    projectId: 'weather-9c856',
    authDomain: 'weather-9c856.firebaseapp.com',
    databaseURL: 'https://weather-9c856-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'weather-9c856.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAt1xcXxorXy28sERSYS6mnrFgTfIF9CFU',
    appId: '1:384783753847:android:f0643f94ac92f240a89c72',
    messagingSenderId: '384783753847',
    projectId: 'weather-9c856',
    databaseURL: 'https://weather-9c856-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'weather-9c856.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC_nItOMC6MkC8-ILEH4enBmhOuBJB-qec',
    appId: '1:384783753847:ios:8f14e7b73add0614a89c72',
    messagingSenderId: '384783753847',
    projectId: 'weather-9c856',
    databaseURL: 'https://weather-9c856-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'weather-9c856.appspot.com',
    iosBundleId: 'com.example.weatherApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC_nItOMC6MkC8-ILEH4enBmhOuBJB-qec',
    appId: '1:384783753847:ios:4fdd54c50a3b1e13a89c72',
    messagingSenderId: '384783753847',
    projectId: 'weather-9c856',
    databaseURL: 'https://weather-9c856-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'weather-9c856.appspot.com',
    iosBundleId: 'com.example.weatherApp.RunnerTests',
  );
}