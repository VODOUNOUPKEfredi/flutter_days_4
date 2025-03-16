import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MedicalRecordService {
  // Firebase instances
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  // Méthode pour sauvegarder un dossier médical
  Future<void> saveMedicalRecord({
    required String fullName,
    required String dateOfBirth,
    required String socialSecurityNumber,
    required String address,
    required String phone,
    required String emergencyContact,
    required List<String> medicalHistory,
    required List<String> familyHistory,
    required List<String> allergies,
    required List<String> currentTreatments,
    required List<String> vaccinations,
    required List<String> recentConsultations,
    required List<String> exams,
  }) async {
    try {
      // Vérifier si l'utilisateur est connecté
      final user = _auth.currentUser;
      if (user == null) {
        throw Exception("Utilisateur non connecté");
      }
      final String userId = user.uid;
      
      // Créer un objet avec toutes les données du dossier médical
      final medicalRecord = {
        'fullName': fullName,
        'dateOfBirth': dateOfBirth,
        'socialSecurityNumber': socialSecurityNumber,
        'address': address,
        'phone': phone,
        'emergencyContact': emergencyContact,
        'medicalHistory': medicalHistory,
        'familyHistory': familyHistory,
        'allergies': allergies,
        'currentTreatments': currentTreatments,
        'vaccinations': vaccinations,
        'recentConsultations': recentConsultations,
        'exams': exams,
        'updatedAt': FieldValue.serverTimestamp(),
      };
      
      // Enregistrer dans Firestore
      await _firestore.collection('medicalRecords').doc(userId).set(
        medicalRecord,
        SetOptions(merge: true), // Fusionner avec les données existantes le cas échéant
      );
    } catch (e) {
      throw Exception("Erreur lors de l'enregistrement du dossier médical: $e");
    }
  }
  
  // Méthode pour récupérer un dossier médical
  Future<Map<String, dynamic>?> getMedicalRecord() async {
    try {
      // Vérifier si l'utilisateur est connecté
      final user = _auth.currentUser;
      if (user == null) {
        throw Exception("Utilisateur non connecté");
      }
      final String userId = user.uid;
      
      // Récupérer le document depuis Firestore
      final docSnapshot = await _firestore
          .collection('dossierMedical')
          .doc(userId)
          .get();
      
      // Vérifier si le document existe
      if (!docSnapshot.exists) {
        return null;
      }
      
      return docSnapshot.data();
    } catch (e) {
      throw Exception("Erreur lors de la récupération du dossier médical: $e");
    }
  }
  
  // Méthode pour mettre à jour un dossier médical
  Future<void> updateMedicalRecord(Map<String, dynamic> data) async {
    try {
      // Vérifier si l'utilisateur est connecté
      final user = _auth.currentUser;
      if (user == null) {
        throw Exception("Utilisateur non connecté");
      }
      final String userId = user.uid;
      
      // Ajouter un timestamp de mise à jour
      data['updatedAt'] = FieldValue.serverTimestamp();
      
      // Mettre à jour le document dans Firestore
      await _firestore.collection('medicalRecords').doc(userId).update(data);
    } catch (e) {
      throw Exception("Erreur lors de la mise à jour du dossier médical: $e");
    }
  }
  
  // Méthode pour supprimer un dossier médical
  Future<void> deleteMedicalRecord() async {
    try {
      // Vérifier si l'utilisateur est connecté
      final user = _auth.currentUser;
      if (user == null) {
        throw Exception("Utilisateur non connecté");
      }
      final String userId = user.uid;
      
      // Supprimer le document de Firestore
      await _firestore.collection('medicalRecords').doc(userId).delete();
    } catch (e) {
      throw Exception("Erreur lors de la suppression du dossier médical: $e");
    }
  }
}