import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCUaLeem089ohCjCZAZfek6VL0ngCiOTnE',
    appId: '1:60006204020:android:792217e3bfae1a25ef4721',
    messagingSenderId: '60006204020',
    projectId: 'fir-messenger-75282',
    storageBucket: 'fir-messenger-75282.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCkq8vpJndB25bU6cOUpjbbe24QWWOwklw',
    appId: '1:60006204020:ios:ba150ece1be99d5cef4721',
    messagingSenderId: '60006204020',
    projectId: 'fir-messenger-75282',
    storageBucket: 'fir-messenger-75282.appspot.com',
    iosClientId: '60006204020-40hmrbcgi1d7as8mike962b7htcum2m6.apps.googleusercontent.com',
    iosBundleId: 'app.flutter.assigment5.firebaseMessenger',
  );
}
