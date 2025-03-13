import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Dossiermedical extends StatefulWidget {
  const Dossiermedical({super.key});

  @override
  State<StatefulWidget> createState() {
    return DossiermedicalState();
  }
}

class DossiermedicalState extends State {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Map<String, dynamic>? _userData;
  Map<String, dynamic>? _dossierData;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
    _fetchDossierData();
  }

  Future<void> _fetchUserData() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        DocumentSnapshot snapshot =
            await _firestore.collection('users').doc(user.uid).get();

        if (snapshot.exists) {
          setState(() {
            _userData = snapshot.data() as Map<String, dynamic>;
          });
        } else {
          print("Document utilisateur non trouvé");
        }
      }
    } catch (e) {
      print("Erreur lors de la récupération des données utilisateur : $e");
    }
  }

  Future<void> _fetchDossierData() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        DocumentSnapshot snapshot =
            await _firestore.collection('dossier').doc(user.uid).get();

        if (snapshot.exists) {
          setState(() {
            _dossierData = snapshot.data() as Map<String, dynamic>;
          });
        } else {
          print("Document dossier non trouvé");
        }
      }
    } catch (e) {
      print("Erreur lors de la récupération des données dossier : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    double largeurEcran = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Mon dossier médical"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.download_rounded))
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          spacing: 5,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Informations personnelles",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              width: largeurEcran,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 2,
                  color: Colors.grey,
                  style: BorderStyle.solid,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 5,
                children: [
                  Text("Nom: ${_userData?['nom'] ?? 'Chargement...'}"),
                  Text("Prénom: ${_userData?['prenom'] ?? 'Chargement...'}"),
                  Text(
                      "Date de naissance: ${_userData?['date_naissance'] ?? 'Chargement...'}"),
                  Text(
                      "Groupe sanguin: ${_userData?['groupe_sanguin'] ?? 'Chargement...'}"),
                  Text("Allergies: ${_getAllergies()}"),
                  Text("Maladies chroniques: ${_getMaladiesChroniques()}"),
                  Text(
                      "Contacts d'urgence: ${_userData?['contacts_urgence']?.join(', ') ?? 'Aucun'}"),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Antécédents médicaux et chirugicaux",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                const Text(
                  "Plus",
                  style: TextStyle(color: Colors.blue),
                )
              ],
            ),
            Container(
                padding: const EdgeInsets.all(10),
                width: largeurEcran,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      width: 2, color: Colors.grey, style: BorderStyle.solid),
                ),
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Consultation",
                        style: TextStyle(fontSize: 15),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Text(
                            "10 Décembre 2024",
                            style: TextStyle(fontSize: 10, color: Colors.blue),
                          ),
                          const Text("18h44",
                              style:
                                  TextStyle(fontSize: 10, color: Colors.blue))
                        ],
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [Text("Dr Focas "), Text("Chirugien")],
                      )
                    ],
                  ),
                )),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Historique médical",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            Container(
                padding: const EdgeInsets.all(10),
                width: largeurEcran,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      width: 2, color: Colors.grey, style: BorderStyle.solid),
                ),
                child: const Center(
                  child: Text(
                    "Rien à afficher",
                    style: TextStyle(fontSize: 25, color: Colors.grey),
                  ),
                )),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Documents médicaux et légaux",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                const Text(
                  "Voir plus",
                  style: TextStyle(color: Colors.blue),
                ),
              ],
            ),
            Container(
                padding: const EdgeInsets.all(10),
                width: largeurEcran,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      width: 2, color: Colors.grey, style: BorderStyle.solid),
                ),
                child: const Center(
                  child: Text(
                    "Rien à afficher",
                    style: TextStyle(fontSize: 25, color: Colors.grey),
                  ),
                )),
            GestureDetector(
                onTap: () {},
                child: Container(
                    height: 60,
                    decoration: const BoxDecoration(color: Colors.blue),
                    child: const Center(
                      child: Text(
                        "Voir l'historique des accès",
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ))),
          ],
        ),
      ),
    );
  }

  String _getAllergies() {
    List<String> allergies = [];
    if (_dossierData != null && _dossierData!['allergies'] != null) {
      allergies.addAll(List<String>.from(_dossierData!['allergies']));
    }
    if (_dossierData != null && _dossierData!['allergies'] != null) {
      allergies.addAll(List<String>.from(_dossierData!['allergies']));
    }
    return allergies.isNotEmpty ? allergies.join(', ') : 'Aucune';
  }

  String _getMaladiesChroniques() {
    List<String> maladiesChroniques = [];
    if (_dossierData != null && _dossierData!['maladies_chroniques'] != null) {
      maladiesChroniques
          .addAll(List<String>.from(_dossierData!['maladies_chroniques']));
    }
    if (_dossierData != null && _dossierData!['Maladies Chroniques'] != null) {
      maladiesChroniques.add(_dossierData!['Maladies Chroniques'].toString());
    }
    return maladiesChroniques.isNotEmpty
        ? maladiesChroniques.join(', ')
        : 'Aucune';
  }
}
