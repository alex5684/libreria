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
    apiKey: 'AIzaSyAiu8mr-KvW7tl7KtBzubOEGAL8KM7XhkE',
    appId: '1:640790572607:web:9cff632e67f75c84ff528a',
    messagingSenderId: '640790572607',
    projectId: 'libreria-galilei-2023',
    authDomain: 'libreria-galilei-2023.firebaseapp.com',
    databaseURL: 'https://libreria-galilei-2023-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'libreria-galilei-2023.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAbMG7EMnLVezsNj7NU9NYluVmJyDu666Y',
    appId: '1:640790572607:android:b215872925e9fc04ff528a',
    messagingSenderId: '640790572607',
    projectId: 'libreria-galilei-2023',
    databaseURL: 'https://libreria-galilei-2023-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'libreria-galilei-2023.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAucewyjAchGEfPfSKfFU0UkYpNCD1Fta8',
    appId: '1:640790572607:ios:2e9bca3803c0cb2cff528a',
    messagingSenderId: '640790572607',
    projectId: 'libreria-galilei-2023',
    databaseURL: 'https://libreria-galilei-2023-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'libreria-galilei-2023.appspot.com',
    iosClientId: '640790572607-f7bo445tmecraprrib9pk7s00sdqi59d.apps.googleusercontent.com',
    iosBundleId: 'com.itisgalilei.bookschange',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAucewyjAchGEfPfSKfFU0UkYpNCD1Fta8',
    appId: '1:640790572607:ios:2e9bca3803c0cb2cff528a',
    messagingSenderId: '640790572607',
    projectId: 'libreria-galilei-2023',
    databaseURL: 'https://libreria-galilei-2023-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'libreria-galilei-2023.appspot.com',
    iosClientId: '640790572607-f7bo445tmecraprrib9pk7s00sdqi59d.apps.googleusercontent.com',
    iosBundleId: 'com.itisgalilei.bookschange',
  );
}
