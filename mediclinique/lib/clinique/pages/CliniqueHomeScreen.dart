// // import 'package:flutter/material.dart';
// // import 'package:mediclic/services/roles.dart';

// // class RegisterDoctorWidget extends StatefulWidget {
// //   @override
// //   _RegisterDoctorWidgetState createState() => _RegisterDoctorWidgetState();
// // }

// // class _RegisterDoctorWidgetState extends State<RegisterDoctorWidget> {
// //   final AuthService _authService = AuthService();
// //   final _formKey = GlobalKey<FormState>();
  
// //   String email = '';
// //   String password = '';
// //   String confirmPassword = '';
// //   String nom = '';
// //   String prenom = '';
// //   String specialite = '';
// //   int age = 0;
  
// //   bool isLoading = false;
// //   String errorMessage = '';
// //   String successMessage = '';

// //   @override
// //   Widget build(BuildContext context) {
// //     return Card(
// //       elevation: 4,
// //       margin: EdgeInsets.all(10),
// //       child: Padding(
// //         padding: EdgeInsets.all(10),
// //         child: Form(
// //           key: _formKey,
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.stretch,
// //             children: [
// //               Text(
// //                 'Ajouter un nouveau médecin',
// //                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// //                 textAlign: TextAlign.center,
// //               ),
// //               SizedBox(height: 10),
              
// //               // Nom
// //               TextFormField(
// //                 decoration: InputDecoration(
// //                   labelText: 'Nom',
// //                   border: OutlineInputBorder(),
// //                 ),
// //                 validator: (value) => value!.isEmpty ? 'Veuillez entrer le nom' : null,
// //                 onChanged: (value) => nom = value,
// //               ),
// //               SizedBox(height: 10),
              
// //               // Prénom
// //               TextFormField(
// //                 decoration: InputDecoration(
// //                   labelText: 'Prénom',
// //                   border: OutlineInputBorder(),
// //                 ),
// //                 validator: (value) => value!.isEmpty ? 'Veuillez entrer le prénom' : null,
// //                 onChanged: (value) => prenom = value,
// //               ),
// //               SizedBox(height: 10),
              
// //               // Âge
// //               TextFormField(
// //                 decoration: InputDecoration(
// //                   labelText: 'Âge',
// //                   border: OutlineInputBorder(),
// //                 ),
// //                 keyboardType: TextInputType.number,
// //                 validator: (value) {
// //                   if (value!.isEmpty) {
// //                     return 'Veuillez entrer l\'âge';
// //                   }
// //                   int? ageValue = int.tryParse(value);
// //                   if (ageValue == null || ageValue <= 0) {
// //                     return 'Veuillez entrer un âge valide';
// //                   }
// //                   return null;
// //                 },
// //                 onChanged: (value) {
// //                   age = int.tryParse(value) ?? 0;
// //                 },
// //               ),
// //               SizedBox(height: 10),
              
// //               // Spécialité
// //               TextFormField(
// //                 decoration: InputDecoration(
// //                   labelText: 'Spécialité',
// //                   border: OutlineInputBorder(),
// //                 ),
// //                 validator: (value) => value!.isEmpty ? 'Veuillez entrer la spécialité' : null,
// //                 onChanged: (value) => specialite = value,
// //               ),
// //               SizedBox(height: 10),
              
// //               // Email
// //               TextFormField(
// //                 decoration: InputDecoration(
// //                   labelText: 'Email',
// //                   border: OutlineInputBorder(),
// //                 ),
// //                 keyboardType: TextInputType.emailAddress,
// //                 validator: (value) {
// //                   if (value!.isEmpty) {
// //                     return 'Veuillez entrer un email';
// //                   }
// //                   if (!value.contains('@')) {
// //                     return 'Veuillez entrer un email valide';
// //                   }
// //                   return null;
// //                 },
// //                 onChanged: (value) => email = value,
// //               ),
// //               SizedBox(height: 10),
              
// //               // Mot de passe
// //               TextFormField(
// //                 decoration: InputDecoration(
// //                   labelText: 'Mot de passe',
// //                   border: OutlineInputBorder(),
// //                 ),
// //                 obscureText: true,
// //                 validator: (value) {
// //                   if (value!.isEmpty) {
// //                     return 'Veuillez entrer un mot de passe';
// //                   }
// //                   if (value.length < 6) {
// //                     return 'Le mot de passe doit contenir au moins 6 caractères';
// //                   }
// //                   return null;
// //                 },
// //                 onChanged: (value) => password = value,
// //               ),
// //               SizedBox(height: 10),
              
// //               // Confirmation mot de passe
// //               TextFormField(
// //                 decoration: InputDecoration(
// //                   labelText: 'Confirmer le mot de passe',
// //                   border: OutlineInputBorder(),
// //                 ),
// //                 obscureText: true,
// //                 validator: (value) {
// //                   if (value != password) {
// //                     return 'Les mots de passe ne correspondent pas';
// //                   }
// //                   return null;
// //                 },
// //                 onChanged: (value) => confirmPassword = value,
// //               ),
              
// //               SizedBox(height: 15),
              
// //               // Messages
// //               if (errorMessage.isNotEmpty)
// //                 Padding(
// //                   padding: const EdgeInsets.only(bottom: 10.0),
// //                   child: Text(
// //                     errorMessage,
// //                     style: TextStyle(color: Colors.red),
// //                     textAlign: TextAlign.center,
// //                   ),
// //                 ),
                
// //               if (successMessage.isNotEmpty)
// //                 Padding(
// //                   padding: const EdgeInsets.only(bottom: 10.0),
// //                   child: Text(
// //                     successMessage,
// //                     style: TextStyle(color: Colors.green),
// //                     textAlign: TextAlign.center,
// //                   ),
// //                 ),
              
// //               // Bouton d'inscription
// //               ElevatedButton(
// //                 onPressed: isLoading ? null : _registerDoctor,
// //                 child: isLoading
// //                     ? CircularProgressIndicator(color: Colors.white)
// //                     : Text('Ajouter le médecin'),
// //                 style: ElevatedButton.styleFrom(
// //                   padding: EdgeInsets.symmetric(vertical: 12),
// //                   backgroundColor: Theme.of(context).primaryColor,
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   void _registerDoctor() async {
// //     if (_formKey.currentState!.validate()) {
// //       setState(() {
// //         isLoading = true;
// //         errorMessage = '';
// //         successMessage = '';
// //       });
      
// //       try {
// //         // Récupérer l'ID de la clinique connectée
// //         String? cliniqueId = _authService.getCurrentUserId();
        
// //         if (cliniqueId == null) {
// //           throw Exception('Aucune clinique connectée');
// //         }
        
// //         await _authService.registerDoctor(
// //           email: email,
// //           password: password,
// //           nom: nom,
// //           prenom: prenom,
// //           specialite: specialite,
// //           age: age,
// //           cliniqueId: cliniqueId,
// //         );
        
// //         // Réinitialiser le formulaire
// //         _formKey.currentState!.reset();
        
// //         setState(() {
// //           successMessage = 'Le médecin a été ajouté avec succès';
// //           // Réinitialiser les variables
// //           email = '';
// //           password = '';
// //           confirmPassword = '';
// //           nom = '';
// //           prenom = '';
// //           specialite = '';
// //           age = 0;
// //         });
// //       } catch (e) {
// //         setState(() {
// //           errorMessage = e.toString();
// //         });
// //       } finally {
// //         setState(() {
// //           isLoading = false;
// //         });
// //       }
// //     }
// //   }
  
// // }
// import 'package:flutter/material.dart';
// import 'package:mediclic/services/roles.dart';

// class RegisterDoctorWidget extends StatefulWidget {
//   @override
//   _RegisterDoctorWidgetState createState() => _RegisterDoctorWidgetState();
// }

// class _RegisterDoctorWidgetState extends State<RegisterDoctorWidget> {
//   final AuthService _authService = AuthService();
//   final _formKey = GlobalKey<FormState>();

//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _confirmPasswordController = TextEditingController();
//   final TextEditingController _nomController = TextEditingController();
//   final TextEditingController _prenomController = TextEditingController();
//   final TextEditingController _specialiteController = TextEditingController();
//   final TextEditingController _ageController = TextEditingController();

//   bool isLoading = false;
//   String errorMessage = '';
//   String successMessage = '';

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     _confirmPasswordController.dispose();
//     _nomController.dispose();
//     _prenomController.dispose();
//     _specialiteController.dispose();
//     _ageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 4,
//       margin: const EdgeInsets.all(10),
//       child: Padding(
//         padding: const EdgeInsets.all(10),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               const Text(
//                 'Ajouter un nouveau médecin',
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 10),

//               _buildTextField(_nomController, 'Nom', 'Veuillez entrer le nom'),
//               _buildTextField(_prenomController, 'Prénom', 'Veuillez entrer le prénom'),
//               _buildNumberField(_ageController, 'Âge', 'Veuillez entrer un âge valide'),
//               _buildTextField(_specialiteController, 'Spécialité', 'Veuillez entrer la spécialité'),
//               _buildEmailField(),
//               _buildPasswordField(_passwordController, 'Mot de passe'),
//               _buildConfirmPasswordField(),

//               const SizedBox(height: 1),

//               if (errorMessage.isNotEmpty)
//                 Text(errorMessage, style: const TextStyle(color: Colors.red), textAlign: TextAlign.center),
//               if (successMessage.isNotEmpty)
//                 Text(successMessage, style: const TextStyle(color: Colors.green), textAlign: TextAlign.center),

//               const SizedBox(height: 10),

//               ElevatedButton(
//                 onPressed: isLoading ? null : _registerDoctor,
//                 style: ElevatedButton.styleFrom(
//                   padding: const EdgeInsets.symmetric(vertical: 10),
//                   backgroundColor: Theme.of(context).primaryColor,
//                 ),
//                 child: isLoading
//                     ? const CircularProgressIndicator(color: Colors.white)
//                     : const Text('Ajouter le médecin'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField(TextEditingController controller, String label, String errorText) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 10),
//       child: TextFormField(
//         controller: controller,
//         decoration: InputDecoration(
//           labelText: label,
//           border: const OutlineInputBorder(),
//         ),
//         validator: (value) => value == null || value.isEmpty ? errorText : null,
//       ),
//     );
//   }

//   Widget _buildNumberField(TextEditingController controller, String label, String errorText) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 10),
//       child: TextFormField(
//         controller: controller,
//         decoration: InputDecoration(
//           labelText: label,
//           border: const OutlineInputBorder(),
//         ),
//         keyboardType: TextInputType.number,
//         validator: (value) {
//           if (value == null || value.isEmpty) return errorText;
//           final int? age = int.tryParse(value);
//           if (age == null || age <= 0) return errorText;
//           return null;
//         },
//       ),
//     );
//   }

//   Widget _buildEmailField() {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 10),
//       child: TextFormField(
//         controller: _emailController,
//         decoration: const InputDecoration(
//           labelText: 'Email',
//           border: OutlineInputBorder(),
//         ),
//         keyboardType: TextInputType.emailAddress,
//         validator: (value) {
//           if (value == null || value.isEmpty) return 'Veuillez entrer un email';
//           if (!value.contains('@')) return 'Veuillez entrer un email valide';
//           return null;
//         },
//       ),
//     );
//   }

//   Widget _buildPasswordField(TextEditingController controller, String label) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 10),
//       child: TextFormField(
//         controller: controller,
//         decoration: InputDecoration(
//           labelText: label,
//           border: const OutlineInputBorder(),
//         ),
//         obscureText: true,
//         validator: (value) {
//           if (value == null || value.isEmpty) return 'Veuillez entrer un mot de passe';
//           if (value.length < 6) return 'Le mot de passe doit contenir au moins 6 caractères';
//           return null;
//         },
//       ),
//     );
//   }

//   Widget _buildConfirmPasswordField() {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 10),
//       child: TextFormField(
//         controller: _confirmPasswordController,
//         decoration: const InputDecoration(
//           labelText: 'Confirmer le mot de passe',
//           border: OutlineInputBorder(),
//         ),
//         obscureText: true,
//         validator: (value) {
//           if (value != _passwordController.text) return 'Les mots de passe ne correspondent pas';
//           return null;
//         },
//       ),
//     );
//   }

//   void _registerDoctor() async {
//     if (!_formKey.currentState!.validate()) return;

//     setState(() {
//       isLoading = true;
//       errorMessage = '';
//       successMessage = '';
//     });

//     try {
//       String? cliniqueId = _authService.getCurrentUserId();
//       if (cliniqueId == null) throw Exception('Aucune clinique connectée');

//       await _authService.registerDoctor(
//         email: _emailController.text.trim(),
//         password: _passwordController.text.trim(),
//         nom: _nomController.text.trim(),
//         prenom: _prenomController.text.trim(),
//         specialite: _specialiteController.text.trim(),
//         age: int.parse(_ageController.text.trim()),
//         cliniqueId: cliniqueId,
//       );

//       _formKey.currentState!.reset();
//       _emailController.clear();
//       _passwordController.clear();
//       _confirmPasswordController.clear();
//       _nomController.clear();
//       _prenomController.clear();
//       _specialiteController.clear();
//       _ageController.clear();

//       setState(() => successMessage = 'Le médecin a été ajouté avec succès');
//     } catch (e) {
//       setState(() => errorMessage = e.toString());
//     } finally {
//       setState(() => isLoading = false);
//     }
//   }
// }
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mediclic/services/auth_service.dart';

class RegisterClinicWidget extends StatefulWidget {
  @override
  _RegisterClinicWidgetState createState() => _RegisterClinicWidgetState();
}

class _RegisterClinicWidgetState extends State<RegisterClinicWidget> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late GoogleMapController mapController;
  LatLng _selectedLocation = LatLng(6.3640, 2.4234); // Cotonou par défaut

  bool isLoading = false;
  String errorMessage = '';
  String successMessage = '';

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Ajouter une nouvelle clinique',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),

              _buildTextField(_nameController, 'Nom de la clinique', 'Veuillez entrer le nom'),
              _buildTextField(_addressController, 'Adresse', 'Veuillez entrer l\'adresse'),
              _buildTextField(_emailController, 'Email', 'Veuillez entrer l\'email'),
              _buildTextField(_passwordController, 'Mot de passe', 'Veuillez entrer un mot de passe', obscureText: true),

              // Google Map Widget
              SizedBox(
                height: 300,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: _selectedLocation,
                    zoom: 12,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    mapController = controller;
                  },
                  onTap: (LatLng location) {
                    setState(() {
                      _selectedLocation = location;
                    });
                  },
                  markers: {
                    Marker(
                      markerId: MarkerId('clinic_location'),
                      position: _selectedLocation,
                      infoWindow: InfoWindow(title: 'Clinique', snippet: 'Lieu de la clinique'),
                    ),
                  },
                ),
              ),

              const SizedBox(height: 10),

              if (errorMessage.isNotEmpty)
                Text(errorMessage, style: const TextStyle(color: Colors.red), textAlign: TextAlign.center),
              if (successMessage.isNotEmpty)
                Text(successMessage, style: const TextStyle(color: Colors.green), textAlign: TextAlign.center),

              const SizedBox(height: 10),

              ElevatedButton(
                onPressed: isLoading ? null : _registerClinic,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Ajouter la clinique'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, String errorText, {bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: (value) => value == null || value.isEmpty ? errorText : null,
      ),
    );
  }

  void _registerClinic() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
      errorMessage = '';
      successMessage = '';
    });

    try {
      String? result = await _authService.registerClinic(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        nomClinique: _nameController.text.trim(),
        latitude: _selectedLocation.latitude,
        longitude: _selectedLocation.longitude,
      );

      if (result == null) {
        _formKey.currentState!.reset();
        _nameController.clear();
        _addressController.clear();
        _emailController.clear();
        _passwordController.clear();

        setState(() => successMessage = 'La clinique a été ajoutée avec succès');
      } else {
        setState(() => errorMessage = result);
      }
    } catch (e) {
      setState(() => errorMessage = "Erreur : ${e.toString()}");
    } finally {
      setState(() => isLoading = false);
    }
  }
}
