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
    apiKey: 'AIzaSyB7XZo6QE1n81IWiuryi_2723OGWsUsiH8',
    appId: '1:678100484055:web:38d09f64b4167104635592',
    messagingSenderId: '678100484055',
    projectId: 'rjs-store-f9340',
    authDomain: 'rjs-store-f9340.firebaseapp.com',
    storageBucket: 'rjs-store-f9340.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB0LFCzIzYvdhbtuWgpNHg3OqrRZRxrUm8',
    appId: '1:678100484055:android:28c8f0eedceb131c635592',
    messagingSenderId: '678100484055',
    projectId: 'rjs-store-f9340',
    storageBucket: 'rjs-store-f9340.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBt_rUNP5yUHRh9UaweEmn9uqtNx-70m80',
    appId: '1:678100484055:ios:15d870f63c0e9ca2635592',
    messagingSenderId: '678100484055',
    projectId: 'rjs-store-f9340',
    storageBucket: 'rjs-store-f9340.firebasestorage.app',
    iosBundleId: 'com.example.rjsStore',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBt_rUNP5yUHRh9UaweEmn9uqtNx-70m80',
    appId: '1:678100484055:ios:15d870f63c0e9ca2635592',
    messagingSenderId: '678100484055',
    projectId: 'rjs-store-f9340',
    storageBucket: 'rjs-store-f9340.firebasestorage.app',
    iosBundleId: 'com.example.rjsStore',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyB7XZo6QE1n81IWiuryi_2723OGWsUsiH8',
    appId: '1:678100484055:web:06646b5725344558635592',
    messagingSenderId: '678100484055',
    projectId: 'rjs-store-f9340',
    authDomain: 'rjs-store-f9340.firebaseapp.com',
    storageBucket: 'rjs-store-f9340.firebasestorage.app',
  );
}
