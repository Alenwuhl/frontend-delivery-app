import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    } else {
      return android;
    }
  }
}

//For android
const FirebaseOptions android = FirebaseOptions(
  apiKey: "AIzaSyC3J_tM1CTOSlgqp6VrywZIygVNPp2Bldw",
  appId: "1:74669897934:android:b49c8ccd1bdce92463b89f",
  messagingSenderId: "74669897934",
  projectId: "futuristic-delivery-app",
  storageBucket: "futuristic-delivery-app.appspot.com",
  authDomain: "futuristic-delivery-app.firebaseapp.com",
);

//For web app
const FirebaseOptions web = FirebaseOptions(
    apiKey: "AIzaSyD1K_oU64yvbCQerlkeW02JOA_8dbKMuNk",
    authDomain: "futuristic-delivery-app.firebaseapp.com",
    projectId: "futuristic-delivery-app",
    storageBucket: "futuristic-delivery-app.appspot.com",
    messagingSenderId: "74669897934",
    appId: "1:74669897934:web:61c3207228ffeb8e63b89f",
);
