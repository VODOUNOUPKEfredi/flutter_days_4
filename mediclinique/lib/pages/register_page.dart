
// import 'package:flutter/material.dart';
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
//                   onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
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
//         // Enregistre la clinique et récupère le résultat
//         final userInfo = await _authService.registerClinic(
//           email: email,
//           password: password,
//           nomClinique: nomClinique,
//           latitude: localisation!.latitude,
//           longitude: localisation!.longitude,
//         );
        
//         // Affiche un message de succès
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Inscription réussie! Veuillez vous connecter'),
//             backgroundColor: Colors.green,
//           ),
//         );
        
//         // Rediriger vers la page de connexion après inscription réussie
//         Navigator.pushReplacementNamed(context, '/login');
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
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Inscription Clinique'),
        elevation: 0,
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              theme.colorScheme.primary.withOpacity(0.05),
              theme.colorScheme.background,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // En-tête
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      'Créer un compte Clinique',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 24),
                  
                  // Informations de la clinique
                  Card(
                    elevation: 2,
                    margin: EdgeInsets.only(bottom: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Informations de la clinique',
                            style: theme.textTheme.titleMedium,
                          ),
                          SizedBox(height: 16),
                          
                          // Nom de la clinique
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Nom de la clinique',
                              prefixIcon: Icon(Icons.business),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              filled: true,
                              fillColor: theme.colorScheme.surface,
                            ),
                            validator: (value) => value!.isEmpty ? 'Veuillez entrer le nom de la clinique' : null,
                            onChanged: (value) => nomClinique = value,
                          ),
                          SizedBox(height: 16),
                          
                          // Email
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Email',
                              prefixIcon: Icon(Icons.email),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              filled: true,
                              fillColor: theme.colorScheme.surface,
                            ),
                            keyboardType: TextInputType.emailAddress,
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
                          SizedBox(height: 16),
                          
                          // Mot de passe
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Mot de passe',
                              prefixIcon: Icon(Icons.lock),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              filled: true,
                              fillColor: theme.colorScheme.surface,
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
                          SizedBox(height: 16),
                          
                          // Confirmation mot de passe
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Confirmer le mot de passe',
                              prefixIcon: Icon(Icons.lock_outline),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              filled: true,
                              fillColor: theme.colorScheme.surface,
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
                        ],
                      ),
                    ),
                  ),
                  
                  // Carte pour la localisation
                  Card(
                    elevation: 2,
                    margin: EdgeInsets.only(bottom: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Localisation de la clinique',
                            style: theme.textTheme.titleMedium,
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Appuyez sur la carte pour sélectionner l\'emplacement de votre clinique',
                            style: theme.textTheme.bodySmall,
                          ),
                          SizedBox(height: 16),
                          
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              height: 250,
                              decoration: BoxDecoration(
                                border: Border.all(color: theme.dividerColor),
                                borderRadius: BorderRadius.circular(12),
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
                                            color: theme.colorScheme.primary,
                                            size: 40,
                                          ),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                            ),
                          ),
                          
                          if (localisation != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: Row(
                                children: [
                                  Icon(Icons.check_circle, color: Colors.green, size: 18),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      'Localisation sélectionnée: ${localisation!.latitude.toStringAsFixed(4)}, ${localisation!.longitude.toStringAsFixed(4)}',
                                      style: theme.textTheme.bodySmall,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  
                  // Message d'erreur
                  if (errorMessage.isNotEmpty)
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      margin: EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        border: Border.all(color: Colors.red.shade200),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.error_outline, color: Colors.red),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              errorMessage,
                              style: TextStyle(color: Colors.red.shade700),
                            ),
                          ),
                        ],
                      ),
                    ),
                  
                  // Bouton d'inscription
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: isLoading || localisation == null ? null : _register,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary,
                        foregroundColor: theme.colorScheme.onPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: isLoading
                          ? SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: theme.colorScheme.onPrimary,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                              'Inscrire la clinique',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                  
                  SizedBox(height: 20),
                  
                  // Lien vers la page de connexion
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Déjà inscrit?'),
                      TextButton(
                        onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
                        child: Text('Se connecter'),
                        style: TextButton.styleFrom(
                          foregroundColor: theme.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
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
        await _authService.registerClinic(
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
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.all(12),
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