
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _firebaseAuth =FirebaseAuth.instance;
  User ? get currentUser=>_firebaseAuth.currentUser;
  Stream <User?> get authStateChanges => _firebaseAuth.authStateChanges();
// connexion
  Future<void> loginWithEmailAndPassword(String email ,String password) async{
    await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }
  // deconnextion
  Future<void> lagout() async{
    await _firebaseAuth.signOut();
  }
  //Creation user avec Email-Password
  Future <void> createUserWithEmailAndPassword(String email,String password) async{
    await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
  }
}