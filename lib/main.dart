import 'package:agriamuse/Screens/Phone.dart';
import 'package:agriamuse/Screens/Verify.dart';
import 'package:agriamuse/Screens/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  /*  QuerySnapshot ab = await FirebaseFirestore.instance.collection("user").get();
  print(ab.docs.toString()); */

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'phone',
    routes: {
      'phone': (context) => Phone(),
      'verify': (context) => Verify(),
      'home': (context) => MyHomePage()
    },
  ));
}
