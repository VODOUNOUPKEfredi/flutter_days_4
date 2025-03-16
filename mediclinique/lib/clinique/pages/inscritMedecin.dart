// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:mediclic/services/auth_service.dart';

// class RegisterMedecinPage extends StatefulWidget {
//   @override
//   _RegisterMedecinPageState createState() => _RegisterMedecinPageState();
// }

// class _RegisterMedecinPageState extends State<RegisterMedecinPage> {
//   final _formKey = GlobalKey<FormState>();
//   final AuthService _authService = AuthService();

//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _nomController = TextEditingController();
//   final TextEditingController _prenomController = TextEditingController();
//   final TextEditingController _ageController = TextEditingController();
//   final TextEditingController _specialiteController = TextEditingController();
//   final TextEditingController _telephoneController = TextEditingController();
//   final TextEditingController _bioController = TextEditingController();

//   bool _isLoading = false;

//   Future<void> _registerMedecin() async {
//     if (_formKey.currentState!.validate()) {
//       setState(() => _isLoading = true);

//       String? result = await _authService.registerMedecin(
//         email: _emailController.text.trim(),
//         password: _passwordController.text.trim(),
//         fullName: "${_nomController.text.trim()} ${_prenomController.text.trim()}",
//       );

//       if (result == null) {
//         String uid = FirebaseAuth.instance.currentUser!.uid;
//         await FirebaseFirestore.instance.collection('medecins').doc(uid).set({
//           'nom': _nomController.text.trim(),
//           'prenom': _prenomController.text.trim(),
//           'age': int.parse(_ageController.text.trim()),
//           'specialite': _specialiteController.text.trim(),
//           'telephone': _telephoneController.text.trim(),
//           'bio': _bioController.text.trim(),
//           'email': _emailController.text.trim(),
//           'role': 'medecin',
//           'uid': uid,
//         });
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Médecin inscrit avec succès.")),
//         );
//         Navigator.pop(context);
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text(result)),
//         );
//       }

//       setState(() => _isLoading = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Inscription Médecin")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 TextFormField(
//                   controller: _nomController,
//                   decoration: const InputDecoration(labelText: "Nom"),
//                   validator: (value) => value!.isEmpty ? "Entrez un nom" : null,
//                 ),
//                 TextFormField(
//                   controller: _prenomController,
//                   decoration: const InputDecoration(labelText: "Prénom"),
//                   validator: (value) => value!.isEmpty ? "Entrez un prénom" : null,
//                 ),
//                 TextFormField(
//                   controller: _ageController,
//                   decoration: const InputDecoration(labelText: "Âge"),
//                   keyboardType: TextInputType.number,
//                   validator: (value) => value!.isEmpty ? "Entrez un âge" : null,
//                 ),
//                 TextFormField(
//                   controller: _specialiteController,
//                   decoration: const InputDecoration(labelText: "Spécialité"),
//                   validator: (value) => value!.isEmpty ? "Entrez une spécialité" : null,
//                 ),
//                 TextFormField(
//                   controller: _telephoneController,
//                   decoration: const InputDecoration(labelText: "Téléphone"),
//                   keyboardType: TextInputType.phone,
//                   validator: (value) => value!.isEmpty ? "Entrez un numéro de téléphone" : null,
//                 ),
//                 TextFormField(
//                   controller: _bioController,
//                   decoration: const InputDecoration(labelText: "Biographie (optionnelle)"),
//                   maxLines: 3,
//                 ),
//                 TextFormField(
//                   controller: _emailController,
//                   decoration: const InputDecoration(labelText: "Email"),
//                   validator: (value) => value!.isEmpty ? "Entrez un email" : null,
//                 ),
//                 TextFormField(
//                   controller: _passwordController,
//                   decoration: const InputDecoration(labelText: "Mot de passe"),
//                   obscureText: true,
//                   validator: (value) => value!.length < 6 ? "Minimum 6 caractères" : null,
//                 ),
//                 const SizedBox(height: 20),
//                 _isLoading
//                     ? const CircularProgressIndicator()
//                     : ElevatedButton(
//                         onPressed: _registerMedecin,
//                         child: const Text("Inscrire le Médecin"),
//                       ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mediclic/services/auth_service.dart';

class RegisterMedecinPage extends StatefulWidget {
  @override
  _RegisterMedecinPageState createState() => _RegisterMedecinPageState();
}

class _RegisterMedecinPageState extends State<RegisterMedecinPage> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _specialiteController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  bool _isLoading = false;

  Future<void> _registerMedecin() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      try {
        // Enregistrement de l'utilisateur dans Firebase Auth
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        // Si l'utilisateur est bien créé, on ajoute ses informations dans Firestore
        String uid = userCredential.user!.uid;
        await FirebaseFirestore.instance.collection('medecins').doc(uid).set({
          'nom': _nomController.text.trim(),
          'prenom': _prenomController.text.trim(),
          'age': int.parse(_ageController.text.trim()),
          'specialite': _specialiteController.text.trim(),
          'telephone': _telephoneController.text.trim(),
          'bio': _bioController.text.trim(),
          'email': _emailController.text.trim(),
          'role': 'medecin',
          'uid': uid,
        });

        // Affichage du message de succès
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Médecin inscrit avec succès.")),
        );

        // Redirection vers la page de connexion ou d'accueil
        Navigator.pop(context); // On revient à la page précédente ou redirige l'utilisateur

      } catch (e) {
        // En cas d'erreur (par exemple, si l'email est déjà utilisé)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erreur : ${e.toString()}")),
        );
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Inscription Médecin")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _nomController,
                  decoration: const InputDecoration(labelText: "Nom"),
                  validator: (value) => value!.isEmpty ? "Entrez un nom" : null,
                ),
                TextFormField(
                  controller: _prenomController,
                  decoration: const InputDecoration(labelText: "Prénom"),
                  validator: (value) => value!.isEmpty ? "Entrez un prénom" : null,
                ),
                TextFormField(
                  controller: _ageController,
                  decoration: const InputDecoration(labelText: "Âge"),
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty ? "Entrez un âge" : null,
                ),
                TextFormField(
                  controller: _specialiteController,
                  decoration: const InputDecoration(labelText: "Spécialité"),
                  validator: (value) => value!.isEmpty ? "Entrez une spécialité" : null,
                ),
                TextFormField(
                  controller: _telephoneController,
                  decoration: const InputDecoration(labelText: "Téléphone"),
                  keyboardType: TextInputType.phone,
                  validator: (value) => value!.isEmpty ? "Entrez un numéro de téléphone" : null,
                ),
                TextFormField(
                  controller: _bioController,
                  decoration: const InputDecoration(labelText: "Biographie (optionnelle)"),
                  maxLines: 3,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: "Email"),
                  validator: (value) => value!.isEmpty ? "Entrez un email" : null,
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: "Mot de passe"),
                  obscureText: true,
                  validator: (value) => value!.length < 6 ? "Minimum 6 caractères" : null,
                ),
                const SizedBox(height: 20),
                _isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _registerMedecin,
                        child: const Text("Inscrire le Médecin"),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
