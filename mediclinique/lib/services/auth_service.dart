
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Récupérer l'ID de l'utilisateur actuellement connecté
  String? getCurrentUserId() {
    return _auth.currentUser?.uid;
  }

  // Vérifier si l'utilisateur actuel est une clinique
  Future<bool> isClinic() async {
    String? uid = _auth.currentUser?.uid;
    if (uid != null) {
      DocumentSnapshot doc = await _firestore.collection('cliniques').doc(uid).get();
      return doc.exists; // Vérifie si l'utilisateur est une clinique
    }
    return false;
  }

  // Inscription de l'admin (seul le premier inscrit)
  Future<String?> registerAdmin({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      // Vérification s'il y a déjà un admin
      QuerySnapshot adminQuery = await _firestore.collection('users')
          .where('role', isEqualTo: 'admin')
          .get();
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
          'dateCreation': FieldValue.serverTimestamp(),
          'actif': true,
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

  // Inscription d'une clinique
  Future<String?> registerClinic({
    required String email,
    required String password,
    required String nomClinique,
    required double latitude,
    required double longitude,
  }) async {
    try {
      // Vérifier si l'email est déjà utilisé
      QuerySnapshot emailCheck = await _firestore.collection('cliniques')
          .where('email', isEqualTo: email)
          .get();
      if (emailCheck.docs.isNotEmpty) {
        return "L'email est déjà utilisé par une clinique.";
      }

      // Vérifier si la collection 'cliniques' existe déjà
      CollectionReference cliniquesRef = _firestore.collection('cliniques');
      
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null) {
        // Création de la clinique dans la collection 'cliniques'
        await cliniquesRef.doc(user.uid).set({
          'email': email,
          'nomClinique': nomClinique,
          'localisation': GeoPoint(latitude, longitude),
          'adresse': '',  // Champ à remplir ultérieurement
          'telephone': '',  // Champ à remplir ultérieurement
          'specialites': [],  // Liste des spécialités disponibles
          'horaires': {
            'lundi': {'debut': '', 'fin': ''},
            'mardi': {'debut': '', 'fin': ''},
            'mercredi': {'debut': '', 'fin': ''},
            'jeudi': {'debut': '', 'fin': ''},
            'vendredi': {'debut': '', 'fin': ''},
            'samedi': {'debut': '', 'fin': ''},
            'dimanche': {'debut': '', 'fin': ''},
          },
          'role': 'clinic',
          'uid': user.uid,
          'dateCreation': FieldValue.serverTimestamp(),
          'actif': true,
          'description': '',  // Description de la clinique
          'imageUrl': '',  // URL de l'image de la clinique
        });
        
        // Créer également un document dans 'users' pour faciliter la gestion des rôles
        await _firestore.collection('users').doc(user.uid).set({
          'email': email,
          'fullName': nomClinique,
          'role': 'clinic',
          'uid': user.uid,
          'cliniqueId': user.uid,
          'dateCreation': FieldValue.serverTimestamp(),
          'actif': true,
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

  // Inscription d'un médecin par une clinique
  Future<String?> registerMedecin({
    required String email,
    required String password,
    required String fullName,
    required String specialite,
  }) async {
    try {
      String? clinicId = getCurrentUserId();
      bool isClinicUser = await isClinic();
      
      if (!isClinicUser) {
        return "Seules les cliniques peuvent inscrire des médecins.";
      }

      // Vérifier si l'email est déjà utilisé
      QuerySnapshot emailCheck = await _firestore.collection('users')
          .where('email', isEqualTo: email)
          .get();
      if (emailCheck.docs.isNotEmpty) {
        return "L'email est déjà utilisé par un autre utilisateur.";
      }

      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null) {
        // Ajout du médecin dans la collection 'users'
        await _firestore.collection('users').doc(user.uid).set({
          'email': email,
          'fullName': fullName,
          'role': 'medecin',
          'uid': user.uid,
          'cliniqueId': clinicId,
          'specialite': specialite,
          'dateCreation': FieldValue.serverTimestamp(),
          'actif': true,
          'disponible': true,
          'imageUrl': '',  // URL de l'image du médecin
        });
        
        // Ajout du médecin dans la sous-collection 'medecins' de la clinique
        await _firestore.collection('cliniques').doc(clinicId)
            .collection('medecins').doc(user.uid).set({
          'uid': user.uid,
          'fullName': fullName,
          'email': email,
          'specialite': specialite,
          'dateCreation': FieldValue.serverTimestamp(),
          'actif': true,
          'disponible': true,
        });
        
        // Mise à jour de la liste des spécialités de la clinique
        DocumentSnapshot clinicDoc = await _firestore.collection('cliniques').doc(clinicId).get();
        List<dynamic> specialites = (clinicDoc.data() as Map<String, dynamic>)['specialites'] ?? [];
        
        if (!specialites.contains(specialite)) {
          specialites.add(specialite);
          await _firestore.collection('cliniques').doc(clinicId).update({
            'specialites': specialites,
          });
        }
        
        return null;
      } else {
        return "Échec de l'inscription du médecin, utilisateur introuvable.";
      }
    } catch (e) {
      print("Erreur d'inscription du médecin : $e");
      return "Erreur lors de l'inscription du médecin : ${e.toString()}";
    }
  }

  // Connexion avec email et mot de passe
  Future<String?> loginUser(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } catch (e) {
      print("Erreur de connexion : $e");
      return "Erreur de connexion : ${e.toString()}";
    }
  }

  // Déconnexion
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Récupérer le rôle de l'utilisateur depuis Firestore
  // Future<String?> getUserRole(String uid) async {
  //   try {
  //     // Vérifier d'abord dans la collection 'cliniques'
  //     DocumentSnapshot clinicDoc = await _firestore.collection('cliniques').doc(uid).get();
  //     if (clinicDoc.exists) {
  //       return 'clinic';
  //     }
      
  //     // Sinon, vérifier dans la collection 'users'
  //     DocumentSnapshot userDoc = await _firestore.collection('users').doc(uid).get();
  //     if (userDoc.exists) {
  //       return userDoc['role'] as String?;
  //     }
      
  //     return "Rôle non trouvé";
  //   } catch (e) {
  //     print("Erreur lors de la récupération du rôle : $e");
  //     return "Erreur lors de la récupération du rôle : ${e.toString()}";
  //   }
  // }
  Future<String?> getUserRole(String uid) async {
  try {
    DocumentSnapshot userDoc = await _firestore.collection('users').doc(uid).get();
    if (userDoc.exists) {
      return userDoc['role'] as String?;
    }
    return null;
  } catch (e) {
    print("Erreur lors de la récupération du rôle : $e");
    return null;
  }
}

  // Récupérer les informations de la clinique connectée
  Future<Map<String, dynamic>?> getCliniqueInfo() async {
    try {
      String? uid = getCurrentUserId();
      if (uid != null) {
        DocumentSnapshot clinicDoc = await _firestore.collection('cliniques').doc(uid).get();
        if (clinicDoc.exists) {
          return clinicDoc.data() as Map<String, dynamic>;
        }
      }
      return null;
    } catch (e) {
      print("Erreur lors de la récupération des informations de la clinique : $e");
      return null;
    }
  }

  // Récupérer la liste des médecins d'une clinique
  Future<List<Map<String, dynamic>>> getMedecins() async {
    try {
      String? clinicId = getCurrentUserId();
      if (clinicId == null) {
        return [];
      }
      
      // Récupérer les médecins de la sous-collection de la clinique
      QuerySnapshot querySnapshot = await _firestore.collection('cliniques')
          .doc(clinicId)
          .collection('medecins')
          .where('actif', isEqualTo: true)
          .get();
      
      List<Map<String, dynamic>> medecins = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return {
          'uid': data['uid'],
          'fullName': data['fullName'],
          'email': data['email'],
          'specialite': data['specialite'],
          'disponible': data['disponible'] ?? true,
        };
      }).toList();

      return medecins;
    } catch (e) {
      print("Erreur de récupération des médecins : $e");
      return [];
    }
  }

  // Mettre à jour les informations de la clinique
  Future<String?> updateCliniqueInfo({
    required String nomClinique,
    String? adresse,
    String? telephone,
    String? description,
    String? imageUrl,
    Map<String, dynamic>? horaires,
  }) async {
    try {
      String? uid = getCurrentUserId();
      if (uid == null) {
        return "Utilisateur non connecté";
      }

      Map<String, dynamic> updateData = {};
      
      if (nomClinique.isNotEmpty) updateData['nomClinique'] = nomClinique;
      if (adresse != null) updateData['adresse'] = adresse;
      if (telephone != null) updateData['telephone'] = telephone;
      if (description != null) updateData['description'] = description;
      if (imageUrl != null) updateData['imageUrl'] = imageUrl;
      if (horaires != null) updateData['horaires'] = horaires;
      
      await _firestore.collection('cliniques').doc(uid).update(updateData);
      
      // Mettre également à jour le nom dans la collection 'users'
      if (nomClinique.isNotEmpty) {
        await _firestore.collection('users').doc(uid).update({
          'fullName': nomClinique,
        });
      }
      
      return null;
    } catch (e) {
      print("Erreur lors de la mise à jour des informations de la clinique : $e");
      return "Erreur lors de la mise à jour : ${e.toString()}";
    }
  }
}