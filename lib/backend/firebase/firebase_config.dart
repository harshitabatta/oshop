import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyBJDAJgTB4cjMR6HjFdUetq-wFMgouYeSw",
            authDomain: "onlineshopping-ec5d0.firebaseapp.com",
            projectId: "onlineshopping-ec5d0",
            storageBucket: "onlineshopping-ec5d0.appspot.com",
            messagingSenderId: "720870968879",
            appId: "1:720870968879:web:77fdade78425e0e0bf80da"));
  } else {
    await Firebase.initializeApp();
  }
}
