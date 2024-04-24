import 'package:flutter/material.dart';
import 'package:todo/pages/Home.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(

  ));

  runApp(MaterialApp(
      theme: ThemeData(primaryColor: Colors.deepOrangeAccent), home: Home()));
}
