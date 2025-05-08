import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyCZu1AM33gerWXhBezFPzyDVk9nHOiC3UM",
            authDomain: "egzaminy-zawodowe-uy5xnx.firebaseapp.com",
            projectId: "egzaminy-zawodowe-uy5xnx",
            storageBucket: "egzaminy-zawodowe-uy5xnx.appspot.com",
            messagingSenderId: "560132235127",
            appId: "1:560132235127:web:11850a603472310877cb72"));
  } else {
    await Firebase.initializeApp();
  }
}
