
// // // import 'package:firebase_auth/firebase_auth.dart';
// // // import 'package:cloud_firestore/cloud_firestore.dart';

// // // class AuthService {
// // //   final FirebaseAuth _auth = FirebaseAuth.instance;
// // //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// // //   // Méthode pour s'inscrire en tant que clinique
// // //   Future<Map<String, dynamic>> registerClinic({
// // //     required String email,
// // //     required String password,
// // //     required String nomClinique,
// // //     required double latitude,
// // //     required double longitude,
// // //   }) async {
// // //     try {
// // //       // Créer l'utilisateur dans Firebase Auth
// // //       UserCredential result = await _auth.createUserWithEmailAndPassword(
// // //         email: email,
// // //         password: password,
// // //       );
      
// // //       User? user = result.user;
      
// // //       if (user != null) {
// // //         // Stocker les informations supplémentaires dans Firestore
// // //         await _firestore.collection('cliniques').doc(user.uid).set({
// // //           'email': email,
// // //           'nom': nomClinique,
// // //           'latitude': latitude,
// // //           'longitude': longitude,
// // //           'role': 'clinique',
// // //           'createdAt': FieldValue.serverTimestamp(),
// // //         });
        
// // //         // Mettre également le rôle dans la collection 'users' pour faciliter la récupération
// // //         await _firestore.collection('users').doc(user.uid).set({
// // //           'email': email,
// // //           'role': 'clinique',
// // //           'createdAt': FieldValue.serverTimestamp(),
// // //         });
        
// // //         return {
// // //           'uid': user.uid,
// // //           'email': email,
// // //           'role': 'clinique',
// // //           'nom': nomClinique,
// // //         };
// // //       } else {
// // //         throw Exception("Erreur lors de la création du compte");
// // //       }
// // //     } on FirebaseAuthException catch (e) {
// // //       // Gérer spécifiquement les erreurs de Firebase Auth
// // //       String message;
// // //       switch (e.code) {
// // //         case 'email-already-in-use':
// // //           message = "Cet email est déjà utilisé par un autre compte.";
// // //           break;
// // //         case 'invalid-email':
// // //           message = "L'adresse email est mal formatée.";
// // //           break;
// // //         case 'weak-password':
// // //           message = "Le mot de passe est trop faible.";
// // //           break;
// // //         default:
// // //           message = "Erreur d'inscription: ${e.message}";
// // //       }
// // //       throw Exception(message);
// // //     } catch (e) {
// // //       throw Exception("Erreur d'inscription: $e");
// // //     }
// // //   }

// // //   // Méthode pour se connecter
// // //   Future<Map<String, dynamic>> signIn({
// // //     required String email,
// // //     required String password,
// // //   }) async {
// // //     try {
// // //       // Connecter l'utilisateur avec Firebase Auth
// // //       UserCredential result = await _auth.signInWithEmailAndPassword(
// // //         email: email,
// // //         password: password,
// // //       );
      
// // //       User? user = result.user;
      
// // //       if (user != null) {
// // //         try {
// // //           // Récupérer les informations sur l'utilisateur, notamment son rôle
// // //           DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();
          
// // //           if (userDoc.exists) {
// // //             Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
            
// // //             return {
// // //               'uid': user.uid,
// // //               'email': user.email,
// // //               'role': userData['role'] ?? 'unknown',
// // //             };
// // //           } else {
// // //             // Si l'utilisateur n'existe pas dans Firestore, créer une entrée par défaut
// // //             // Cela peut arriver si l'utilisateur a été créé directement dans Firebase Auth
// // //             await _firestore.collection('users').doc(user.uid).set({
// // //               'email': user.email,
// // //               'role': 'patient', // Rôle par défaut
// // //               'createdAt': FieldValue.serverTimestamp(),
// // //             });
            
// // //             return {
// // //               'uid': user.uid,
// // //               'email': user.email,
// // //               'role': 'patient',
// // //             };
// // //           }
// // //         } catch (firestoreError) {
// // //           // En cas d'erreur avec Firestore, on retourne quand même les infos de base
// // //           print("Erreur Firestore: $firestoreError");
// // //           return {
// // //             'uid': user.uid,
// // //             'email': user.email,
// // //             'role': 'unknown',
// // //           };
// // //         }
// // //       } else {
// // //         throw Exception("Erreur lors de la connexion");
// // //       }
// // //     } on FirebaseAuthException catch (e) {
// // //       // Gérer spécifiquement les erreurs de Firebase Auth
// // //       String message;
// // //       switch (e.code) {
// // //         case 'user-not-found':
// // //           message = "Aucun utilisateur trouvé avec cet email.";
// // //           break;
// // //         case 'wrong-password':
// // //           message = "Mot de passe incorrect.";
// // //           break;
// // //         case 'invalid-email':
// // //           message = "Format d'email invalide.";
// // //           break;
// // //         case 'user-disabled':
// // //           message = "Ce compte a été désactivé.";
// // //           break;
// // //         default:
// // //           message = "Erreur de connexion: vérifiez vos identifiants.";
// // //       }
// // //       throw Exception(message);
// // //     } catch (e) {
// // //       throw Exception("Erreur de connexion: vérifiez vos identifiants.");
// // //     }
// // //   }

// // //   // Méthode pour se déconnecter
// // //   Future<void> signOut() async {
// // //     try {
// // //       await _auth.signOut();
// // //     } catch (e) {
// // //       throw Exception("Erreur lors de la déconnexion: $e");
// // //     }
// // //   }

// // //   // Vérifier l'état d'authentification de l'utilisateur et récupérer son rôle
// // //   Future<Map<String, dynamic>?> getCurrentUser() async {
// // //     User? user = _auth.currentUser;
    
// // //     if (user != null) {
// // //       try {
// // //         DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();
        
// // //         if (userDoc.exists) {
// // //           Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
          
// // //           return {
// // //             'uid': user.uid,
// // //             'email': user.email,
// // //             'role': userData['role'] ?? 'unknown',
// // //           };
// // //         } else {
// // //           // Si l'utilisateur n'existe pas dans Firestore, créer une entrée par défaut
// // //           await _firestore.collection('users').doc(user.uid).set({
// // //             'email': user.email,
// // //             'role': 'patient', // Rôle par défaut
// // //             'createdAt': FieldValue.serverTimestamp(),
// // //           });
          
// // //           return {
// // //             'uid': user.uid,
// // //             'email': user.email,
// // //             'role': 'patient',
// // //           };
// // //         }
// // //       } catch (e) {
// // //         print("Erreur lors de la récupération des données utilisateur: $e");
// // //         // Retourner quand même les infos de base
// // //         return {
// // //           'uid': user.uid,
// // //           'email': user.email,
// // //           'role': 'unknown',
// // //         };
// // //       }
// // //     }
    
// // //     return null; // Aucun utilisateur connecté
// // //   }

// // //   getUserRole() {}
// // // }

// // // class MedicalRecordService {
// // //   final FirebaseAuth _auth = FirebaseAuth.instance;
// // //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// // //   // Méthode pour enregistrer le dossier médical
// // //   Future<void> saveMedicalRecord({
// // //     required String fullName,
// // //     required String dateOfBirth,
// // //     required String socialSecurityNumber,
// // //     required String address,
// // //     required String phone,
// // //     required String emergencyContact,
// // //     required List<String> medicalHistory,
// // //     required List<String> familyHistory,
// // //     required List<String> allergies,
// // //     required List<String> currentTreatments,
// // //     required List<String> vaccinations,
// // //     required List<String> recentConsultations,
// // //     required List<String> exams,
// // //   }) async {
// // //     try {
// // //       final user = _auth.currentUser;
// // //       if (user == null) {
// // //         throw Exception("Aucun utilisateur connecté.");
// // //       }

// // //       // Enregistrer le dossier médical dans Firestore
// // //       await _firestore.collection('dossier_medicaux').add({
// // //         'uid_patient': user.uid, // ID de l'utilisateur connecté
// // //         'full_name': fullName,
// // //         'date_of_birth': dateOfBirth,
// // //         'social_security_number': socialSecurityNumber,
// // //         'address': address,
// // //         'phone': phone,
// // //         'emergency_contact': emergencyContact,
// // //         'medical_history': medicalHistory,
// // //         'family_history': familyHistory,
// // //         'allergies': allergies,
// // //         'current_treatments': currentTreatments,
// // //         'vaccinations': vaccinations,
// // //         'recent_consultations': recentConsultations,
// // //         'exams': exams,
// // //         'created_at': FieldValue.serverTimestamp(), // Horodatage
// // //       });
// // //     } catch (e) {
// // //       throw Exception("Erreur lors de l'enregistrement du dossier médical: $e");
// // //     }
// // //   }

  
// // // }
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';

// // class AuthService {
// //   final FirebaseAuth _auth = FirebaseAuth.instance;
// //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// //   // Méthode pour se connecter avec debugging amélioré
// //   Future<Map<String, dynamic>> signIn({
// //     required String email,
// //     required String password,
// //   }) async {
// //     try {
// //       print("======= DÉBUT CONNEXION =======");
// //       print("Email: $email");
      
// //       // Connecter l'utilisateur avec Firebase Auth
// //       print("Tentative d'authentification Firebase...");
// //       UserCredential result = await _auth.signInWithEmailAndPassword(
// //         email: email,
// //         password: password,
// //       );
      
// //       User? user = result.user;
// //       print("Authentification Firebase terminée");
      
// //       if (user != null) {
// //         print("Utilisateur authentifié: ${user.uid}");
// //         try {
// //           // Récupérer les informations sur l'utilisateur, notamment son rôle
// //           print("Récupération des données utilisateur depuis Firestore...");
// //           DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();
          
// //           if (userDoc.exists) {
// //             print("Document utilisateur trouvé dans Firestore");
// //             Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
// //             print("Données utilisateur: $userData");
            
// //             // Vérifier explicitement le rôle
// //             String role = userData['role']?.toString() ?? 'unknown';
// //             print("Rôle utilisateur: $role");
            
// //             Map<String, dynamic> result = {
// //               'uid': user.uid,
// //               'email': user.email,
// //               'role': role,
// //             };
            
// //             print("Données de retour: $result");
// //             print("======= FIN CONNEXION =======");
            
// //             return result;
// //           } else {
// //             // Si l'utilisateur n'existe pas dans Firestore, créer une entrée par défaut
// //             print("Document utilisateur NON trouvé dans Firestore, création d'une entrée par défaut");
// //             await _firestore.collection('users').doc(user.uid).set({
// //               'email': user.email,
// //               'role': 'patient', // Rôle par défaut
// //               'createdAt': FieldValue.serverTimestamp(),
// //             });
            
// //             Map<String, dynamic> result = {
// //               'uid': user.uid,
// //               'email': user.email,
// //               'role': 'patient',
// //             };
            
// //             print("Données de retour: $result");
// //             print("======= FIN CONNEXION =======");
            
// //             return result;
// //           }
// //         } catch (firestoreError) {
// //           // En cas d'erreur avec Firestore, on retourne quand même les infos de base
// //           print("Erreur Firestore: $firestoreError");
// //           Map<String, dynamic> result = {
// //             'uid': user.uid,
// //             'email': user.email,
// //             'role': 'unknown',
// //           };
          
// //           print("Données de retour (après erreur): $result");
// //           print("======= FIN CONNEXION AVEC ERREUR FIRESTORE =======");
          
// //           return result;
// //         }
// //       } else {
// //         print("Utilisateur null après authentification Firebase");
// //         print("======= FIN CONNEXION AVEC ERREUR =======");
// //         throw Exception("Erreur lors de la connexion: utilisateur null");
// //       }
// //     } on FirebaseAuthException catch (e) {
// //       // Gérer spécifiquement les erreurs de Firebase Auth
// //       print("Erreur FirebaseAuth: code=${e.code}, message=${e.message}");
// //       String message;
// //       switch (e.code) {
// //         case 'user-not-found':
// //           message = "Aucun utilisateur trouvé avec cet email.";
// //           break;
// //         case 'wrong-password':
// //           message = "Mot de passe incorrect.";
// //           break;
// //         case 'invalid-email':
// //           message = "Format d'email invalide.";
// //           break;
// //         case 'user-disabled':
// //           message = "Ce compte a été désactivé.";
// //           break;
// //         default:
// //           message = "Erreur de connexion: ${e.message}";
// //       }
// //       print("Message d'erreur formaté: $message");
// //       print("======= FIN CONNEXION AVEC ERREUR FIREBASE AUTH =======");
// //       throw Exception(message);
// //     } catch (e) {
// //       print("Erreur générique: $e");
// //       print("======= FIN CONNEXION AVEC ERREUR GÉNÉRIQUE =======");
// //       throw Exception("Erreur de connexion: $e");
// //     }
// //   }

// //   // Méthode pour s'inscrire en tant que clinique
// //   Future<Map<String, dynamic>> registerClinic({
// //     required String email,
// //     required String password,
// //     required String nomClinique,
// //     required double latitude,
// //     required double longitude,
// //   }) async {
// //     try {
// //       // Créer l'utilisateur dans Firebase Auth
// //       UserCredential result = await _auth.createUserWithEmailAndPassword(
// //         email: email,
// //         password: password,
// //       );
      
// //       User? user = result.user;
      
// //       if (user != null) {
// //         // Stocker les informations supplémentaires dans Firestore
// //         await _firestore.collection('cliniques').doc(user.uid).set({
// //           'email': email,
// //           'nom': nomClinique,
// //           'latitude': latitude,
// //           'longitude': longitude,
// //           'role': 'clinique',
// //           'createdAt': FieldValue.serverTimestamp(),
// //         });
        
// //         // Mettre également le rôle dans la collection 'users' pour faciliter la récupération
// //         await _firestore.collection('users').doc(user.uid).set({
// //           'email': email,
// //           'role': 'clinique',
// //           'createdAt': FieldValue.serverTimestamp(),
// //         });
        
// //         return {
// //           'uid': user.uid,
// //           'email': email,
// //           'role': 'clinique',
// //           'nom': nomClinique,
// //         };
// //       } else {
// //         throw Exception("Erreur lors de la création du compte");
// //       }
// //     } on FirebaseAuthException catch (e) {
// //       // Gérer spécifiquement les erreurs de Firebase Auth
// //       String message;
// //       switch (e.code) {
// //         case 'email-already-in-use':
// //           message = "Cet email est déjà utilisé par un autre compte.";
// //           break;
// //         case 'invalid-email':
// //           message = "L'adresse email est mal formatée.";
// //           break;
// //         case 'weak-password':
// //           message = "Le mot de passe est trop faible.";
// //           break;
// //         default:
// //           message = "Erreur d'inscription: ${e.message}";
// //       }
// //       throw Exception(message);
// //     } catch (e) {
// //       throw Exception("Erreur d'inscription: $e");
// //     }
// //   }

// //   // Méthode pour se déconnecter
// //   Future<void> signOut() async {
// //     try {
// //       print("Tentative de déconnexion...");
// //       await _auth.signOut();
// //       print("Déconnexion réussie");
// //     } catch (e) {
// //       print("Erreur lors de la déconnexion: $e");
// //       throw Exception("Erreur lors de la déconnexion: $e");
// //     }
// //   }

// //   // Vérifier l'état d'authentification actuel
// //   Future<Map<String, dynamic>?> getCurrentUser() async {
// //     User? user = _auth.currentUser;
    
// //     if (user != null) {
// //       try {
// //         DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();
        
// //         if (userDoc.exists) {
// //           Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
          
// //           return {
// //             'uid': user.uid,
// //             'email': user.email,
// //             'role': userData['role'] ?? 'unknown',
// //           };
// //         } else {
// //           // Si l'utilisateur n'existe pas dans Firestore, créer une entrée par défaut
// //           await _firestore.collection('users').doc(user.uid).set({
// //             'email': user.email,
// //             'role': 'patient', // Rôle par défaut
// //             'createdAt': FieldValue.serverTimestamp(),
// //           });
          
// //           return {
// //             'uid': user.uid,
// //             'email': user.email,
// //             'role': 'patient',
// //           };
// //         }
// //       } catch (e) {
// //         print("Erreur lors de la récupération des données utilisateur: $e");
// //         // Retourner quand même les infos de base
// //         return {
// //           'uid': user.uid,
// //           'email': user.email,
// //           'role': 'unknown',
// //         };
// //       }
// //     }
    
// //     return null; // Aucun utilisateur connecté
// //   }

// //   getUserRole() {}
// // }

// // class Roles {
// //   static const String MEDECIN = 'medecin';
// //   static const String DOCTEUR = 'docteur';
// //   static const String DOCTOR = 'doctor';
// //   static const String CLINIQUE = 'clinique';
// //   static const String CLINIC = 'clinic';
  
// //   static bool isMedecin(String? role) {
// //     if (role == null) return false;
// //     String normalizedRole = role.trim().toLowerCase();
// //     return normalizedRole == MEDECIN || normalizedRole == DOCTEUR || normalizedRole == DOCTOR;
// //   }
  
// //   static bool isClinique(String? role) {
// //     if (role == null) return false;
// //     String normalizedRole = role.trim().toLowerCase();
// //     return normalizedRole == CLINIQUE || normalizedRole == CLINIC;
// //   }
// // }
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class AuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   // Méthode pour récupérer l'ID de l'utilisateur connecté
//   String? getCurrentUserId() {
//     return _auth.currentUser?.uid;
//   }

//   // Méthode pour récupérer le rôle de l'utilisateur
//   Future<String?> getUserRole() async {
//     User? user = _auth.currentUser;
//     if (user == null) return null;
    
//     try {
//       DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();
      
//       if (userDoc.exists) {
//         Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
//         return userData['role']?.toString();
//       }
//     } catch (e) {
//       print("Erreur lors de la récupération du rôle: $e");
//     }
    
//     return null;
//   }

//   // Méthode pour se connecter avec debugging amélioré
//   Future<Map<String, dynamic>> signIn({
//     required String email,
//     required String password,
//   }) async {
//     try {
//       print("======= DÉBUT CONNEXION =======");
//       print("Email: $email");
      
//       // Connecter l'utilisateur avec Firebase Auth
//       print("Tentative d'authentification Firebase...");
//       UserCredential result = await _auth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
      
//       User? user = result.user;
//       print("Authentification Firebase terminée");
      
//       if (user != null) {
//         print("Utilisateur authentifié: ${user.uid}");
//         try {
//           // Récupérer les informations sur l'utilisateur, notamment son rôle
//           print("Récupération des données utilisateur depuis Firestore...");
//           DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();
          
//           if (userDoc.exists) {
//             print("Document utilisateur trouvé dans Firestore");
//             Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
//             print("Données utilisateur: $userData");
            
//             // Vérifier explicitement le rôle
//             String role = userData['role']?.toString() ?? 'unknown';
//             print("Rôle utilisateur: $role");
            
//             Map<String, dynamic> result = {
//               'uid': user.uid,
//               'email': user.email,
//               'role': role,
//             };
            
//             print("Données de retour: $result");
//             print("======= FIN CONNEXION =======");
            
//             return result;
//           } else {
//             // Si l'utilisateur n'existe pas dans Firestore, créer une entrée par défaut
//             print("Document utilisateur NON trouvé dans Firestore, création d'une entrée par défaut");
//             await _firestore.collection('users').doc(user.uid).set({
//               'email': user.email,
//               'role': 'patient', // Rôle par défaut
//               'createdAt': FieldValue.serverTimestamp(),
//             });
            
//             Map<String, dynamic> result = {
//               'uid': user.uid,
//               'email': user.email,
//               'role': 'patient',
//             };
            
//             print("Données de retour: $result");
//             print("======= FIN CONNEXION =======");
            
//             return result;
//           }
//         } catch (firestoreError) {
//           // En cas d'erreur avec Firestore, on retourne quand même les infos de base
//           print("Erreur Firestore: $firestoreError");
//           Map<String, dynamic> result = {
//             'uid': user.uid,
//             'email': user.email,
//             'role': 'unknown',
//           };
          
//           print("Données de retour (après erreur): $result");
//           print("======= FIN CONNEXION AVEC ERREUR FIRESTORE =======");
          
//           return result;
//         }
//       } else {
//         print("Utilisateur null après authentification Firebase");
//         print("======= FIN CONNEXION AVEC ERREUR =======");
//         throw Exception("Erreur lors de la connexion: utilisateur null");
//       }
//     } on FirebaseAuthException catch (e) {
//       // Gérer spécifiquement les erreurs de Firebase Auth
//       print("Erreur FirebaseAuth: code=${e.code}, message=${e.message}");
//       String message;
//       switch (e.code) {
//         case 'user-not-found':
//           message = "Aucun utilisateur trouvé avec cet email.";
//           break;
//         case 'wrong-password':
//           message = "Mot de passe incorrect.";
//           break;
//         case 'invalid-email':
//           message = "Format d'email invalide.";
//           break;
//         case 'user-disabled':
//           message = "Ce compte a été désactivé.";
//           break;
//         default:
//           message = "Erreur de connexion: ${e.message}";
//       }
//       print("Message d'erreur formaté: $message");
//       print("======= FIN CONNEXION AVEC ERREUR FIREBASE AUTH =======");
//       throw Exception(message);
//     } catch (e) {
//       print("Erreur générique: $e");
//       print("======= FIN CONNEXION AVEC ERREUR GÉNÉRIQUE =======");
//       throw Exception("Erreur de connexion: $e");
//     }
//   }

//   // Méthode pour s'inscrire en tant que clinique
//   Future<Map<String, dynamic>> registerClinic({
//     required String email,
//     required String password,
//     required String nomClinique,
//     required double latitude,
//     required double longitude,
//   }) async {
//     try {
//       // Créer l'utilisateur dans Firebase Auth
//       UserCredential result = await _auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
      
//       User? user = result.user;
      
//       if (user != null) {
//         // Stocker les informations supplémentaires dans Firestore
//         await _firestore.collection('cliniques').doc(user.uid).set({
//           'email': email,
//           'nom': nomClinique,
//           'latitude': latitude,
//           'longitude': longitude,
//           'role': 'clinique',
//           'createdAt': FieldValue.serverTimestamp(),
//         });
        
//         // Mettre également le rôle dans la collection 'users' pour faciliter la récupération
//         await _firestore.collection('users').doc(user.uid).set({
//           'email': email,
//           'role': 'clinique',
//           'createdAt': FieldValue.serverTimestamp(),
//         });
        
//         return {
//           'uid': user.uid,
//           'email': email,
//           'role': 'clinique',
//           'nom': nomClinique,
//         };
//       } else {
//         throw Exception("Erreur lors de la création du compte");
//       }
//     } on FirebaseAuthException catch (e) {
//       // Gérer spécifiquement les erreurs de Firebase Auth
//       String message;
//       switch (e.code) {
//         case 'email-already-in-use':
//           message = "Cet email est déjà utilisé par un autre compte.";
//           break;
//         case 'invalid-email':
//           message = "L'adresse email est mal formatée.";
//           break;
//         case 'weak-password':
//           message = "Le mot de passe est trop faible.";
//           break;
//         default:
//           message = "Erreur d'inscription: ${e.message}";
//       }
//       throw Exception(message);
//     } catch (e) {
//       throw Exception("Erreur d'inscription: $e");
//     }
//   }

//   // Méthode pour se déconnecter
//   Future<void> signOut() async {
//     try {
//       print("Tentative de déconnexion...");
//       await _auth.signOut();
//       print("Déconnexion réussie");
//     } catch (e) {
//       print("Erreur lors de la déconnexion: $e");
//       throw Exception("Erreur lors de la déconnexion: $e");
//     }
//   }

//   // Vérifier l'état d'authentification actuel
//   Future<Map<String, dynamic>?> getCurrentUser() async {
//     User? user = _auth.currentUser;
    
//     if (user != null) {
//       try {
//         DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();
        
//         if (userDoc.exists) {
//           Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
          
//           return {
//             'uid': user.uid,
//             'email': user.email,
//             'role': userData['role'] ?? 'unknown',
//           };
//         } else {
//           // Si l'utilisateur n'existe pas dans Firestore, créer une entrée par défaut
//           await _firestore.collection('users').doc(user.uid).set({
//             'email': user.email,
//             'role': 'patient', // Rôle par défaut
//             'createdAt': FieldValue.serverTimestamp(),
//           });
          
//           return {
//             'uid': user.uid,
//             'email': user.email,
//             'role': 'patient',
//           };
//         }
//       } catch (e) {
//         print("Erreur lors de la récupération des données utilisateur: $e");
//         // Retourner quand même les infos de base
//         return {
//           'uid': user.uid,
//           'email': user.email,
//           'role': 'unknown',
//         };
//       }
//     }
    
//     return null; // Aucun utilisateur connecté
//   }
// }

// class Roles {
//   static const String MEDECIN = 'medecin';
//   static const String DOCTEUR = 'docteur';
//   static const String DOCTOR = 'doctor';
//   static const String CLINIQUE = 'clinique';
//   static const String CLINIC = 'clinic';
  
//   static bool isMedecin(String? role) {
//     if (role == null) return false;
//     String normalizedRole = role.trim().toLowerCase();
//     return normalizedRole == MEDECIN || normalizedRole == DOCTEUR || normalizedRole == DOCTOR;
//   }
  
//   static bool isClinique(String? role) {
//     if (role == null) return false;
//     String normalizedRole = role.trim().toLowerCase();
//     return normalizedRole == CLINIQUE || normalizedRole == CLINIC;
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Méthode pour récupérer l'ID de l'utilisateur connecté
  String? getCurrentUserId() {
    return _auth.currentUser?.uid;
  }

  // Méthode pour récupérer le rôle de l'utilisateur
  Future<String?> getUserRole() async {
    User? user = _auth.currentUser;
    if (user == null) return null;
    
    try {
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();
      
      if (userDoc.exists) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        return userData['role']?.toString();
      }
    } catch (e) {
      print("Erreur lors de la récupération du rôle: $e");
    }
    
    return null;
  }

  // Méthode pour enregistrer un médecin
  Future<String> registerDoctor({
    required String email,
    required String password,
    required String nom,
    required String prenom,
    required String specialite,
    required int age,
    required String cliniqueId,
  }) async {
    try {
      print("======= DÉBUT ENREGISTREMENT MÉDECIN =======");
      print("Email: $email, Nom: $nom, Prénom: $prenom, Spécialité: $specialite");
      print("Clinique ID: $cliniqueId");
      
      // 1. Créer un compte utilisateur dans Firebase Authentication
      print("Création du compte utilisateur dans Firebase Auth...");
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      String doctorId = userCredential.user!.uid;
      print("Compte créé avec ID: $doctorId");
      
      // 2. Enregistrer les données du médecin dans Firestore
      print("Enregistrement des données dans Firestore...");
      await _firestore.collection('users').doc(doctorId).set({
        'uid': doctorId,
        'email': email,
        'nom': nom,
        'prenom': prenom,
        'specialite': specialite,
        'age': age,
        'role': 'doctor',
        'cliniqueId': cliniqueId,
        'dateCreation': FieldValue.serverTimestamp(),
      });
      
      print("Données utilisateur enregistrées dans la collection 'users'");
      
      // 3. Enregistrer également dans une collection dédiée aux médecins pour faciliter la recherche
      await _firestore.collection('medecins').doc(doctorId).set({
        'uid': doctorId,
        'email': email,
        'nom': nom,
        'prenom': prenom,
        'specialite': specialite,
        'age': age,
        'cliniqueId': cliniqueId,
        'dateCreation': FieldValue.serverTimestamp(),
      });
      
      print("Données utilisateur enregistrées dans la collection 'medecins'");
      
      // 4. Ajouter ce médecin à la liste des médecins de la clinique
      DocumentReference cliniqueRef = _firestore.collection('cliniques').doc(cliniqueId);
      DocumentSnapshot cliniqueDoc = await cliniqueRef.get();
      
      if (cliniqueDoc.exists) {
        print("Document clinique trouvé, mise à jour...");
        
        // Vérifier si le champ 'medecins' existe déjà
        if ((cliniqueDoc.data() as Map<String, dynamic>).containsKey('medecins')) {
          await cliniqueRef.update({
            'medecins': FieldValue.arrayUnion([doctorId])
          });
        } else {
          // Créer le champ s'il n'existe pas
          await cliniqueRef.update({
            'medecins': [doctorId]
          });
        }
        
        print("Médecin ajouté à la clinique");
      } else {
        print("Document clinique non trouvé. Création...");
        await cliniqueRef.set({
          'medecins': [doctorId],
          'dateCreation': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
        
        print("Document clinique créé avec le médecin");
      }
      
      print("======= FIN ENREGISTREMENT MÉDECIN =======");
      return doctorId;
    } catch (e) {
      print("Erreur lors de l'enregistrement du médecin: $e");
      throw e;
    }
  }

  // Méthode pour se connecter avec debugging amélioré
  Future<Map<String, dynamic>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      print("======= DÉBUT CONNEXION =======");
      print("Email: $email");
      
      // Connecter l'utilisateur avec Firebase Auth
      print("Tentative d'authentification Firebase...");
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      User? user = result.user;
      print("Authentification Firebase terminée");
      
      if (user != null) {
        print("Utilisateur authentifié: ${user.uid}");
        try {
          // Récupérer les informations sur l'utilisateur, notamment son rôle
          print("Récupération des données utilisateur depuis Firestore...");
          DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();
          
          if (userDoc.exists) {
            print("Document utilisateur trouvé dans Firestore");
            Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
            print("Données utilisateur: $userData");
            
            // Vérifier explicitement le rôle
            String role = userData['role']?.toString() ?? 'unknown';
            print("Rôle utilisateur: $role");
            
            Map<String, dynamic> result = {
              'uid': user.uid,
              'email': user.email,
              'role': role,
            };
            
            print("Données de retour: $result");
            print("======= FIN CONNEXION =======");
            
            return result;
          } else {
            // Si l'utilisateur n'existe pas dans Firestore, créer une entrée par défaut
            print("Document utilisateur NON trouvé dans Firestore, création d'une entrée par défaut");
            await _firestore.collection('users').doc(user.uid).set({
              'email': user.email,
              'role': 'patient', // Rôle par défaut
              'createdAt': FieldValue.serverTimestamp(),
            });
            
            Map<String, dynamic> result = {
              'uid': user.uid,
              'email': user.email,
              'role': 'patient',
            };
            
            print("Données de retour: $result");
            print("======= FIN CONNEXION =======");
            
            return result;
          }
        } catch (firestoreError) {
          // En cas d'erreur avec Firestore, on retourne quand même les infos de base
          print("Erreur Firestore: $firestoreError");
          Map<String, dynamic> result = {
            'uid': user.uid,
            'email': user.email,
            'role': 'unknown',
          };
          
          print("Données de retour (après erreur): $result");
          print("======= FIN CONNEXION AVEC ERREUR FIRESTORE =======");
          
          return result;
        }
      } else {
        print("Utilisateur null après authentification Firebase");
        print("======= FIN CONNEXION AVEC ERREUR =======");
        throw Exception("Erreur lors de la connexion: utilisateur null");
      }
    } on FirebaseAuthException catch (e) {
      // Gérer spécifiquement les erreurs de Firebase Auth
      print("Erreur FirebaseAuth: code=${e.code}, message=${e.message}");
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
          message = "Erreur de connexion: ${e.message}";
      }
      print("Message d'erreur formaté: $message");
      print("======= FIN CONNEXION AVEC ERREUR FIREBASE AUTH =======");
      throw Exception(message);
    } catch (e) {
      print("Erreur générique: $e");
      print("======= FIN CONNEXION AVEC ERREUR GÉNÉRIQUE =======");
      throw Exception("Erreur de connexion: $e");
    }
  }

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

  // Méthode pour se déconnecter
  Future<void> signOut() async {
    try {
      print("Tentative de déconnexion...");
      await _auth.signOut();
      print("Déconnexion réussie");
    } catch (e) {
      print("Erreur lors de la déconnexion: $e");
      throw Exception("Erreur lors de la déconnexion: $e");
    }
  }

  // Vérifier l'état d'authentification actuel
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

class Roles {
  static const String MEDECIN = 'medecin';
  static const String DOCTEUR = 'docteur';
  static const String DOCTOR = 'doctor';
  static const String CLINIQUE = 'clinique';
  static const String CLINIC = 'clinic';
  
  static bool isMedecin(String? role) {
    if (role == null) return false;
    String normalizedRole = role.trim().toLowerCase();
    return normalizedRole == MEDECIN || normalizedRole == DOCTEUR || normalizedRole == DOCTOR;
  }
  
  static bool isClinique(String? role) {
    if (role == null) return false;
    String normalizedRole = role.trim().toLowerCase();
    return normalizedRole == CLINIQUE || normalizedRole == CLINIC;
  }
}