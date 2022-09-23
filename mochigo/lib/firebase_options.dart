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
    apiKey: 'AIzaSyDBSallXCDQk5d1PLMvlVIXThRk55iKBB0',
    appId: '1:336524639269:web:d11d949d9e4456929293cc',
    messagingSenderId: '336524639269',
    projectId: 'mochigo-88c59',
    authDomain: 'mochigo-88c59.firebaseapp.com',
    storageBucket: 'mochigo-88c59.appspot.com',
    measurementId: 'G-32WZ7F51XK',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCS6SJaU5PePV043U-HaeMYXXNuekwb61s',
    appId: '1:336524639269:android:04255d3f3b40618c9293cc',
    messagingSenderId: '336524639269',
    projectId: 'mochigo-88c59',
    storageBucket: 'mochigo-88c59.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAm5YavJFKgziJlJPP7KD803vu8XjYRzGY',
    appId: '1:336524639269:ios:1f3311082cf5a8e89293cc',
    messagingSenderId: '336524639269',
    projectId: 'mochigo-88c59',
    storageBucket: 'mochigo-88c59.appspot.com',
    iosClientId: '336524639269-2s62k5h5smiid5pjlugesre4rbteipbg.apps.googleusercontent.com',
    iosBundleId: 'com.example.mochigo',
  );
}