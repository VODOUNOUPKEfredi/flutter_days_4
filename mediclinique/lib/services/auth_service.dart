
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // 🔹 Récupérer l'ID de l'utilisateur actuellement connecté
  String? getCurrentUserId() {
    return _auth.currentUser?.uid;
  }

  // 🔹 Vérifier si l'utilisateur actuel est une clinique
  Future<bool> isClinic() async {
    String? uid = _auth.currentUser?.uid;
    if (uid != null) {
      DocumentSnapshot doc = await _firestore.collection('cliniques').doc(uid).get();
      return doc.exists; // Vérifie si l'utilisateur est une clinique
    }
    return false;
  }

  // 🔹 Inscription de l'admin (seul le premier inscrit)
  Future<String?> registerAdmin({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      // Vérification s'il y a déjà un admin
      QuerySnapshot adminQuery = await _firestore.collection('users').where('role', isEqualTo: 'admin').get();
      if (adminQuery.docs.isNotEmpty) {
        return "Un administrateur existe déjà. Un seul administrateur est autorisé.";
      }

      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'email': email,
          'fullName': fullName,
          'role': 'admin',
          'uid': user.uid,
        });
        return null;
      } else {
        return "Échec de l'inscription de l'admin, utilisateur introuvable.";
      }
    } catch (e) {
      print("Erreur d'inscription de l'admin : $e");
      return "Erreur lors de l'inscription de l'admin : ${e.toString()}";
    }
  }

  // 🔹 Inscription d'une clinique par l'admin
  Future<String?> registerClinic({
    required String email,
    required String password,
    required String nomClinique,
    required double latitude,
    required double longitude,
  }) async {
    try {
      // Vérifier si l'email est déjà utilisé
      QuerySnapshot emailCheck = await _firestore.collection('cliniques').where('email', isEqualTo: email).get();
      if (emailCheck.docs.isNotEmpty) {
        return "L'email est déjà utilisé par une clinique.";
      }

      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null) {
        await _firestore.collection('cliniques').doc(user.uid).set({
          'email': email,
          'nomClinique': nomClinique,
          'latitude': latitude,
          'longitude': longitude,
          'role': 'clinic',
          'uid': user.uid,
        });
        return null;
      } else {
        return "Échec de l'inscription de la clinique, utilisateur introuvable.";
      }
    } catch (e) {
      print("Erreur d'inscription de la clinique : $e");
      return "Erreur lors de l'inscription de la clinique : ${e.toString()}";
    }
  }

  // 🔹 Inscription d'un médecin par une clinique
  Future<String?> registerMedecin({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      bool isClinicUser = await isClinic();
      if (!isClinicUser) {
        return "Seules les cliniques peuvent inscrire des médecins.";
      }

      // Vérifier si l'email est déjà utilisé
      QuerySnapshot emailCheck = await _firestore.collection('users').where('email', isEqualTo: email).get();
      if (emailCheck.docs.isNotEmpty) {
        return "L'email est déjà utilisé par un autre utilisateur.";
      }

      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'email': email,
          'fullName': fullName,
          'role': 'medecin',
          'uid': user.uid,
        });
        return null;
      } else {
        return "Échec de l'inscription du médecin, utilisateur introuvable.";
      }
    } catch (e) {
      print("Erreur d'inscription du médecin : $e");
      return "Erreur lors de l'inscription du médecin : ${e.toString()}";
    }
  }

  // 🔹 Connexion avec email et mot de passe
  Future<String?> loginUser(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } catch (e) {
      print("Erreur de connexion : $e");
      return "Erreur de connexion : ${e.toString()}";
    }
  }

  // 🔹 Déconnexion
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // 🔹 Récupérer le rôle de l'utilisateur depuis Firestore
  Future<String?> getUserRole(String uid) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        return doc['role'] as String?;
      }
      return "Rôle non trouvé";
    } catch (e) {
      print("Erreur lors de la récupération du rôle : $e");
      return "Erreur lors de la récupération du rôle : ${e.toString()}";
    }
  }
}
