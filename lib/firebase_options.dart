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
    apiKey: 'AIzaSyBHr3sEVspEqxM8Sy9nQx_6Bo59Nu1eJBo',
    appId: '1:17167335214:web:7c87d1e996010ac4b684bf',
    messagingSenderId: '17167335214',
    projectId: 'tripminder-app',
    authDomain: 'tripminder-app.firebaseapp.com',
    storageBucket: 'tripminder-app.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBddXGzaYQBb9gi-D2RCqa7qrQ1xwvmDQI',
    appId: '1:17167335214:android:b2e01fff59c2e53cb684bf',
    messagingSenderId: '17167335214',
    projectId: 'tripminder-app',
    storageBucket: 'tripminder-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCPaUxSoK59FWLmDfJLE5TzdMIUnqam21E',
    appId: '1:17167335214:ios:1d8cd22462c3a9cab684bf',
    messagingSenderId: '17167335214',
    projectId: 'tripminder-app',
    storageBucket: 'tripminder-app.appspot.com',
    iosBundleId: 'com.example.tripminder',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCPaUxSoK59FWLmDfJLE5TzdMIUnqam21E',
    appId: '1:17167335214:ios:3c67740edf895756b684bf',
    messagingSenderId: '17167335214',
    projectId: 'tripminder-app',
    storageBucket: 'tripminder-app.appspot.com',
    iosBundleId: 'com.example.tripminder.RunnerTests',
  );
}