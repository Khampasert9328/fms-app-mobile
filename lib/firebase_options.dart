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
    apiKey: 'AIzaSyAPGQTlLnkSRKZNFeX2kf5C9hIIJAxy7EY',
    appId: '1:847902402940:web:3dc47801d8fbb3e3e4dcf9',
    messagingSenderId: '847902402940',
    projectId: 'fb-aa-hr',
    authDomain: 'fb-aa-hr.firebaseapp.com',
    databaseURL: 'https://fb-aa-hr.firebaseio.com',
    storageBucket: 'fb-aa-hr.appspot.com',
    measurementId: 'G-H8J0V2NLKN',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDBoBVAhDsy8u_cu-FH7EeA596RZyTskXE',
    appId: '1:847902402940:android:878ba3cf3bf41d36e4dcf9',
    messagingSenderId: '847902402940',
    projectId: 'fb-aa-hr',
    databaseURL: 'https://fb-aa-hr.firebaseio.com',
    storageBucket: 'fb-aa-hr.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBoqwBFFi5WpkMRcvKt0V8xCgy1MV9dgtA',
    appId: '1:847902402940:ios:4089dd81448e5520e4dcf9',
    messagingSenderId: '847902402940',
    projectId: 'fb-aa-hr',
    databaseURL: 'https://fb-aa-hr.firebaseio.com',
    storageBucket: 'fb-aa-hr.appspot.com',
    iosClientId: '847902402940-078onfnm94h7kh64grehhnuvnleri8ee.apps.googleusercontent.com',
    iosBundleId: 'com.archineer.aamanagement',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBoqwBFFi5WpkMRcvKt0V8xCgy1MV9dgtA',
    appId: '1:847902402940:ios:4089dd81448e5520e4dcf9',
    messagingSenderId: '847902402940',
    projectId: 'fb-aa-hr',
    databaseURL: 'https://fb-aa-hr.firebaseio.com',
    storageBucket: 'fb-aa-hr.appspot.com',
    iosClientId: '847902402940-078onfnm94h7kh64grehhnuvnleri8ee.apps.googleusercontent.com',
    iosBundleId: 'com.archineer.aamanagement',
  );
}
