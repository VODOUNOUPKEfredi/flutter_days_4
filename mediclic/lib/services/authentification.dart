import 'package:mediclic/pages/navigation.dart';
import 'package:mediclic/pages/onboarding.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthServices {
  User? get isSignedIn => FirebaseAuth.instance.currentUser;
  Future<void> signup(
      {required String email,
      required String password,
      required String nom,
      required String prenom,
      required String date,
      String groupeSanguin = "",
      String allergies = "",
      required BuildContext context}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      await Future.delayed(const Duration(seconds: 1));

      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        "nom": nom,
        "prenom": prenom,
        'email': email,
        'date': date,
        'allergies': allergies,
        'groupeSanguin': groupeSanguin,
        'role': 'patient',
      });

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => const Navigation()));
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'weak-password') {
        message = 'Le mot de passe entré est faible.';
        const snackBar =
            SnackBar(content: Text('Le mot de passe entré est faible.'));

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else if (e.code == 'email-already-in-use') {
        message = 'Un compte existe déjà avec cet email.';
        const snackBar =
            SnackBar(content: Text('Un compte existe déjà avec cet email.'));
      }
    }
  }

  Future<void> signin(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => const Navigation()));
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'user-not-found') {
        message = 'Pas d\'utilisateur trouvé avec ce mail';
      } else if (e.code == 'wrong-password') {
        message = 'Mot de passe incorrect';
      }
    }
  }

  Future<void> signout({required BuildContext context}) async {
    await FirebaseAuth.instance.signOut();
    await Future.delayed(Duration(seconds: 1));
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => Onboarding()));
  }
}
