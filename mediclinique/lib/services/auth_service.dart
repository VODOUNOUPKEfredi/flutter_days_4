// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class AuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   // Obtenir l'ID de l'utilisateur actuel
//   String? getCurrentUserId() {
//     return _auth.currentUser?.uid;
//   }

//   // Inscription d'une clinique
//   Future<UserCredential> registerClinic({
//     required String email,
//     required String password,
//     required String nomClinique,
//     required double latitude,
//     required double longitude,
//   }) async {
//     try {
//       // Créer l'utilisateur avec email et mot de passe
//       UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );

//       // Ajouter les informations supplémentaires dans Firestore
//       await _firestore.collection('cliniques').doc(userCredential.user!.uid).set({
//         'nomClinique': nomClinique,
//         'email': email,
//         'role': 'clinique',
//         'localisation': GeoPoint(latitude, longitude),
//         'dateCreation': FieldValue.serverTimestamp(),
//       });

//       return userCredential;
//     } catch (e) {
//       throw e;
//     }
//   }

//   // Inscription d'un docteur
//   Future<void> registerDoctor({
//     required String email,
//     required String password,
//     required String nom,
//     required String prenom,
//     required String specialite,
//     required int age,
//     required String cliniqueId,
//   }) async {
//     try {
//       // Créer l'utilisateur avec email et mot de passe
//       UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );

//       // Ajouter les informations supplémentaires dans Firestore
//       await _firestore.collection('docteurs').doc(userCredential.user!.uid).set({
//         'nom': nom,
//         'prenom': prenom,
//         'specialite': specialite,
//         'email': email,
//         'age': age,
//         'role': 'docteur',
//         'cliniqueId': cliniqueId,
//         'dateCreation': FieldValue.serverTimestamp(),
//       });

//       // Ajouter une référence du docteur dans la collection de la clinique
//       await _firestore.collection('cliniques').doc(cliniqueId)
//           .collection('docteurs').doc(userCredential.user!.uid).set({
//         'nom': nom,
//         'prenom': prenom,
//         'specialite': specialite,
//         'docteurId': userCredential.user!.uid,
//       });

//     } catch (e) {
//       throw e;
//     }
//   }

//   // Connexion avec email et mot de passe
//   Future<UserCredential> signInWithEmailAndPassword({
//     required String email,
//     required String password,
//   }) async {
//     try {
//       return await _auth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//     } catch (e) {
//       throw e;
//     }
//   }

//   // Déconnexion
//   Future<void> signOut() async {
//     try {
//       return await _auth.signOut();
//     } catch (e) {
//       throw e;
//     }
//   }

//   // Récupérer le rôle de l'utilisateur connecté
//   Future<String?> getUserRole() async {
//     try {
//       User? user = _auth.currentUser;
//       if (user != null) {
//         // Vérifier dans la collection cliniques
//         DocumentSnapshot docClinique = await _firestore.collection('cliniques').doc(user.uid).get();
//         if (docClinique.exists) {
//           return 'clinique';
//         }

//         // Vérifier dans la collection docteurs
//         DocumentSnapshot docDocteur = await _firestore.collection('docteurs').doc(user.uid).get();
//         if (docDocteur.exists) {
//           return 'docteur';
//         }
//       }
//       return null;
//     } catch (e) {
//       throw e;
//     }
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Méthode pour s'inscrire en tant que clinique
  Future<Map<String, dynamic>> registerClinic({
    required String email,
    required String password,
    required String nomClinique,
    required double latitude,
    required double longitude,
  }) async {
    try {
      // Créer l'utilisateur dans Firebase Auth
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      User? user = result.user;
      
      if (user != null) {
        // Stocker les informations supplémentaires dans Firestore
        await _firestore.collection('cliniques').doc(user.uid).set({
          'email': email,
          'nom': nomClinique,
          'latitude': latitude,
          'longitude': longitude,
          'role': 'clinique',
          'createdAt': FieldValue.serverTimestamp(),
        });
        
        // Mettre également le rôle dans la collection 'users' pour faciliter la récupération
        await _firestore.collection('users').doc(user.uid).set({
          'email': email,
          'role': 'clinique',
          'createdAt': FieldValue.serverTimestamp(),
        });
        
        return {
          'uid': user.uid,
          'email': email,
          'role': 'clinique',
          'nom': nomClinique,
        };
      } else {
        throw Exception("Erreur lors de la création du compte");
      }
    } on FirebaseAuthException catch (e) {
      // Gérer spécifiquement les erreurs de Firebase Auth
      String message;
      switch (e.code) {
        case 'email-already-in-use':
          message = "Cet email est déjà utilisé par un autre compte.";
          break;
        case 'invalid-email':
          message = "L'adresse email est mal formatée.";
          break;
        case 'weak-password':
          message = "Le mot de passe est trop faible.";
          break;
        default:
          message = "Erreur d'inscription: ${e.message}";
      }
      throw Exception(message);
    } catch (e) {
      throw Exception("Erreur d'inscription: $e");
    }
  }

  // Méthode pour se connecter
  Future<Map<String, dynamic>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      // Connecter l'utilisateur avec Firebase Auth
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      User? user = result.user;
      
      if (user != null) {
        try {
          // Récupérer les informations sur l'utilisateur, notamment son rôle
          DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();
          
          if (userDoc.exists) {
            Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
            
            return {
              'uid': user.uid,
              'email': user.email,
              'role': userData['role'] ?? 'unknown',
            };
          } else {
            // Si l'utilisateur n'existe pas dans Firestore, créer une entrée par défaut
            // Cela peut arriver si l'utilisateur a été créé directement dans Firebase Auth
            await _firestore.collection('users').doc(user.uid).set({
              'email': user.email,
              'role': 'patient', // Rôle par défaut
              'createdAt': FieldValue.serverTimestamp(),
            });
            
            return {
              'uid': user.uid,
              'email': user.email,
              'role': 'patient',
            };
          }
        } catch (firestoreError) {
          // En cas d'erreur avec Firestore, on retourne quand même les infos de base
          print("Erreur Firestore: $firestoreError");
          return {
            'uid': user.uid,
            'email': user.email,
            'role': 'unknown',
          };
        }
      } else {
        throw Exception("Erreur lors de la connexion");
      }
    } on FirebaseAuthException catch (e) {
      // Gérer spécifiquement les erreurs de Firebase Auth
      String message;
      switch (e.code) {
        case 'user-not-found':
          message = "Aucun utilisateur trouvé avec cet email.";
          break;
        case 'wrong-password':
          message = "Mot de passe incorrect.";
          break;
        case 'invalid-email':
          message = "Format d'email invalide.";
          break;
        case 'user-disabled':
          message = "Ce compte a été désactivé.";
          break;
        default:
          message = "Erreur de connexion: vérifiez vos identifiants.";
      }
      throw Exception(message);
    } catch (e) {
      throw Exception("Erreur de connexion: vérifiez vos identifiants.");
    }
  }

  // Méthode pour se déconnecter
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw Exception("Erreur lors de la déconnexion: $e");
    }
  }

  // Vérifier l'état d'authentification de l'utilisateur et récupérer son rôle
  Future<Map<String, dynamic>?> getCurrentUser() async {
    User? user = _auth.currentUser;
    
    if (user != null) {
      try {
        DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();
        
        if (userDoc.exists) {
          Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
          
          return {
            'uid': user.uid,
            'email': user.email,
            'role': userData['role'] ?? 'unknown',
          };
        } else {
          // Si l'utilisateur n'existe pas dans Firestore, créer une entrée par défaut
          await _firestore.collection('users').doc(user.uid).set({
            'email': user.email,
            'role': 'patient', // Rôle par défaut
            'createdAt': FieldValue.serverTimestamp(),
          });
          
          return {
            'uid': user.uid,
            'email': user.email,
            'role': 'patient',
          };
        }
      } catch (e) {
        print("Erreur lors de la récupération des données utilisateur: $e");
        // Retourner quand même les infos de base
        return {
          'uid': user.uid,
          'email': user.email,
          'role': 'unknown',
        };
      }
    }
    
    return null; // Aucun utilisateur connecté
  }
}