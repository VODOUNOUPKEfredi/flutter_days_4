// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';
// import '../services/auth_service.dart';

// class RegisterPage extends StatefulWidget {
//   @override
//   _RegisterPageState createState() => _RegisterPageState();
// }

// class _RegisterPageState extends State<RegisterPage> {
//   final AuthService _authService = AuthService();
//   final _formKey = GlobalKey<FormState>();
//   final MapController _mapController = MapController();
  
//   String email = '';
//   String password = '';
//   String confirmPassword = '';
//   String nomClinique = '';
//   LatLng? localisation;
  
//   bool isLoading = false;
//   String errorMessage = '';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Inscription Clinique'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(16.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Text(
//                   'Créer un compte Clinique',
//                   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                   textAlign: TextAlign.center,
//                 ),
//                 SizedBox(height: 20),
                
//                 // Nom de la clinique
//                 TextFormField(
//                   decoration: InputDecoration(
//                     labelText: 'Nom de la clinique',
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (value) => value!.isEmpty ? 'Veuillez entrer le nom de la clinique' : null,
//                   onChanged: (value) => nomClinique = value,
//                 ),
//                 SizedBox(height: 10),
                
//                 // Email
//                 TextFormField(
//                   decoration: InputDecoration(
//                     labelText: 'Email',
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Veuillez entrer un email';
//                     }
//                     if (!value.contains('@')) {
//                       return 'Veuillez entrer un email valide';
//                     }
//                     return null;
//                   },
//                   onChanged: (value) => email = value,
//                 ),
//                 SizedBox(height: 10),
                
//                 // Mot de passe
//                 TextFormField(
//                   decoration: InputDecoration(
//                     labelText: 'Mot de passe',
//                     border: OutlineInputBorder(),
//                   ),
//                   obscureText: true,
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Veuillez entrer un mot de passe';
//                     }
//                     if (value.length < 6) {
//                       return 'Le mot de passe doit contenir au moins 6 caractères';
//                     }
//                     return null;
//                   },
//                   onChanged: (value) => password = value,
//                 ),
//                 SizedBox(height: 10),
                
//                 // Confirmation mot de passe
//                 TextFormField(
//                   decoration: InputDecoration(
//                     labelText: 'Confirmer le mot de passe',
//                     border: OutlineInputBorder(),
//                   ),
//                   obscureText: true,
//                   validator: (value) {
//                     if (value != password) {
//                       return 'Les mots de passe ne correspondent pas';
//                     }
//                     return null;
//                   },
//                   onChanged: (value) => confirmPassword = value,
//                 ),
//                 SizedBox(height: 20),
                
//                 // Carte pour sélectionner la localisation
//                 Text(
//                   'Sélectionnez la localisation de votre clinique',
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(height: 10),
                
//                 Container(
//                   height: 300,
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.grey),
//                     borderRadius: BorderRadius.circular(4),
//                   ),
//                   child: FlutterMap(
//                     mapController: _mapController,
//                     options: MapOptions(
//                       initialCenter: LatLng(48.8566, 2.3522), // Paris par défaut
//                       initialZoom: 13.0,
//                       onTap: (tapPosition, point) {
//                         setState(() {
//                           localisation = point;
//                         });
//                       },
//                     ),
//                     children: [
//                       TileLayer(
//                         urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
//                         userAgentPackageName: 'com.example.app',
//                       ),
//                       if (localisation != null)
//                         MarkerLayer(
//                           markers: [
//                             Marker(
//                               width: 80.0,
//                               height: 80.0,
//                               point: localisation!,
//                               child: Icon(
//                                 Icons.location_on,
//                                 color: Colors.red,
//                                 size: 40,
//                               ),
//                             ),
//                           ],
//                         ),
//                     ],
//                   ),
//                 ),
                
//                 if (localisation != null)
//                   Padding(
//                     padding: const EdgeInsets.only(top: 8.0),
//                     child: Text(
//                       'Localisation sélectionnée: ${localisation!.latitude.toStringAsFixed(4)}, ${localisation!.longitude.toStringAsFixed(4)}',
//                       style: TextStyle(fontStyle: FontStyle.italic),
//                     ),
//                   ),
                
//                 SizedBox(height: 20),
                
//                 // Message d'erreur
//                 if (errorMessage.isNotEmpty)
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 10.0),
//                     child: Text(
//                       errorMessage,
//                       style: TextStyle(color: Colors.red),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
                
//                 // Bouton d'inscription
//                 ElevatedButton(
//                   onPressed: isLoading || localisation == null ? null : _register,
//                   child: isLoading
//                       ? CircularProgressIndicator(color: Colors.white)
//                       : Text('Inscrire la clinique'),
//                   style: ElevatedButton.styleFrom(
//                     padding: EdgeInsets.symmetric(vertical: 12),
//                   ),
//                 ),
                
//                 SizedBox(height: 15),
                
//                 // Lien vers la page de connexion
//                 TextButton(
//                   onPressed: () => Navigator.pop(context),
//                   child: Text('Déjà inscrit? Connectez-vous'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void _register() async {
//     if (_formKey.currentState!.validate() && localisation != null) {
//       setState(() {
//         isLoading = true;
//         errorMessage = '';
//       });
      
//       try {
//         await _authService.registerClinic(
//           email: email,
//           password: password,
//           nomClinique: nomClinique,
//           latitude: localisation!.latitude,
//           longitude: localisation!.longitude,
//         );
        
//         // Naviguer vers la page d'accueil après inscription réussie
//         Navigator.pushReplacementNamed(context, '/');
//       } catch (e) {
//         setState(() {
//           errorMessage = e.toString();
//         });
//       } finally {
//         setState(() {
//           isLoading = false;
//         });
//       }
//     } else if (localisation == null) {
//       setState(() {
//         errorMessage = 'Veuillez sélectionner la localisation de votre clinique sur la carte';
//       });
//     }
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  final MapController _mapController = MapController();
  
  String email = '';
  String password = '';
  String confirmPassword = '';
  String nomClinique = '';
  LatLng? localisation;
  
  bool isLoading = false;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inscription Clinique'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Créer un compte Clinique',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                
                // Nom de la clinique
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Nom de la clinique',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value!.isEmpty ? 'Veuillez entrer le nom de la clinique' : null,
                  onChanged: (value) => nomClinique = value,
                ),
                SizedBox(height: 10),
                
                // Email
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Veuillez entrer un email';
                    }
                    if (!value.contains('@')) {
                      return 'Veuillez entrer un email valide';
                    }
                    return null;
                  },
                  onChanged: (value) => email = value,
                ),
                SizedBox(height: 10),
                
                // Mot de passe
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Mot de passe',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Veuillez entrer un mot de passe';
                    }
                    if (value.length < 6) {
                      return 'Le mot de passe doit contenir au moins 6 caractères';
                    }
                    return null;
                  },
                  onChanged: (value) => password = value,
                ),
                SizedBox(height: 10),
                
                // Confirmation mot de passe
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Confirmer le mot de passe',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value != password) {
                      return 'Les mots de passe ne correspondent pas';
                    }
                    return null;
                  },
                  onChanged: (value) => confirmPassword = value,
                ),
                SizedBox(height: 20),
                
                // Carte pour sélectionner la localisation
                Text(
                  'Sélectionnez la localisation de votre clinique',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                      initialCenter: LatLng(48.8566, 2.3522), // Paris par défaut
                      initialZoom: 13.0,
                      onTap: (tapPosition, point) {
                        setState(() {
                          localisation = point;
                        });
                      },
                    ),
                    children: [
                      TileLayer(
                        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.example.app',
                      ),
                      if (localisation != null)
                        MarkerLayer(
                          markers: [
                            Marker(
                              width: 80.0,
                              height: 80.0,
                              point: localisation!,
                              child: Icon(
                                Icons.location_on,
                                color: Colors.red,
                                size: 40,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
                
                if (localisation != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Localisation sélectionnée: ${localisation!.latitude.toStringAsFixed(4)}, ${localisation!.longitude.toStringAsFixed(4)}',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                
                SizedBox(height: 20),
                
                // Message d'erreur
                if (errorMessage.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      errorMessage,
                      style: TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ),
                
                // Bouton d'inscription
                ElevatedButton(
                  onPressed: isLoading || localisation == null ? null : _register,
                  child: isLoading
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text('Inscrire la clinique'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
                
                SizedBox(height: 15),
                
                // Lien vers la page de connexion
                TextButton(
                  onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
                  child: Text('Déjà inscrit? Connectez-vous'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _register() async {
    if (_formKey.currentState!.validate() && localisation != null) {
      setState(() {
        isLoading = true;
        errorMessage = '';
      });
      
      try {
        // Enregistre la clinique et récupère le résultat
        // Supposons que registerClinic retourne maintenant un Map avec des informations sur l'utilisateur
        final userInfo = await _authService.registerClinic(
          email: email,
          password: password,
          nomClinique: nomClinique,
          latitude: localisation!.latitude,
          longitude: localisation!.longitude,
        );
        
        // Affiche un message de succès
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Inscription réussie! Veuillez vous connecter'),
            backgroundColor: Colors.green,
          ),
        );
        
        // Rediriger vers la page de connexion après inscription réussie
        Navigator.pushReplacementNamed(context, '/login');
      } catch (e) {
        setState(() {
          errorMessage = e.toString();
        });
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    } else if (localisation == null) {
      setState(() {
        errorMessage = 'Veuillez sélectionner la localisation de votre clinique sur la carte';
      });
    }
  }
}