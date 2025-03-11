import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mediclic/pages/navigation.dart';
import 'package:mediclic/pages/onboarding.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final db = FirebaseFirestore.instance;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: auth.currentUser != null ? Navigation() : Onboarding(),
    );
  }
}
