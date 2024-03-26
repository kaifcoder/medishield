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
    apiKey: 'AIzaSyAbF0Jln55nSFRE65JFsdDjBbff59tuRbE',
    appId: '1:86990247944:android:de6acbeb363d8d610e59bd',
    messagingSenderId: '86990247944',
    projectId: 'medishield-ecom',
    storageBucket: 'medishield-ecom.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCS1GxFQG-hOPDX40yf7qVJ8918YMMKm-s',
    appId: '1:86990247944:ios:fecfaaabb0add1860e59bd',
    messagingSenderId: '86990247944',
    projectId: 'medishield-ecom',
    storageBucket: 'medishield-ecom.appspot.com',
    androidClientId:
        '86990247944-0nk2tbdlq35nfhd00rpq7cg6r9tlqb6l.apps.googleusercontent.com',
    iosClientId:
        '86990247944-pc3l3nsgr391efp0mqdp2cjrtrf9i420.apps.googleusercontent.com',
    iosBundleId: 'com.example.medihealth',
  );
}
