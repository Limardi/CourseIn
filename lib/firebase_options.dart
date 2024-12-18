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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for android - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCCUPVcKQUdS7KuPbdNe6CHFsJ8gJuQnkc',
    appId: '1:880057115840:web:f41bd576ed7ef4ce23b925',
    messagingSenderId: '880057115840',
    projectId: 'coursein-be127',
    authDomain: 'coursein-be127.firebaseapp.com',
    storageBucket: 'coursein-be127.appspot.com',
    measurementId: 'G-Z19MYQ84VQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA56yZkt-2H1FMRHA_-DiKa4P8CwF-OA8A',
    appId: '1:880057115840:android:4e718a1e2615834623b925',
    messagingSenderId: '880057115840',
    projectId: 'coursein-be127',
    storageBucket: 'coursein-be127.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDiDiZMHhlP2-QGf8SCR3jDObiQNw8iT8M',
    appId: '1:880057115840:ios:160c67f2777a937723b925',
    messagingSenderId: '880057115840',
    projectId: 'coursein-be127',
    storageBucket: 'coursein-be127.appspot.com',
    iosBundleId: 'com.example.projectSs',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDiDiZMHhlP2-QGf8SCR3jDObiQNw8iT8M',
    appId: '1:880057115840:ios:160c67f2777a937723b925',
    messagingSenderId: '880057115840',
    projectId: 'coursein-be127',
    storageBucket: 'coursein-be127.appspot.com',
    iosBundleId: 'com.example.projectSs',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCCUPVcKQUdS7KuPbdNe6CHFsJ8gJuQnkc',
    appId: '1:880057115840:web:6f9eea57b5f0130723b925',
    messagingSenderId: '880057115840',
    projectId: 'coursein-be127',
    authDomain: 'coursein-be127.firebaseapp.com',
    storageBucket: 'coursein-be127.appspot.com',
    measurementId: 'G-D4MYF5HTX8',
  );

}