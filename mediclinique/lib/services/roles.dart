
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// Enum pour définir les différents rôles d'utilisateurs
enum UserRole {
  user,    // Patient
  medecin,
  clinique
}

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  // Variable pour stocker le rôle de l'utilisateur actuel
  UserRole? userRole;
  
  // Méthode pour l'inscription d'un nouvel utilisateur
  Future<UserCredential> registerWithEmailAndPassword(
    String email,
    String password,
    UserRole role,
  ) async {
    try {
      // Créer l'utilisateur dans Firebase Authentication
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      // Sauvegarder les informations supplémentaires dans Firestore
      await _createUserInFirestore(userCredential.user!.uid, email, role);
      
      // Mettre à jour le rôle de l'utilisateur actuel
      userRole = role;
      
      return userCredential;
    } catch (e) {
      print('Erreur lors de l\'inscription: $e');
      rethrow; // Propager l'erreur pour la gérer dans l'UI
    }
  }
  
  // Méthode pour créer le document utilisateur dans Firestore
  Future<void> _createUserInFirestore(String uid, String email, UserRole role) async {
    try {
      // Données de base à stocker pour tous les utilisateurs
      Map<String, dynamic> userData = {
        'email': email,
        'role': role.toString().split('.').last, // Convertir l'enum en string
        'createdAt': FieldValue.serverTimestamp(),
        'lastLogin': FieldValue.serverTimestamp(),
      };
      
      // Ajouter des champs spécifiques selon le rôle
      switch (role) {
        case UserRole.medecin:
          userData['specialite'] = '';
          userData['disponible'] = true;
          userData['evaluation'] = 0.0;
          break;
        case UserRole.clinique:
          userData['adresse'] = '';
          userData['telephone'] = '';
          userData['services'] = [];
          break;
        case UserRole.user:
          userData['dateNaissance'] = null;
          userData['sexe'] = '';
          userData['historiqueMedical'] = [];
          break;
      }
      
      // Enregistrer dans la collection users
      await _firestore.collection('users').doc(uid).set(userData);
    } catch (e) {
      print('Erreur lors de la création du profil dans Firestore: $e');
      rethrow;
    }
  }
  
  // Méthode pour la connexion d'un utilisateur existant
  Future<UserCredential> signInWithEmailAndPassword(String email, String password) async {
    try {
      // Authentifier l'utilisateur
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      // Récupérer le rôle de l'utilisateur depuis Firestore
      await _fetchUserRole(userCredential.user!.uid);
      
      // Mettre à jour la date de dernière connexion
      await _firestore.collection('users').doc(userCredential.user!.uid).update({
        'lastLogin': FieldValue.serverTimestamp(),
      });
      
      return userCredential;
    } catch (e) {
      print('Erreur lors de la connexion: $e');
      rethrow;
    }
  }
  
  // Méthode pour récupérer le rôle de l'utilisateur
  Future<void> _fetchUserRole(String uid) async {
    try {
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(uid).get();
      
      if (userDoc.exists) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        String roleStr = userData['role'];
        
        // Convertir la string en enum UserRole
        switch (roleStr) {
          case 'user':
            userRole = UserRole.user;
            break;
          case 'medecin':
            userRole = UserRole.medecin;
            break;
          case 'clinique':
            userRole = UserRole.clinique;
            break;
          default:
            userRole = UserRole.user; // Par défaut
        }
      }
    } catch (e) {
      print('Erreur lors de la récupération du rôle: $e');
      rethrow;
    }
  }
  
  // Méthode pour la déconnexion
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      userRole = null;
    } catch (e) {
      print('Erreur lors de la déconnexion: $e');
      rethrow;
    }
  }
  
  // Vérifier si l'utilisateur est connecté et récupérer son rôle
  Future<UserRole?> getCurrentUserRole() async {
    User? user = _auth.currentUser;
    
    if (user != null) {
      await _fetchUserRole(user.uid);
      return userRole;
    }
    
    return null;
  }
  
  // Obtenir l'ID de l'utilisateur actuel
  String? getCurrentUserId() {
    return _auth.currentUser?.uid;
  }
  
  // Vérifier si l'utilisateur est connecté
  bool isUserLoggedIn() {
    return _auth.currentUser != null;
  }

  registerDoctor({required String email, required String password, required String nom, required String prenom, required String specialite, required int age, required String cliniqueId}) {}

  getUserRole() {}

  signIn(String trim, String text) {}
}

// Classe pour gérer la navigation basée sur le rôle
class RoleBasedNavigator {
  static void navigateBasedOnRole(BuildContext context, UserRole role) {
    switch (role) {
      case UserRole.user:
        Navigator.of(context).pushReplacementNamed('/user_home');
        break;
      case UserRole.medecin:
        Navigator.of(context).pushReplacementNamed('/medecin_home');
        break;
      case UserRole.clinique:
        Navigator.of(context).pushReplacementNamed('/clinique_home');
        break;
    }
  }
}

// Widget pour protéger les routes selon le rôle
class RoleBasedRouteGuard extends StatelessWidget {
  final UserRole requiredRole;
  final Widget child;
  final Widget fallbackRoute;

  const RoleBasedRouteGuard({
    Key? key,
    required this.requiredRole,
    required this.child,
    required this.fallbackRoute,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();
    
    return FutureBuilder<UserRole?>(
      future: authService.getCurrentUserRole(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        
        // Vérifier si l'utilisateur a le bon rôle
        if (snapshot.hasData && snapshot.data == requiredRole) {
          return child;
        } else {
          // Rediriger vers la route par défaut
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => fallbackRoute),
            );
          });
          
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}

// Widget d'initialisation pour vérifier l'état de l'authentification au démarrage
class InitializerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService _authService = AuthService();
    
    return FutureBuilder<UserRole?>(
      future: _authService.getCurrentUserRole(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        
        if (snapshot.hasData && snapshot.data != null) {
          // L'utilisateur est connecté, rediriger vers la bonne page d'accueil
          WidgetsBinding.instance.addPostFrameCallback((_) {
            RoleBasedNavigator.navigateBasedOnRole(context, snapshot.data!);
          });
        } else {
          // L'utilisateur n'est pas connecté, rediriger vers la page de connexion
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacementNamed('/login');
          });
        }
        
        // Afficher un écran de chargement pendant la redirection
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logo.png', // Assurez-vous d'avoir un logo dans vos assets
                  width: 120,
                  height: 120,
                ),
                SizedBox(height: 20),
                CircularProgressIndicator(),
                SizedBox(height: 20),
                Text('MediClinique', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        );
      },
    );
  }
}