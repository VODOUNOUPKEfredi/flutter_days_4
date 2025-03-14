// // import 'package:flutter/material.dart';
// // import '../services/auth_service.dart';

// // class LoginPage extends StatefulWidget {
// //   @override
// //   _LoginPageState createState() => _LoginPageState();
// // }

// // class _LoginPageState extends State<LoginPage> {
// //   final AuthService _authService = AuthService();
// //   final _formKey = GlobalKey<FormState>();
  
// //   String email = '';
// //   String password = '';
// //   bool isLoading = false;
// //   String errorMessage = '';
// //   bool _showPassword = false;

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.grey[50],
// //       body: SafeArea(
// //         child: SingleChildScrollView(
// //           child: Padding(
// //             padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
// //             child: Form(
// //               key: _formKey,
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.stretch,
// //                 children: [
// //                   // Logo ou icône de l'application
// //                   Center(
// //                     child: Container(
// //                       height: 100,
// //                       width: 100,
// //                       decoration: BoxDecoration(
// //                         color: Theme.of(context).primaryColor.withOpacity(0.1),
// //                         shape: BoxShape.circle,
// //                       ),
// //                       child: Icon(
// //                         Icons.medical_services,
// //                         size: 50,
// //                         color: Theme.of(context).primaryColor,
// //                       ),
// //                     ),
// //                   ),
// //                   SizedBox(height: 30),
                  
// //                   // Titre
// //                   Text(
// //                     'Bienvenue',
// //                     style: TextStyle(
// //                       fontSize: 32, 
// //                       fontWeight: FontWeight.bold,
// //                       color: Theme.of(context).primaryColor,
// //                     ),
// //                     textAlign: TextAlign.center,
// //                   ),
// //                   SizedBox(height: 10),
                  
// //                   // Sous-titre
// //                   Text(
// //                     'Connectez-vous pour continuer',
// //                     style: TextStyle(
// //                       fontSize: 16,
// //                       color: Colors.grey[600],
// //                     ),
// //                     textAlign: TextAlign.center,
// //                   ),
// //                   SizedBox(height: 40),
                  
// //                   // Email
// //                   TextFormField(
// //                     decoration: InputDecoration(
// //                       labelText: 'Email',
// //                       hintText: 'exemple@email.com',
// //                       border: OutlineInputBorder(
// //                         borderRadius: BorderRadius.circular(12),
// //                         borderSide: BorderSide.none,
// //                       ),
// //                       filled: true,
// //                       fillColor: Colors.grey[200],
// //                       prefixIcon: Icon(Icons.email, color: Theme.of(context).primaryColor),
// //                       contentPadding: EdgeInsets.symmetric(vertical: 16),
// //                     ),
// //                     keyboardType: TextInputType.emailAddress,
// //                     validator: (value) {
// //                       if (value == null || value.isEmpty) {
// //                         return 'Veuillez entrer un email';
// //                       }
// //                       if (!value.contains('@')) {
// //                         return 'Veuillez entrer un email valide';
// //                       }
// //                       return null;
// //                     },
// //                     onChanged: (value) => email = value.trim(),
// //                   ),
// //                   SizedBox(height: 20),
                  
// //                   // Mot de passe
// //                   TextFormField(
// //                     decoration: InputDecoration(
// //                       labelText: 'Mot de passe',
// //                       hintText: '••••••••',
// //                       border: OutlineInputBorder(
// //                         borderRadius: BorderRadius.circular(12),
// //                         borderSide: BorderSide.none,
// //                       ),
// //                       filled: true,
// //                       fillColor: Colors.grey[200],
// //                       prefixIcon: Icon(Icons.lock, color: Theme.of(context).primaryColor),
// //                       suffixIcon: IconButton(
// //                         icon: Icon(
// //                           _showPassword ? Icons.visibility : Icons.visibility_off,
// //                           color: Colors.grey[600],
// //                         ),
// //                         onPressed: () {
// //                           setState(() {
// //                             _showPassword = !_showPassword;
// //                           });
// //                         },
// //                       ),
// //                       contentPadding: EdgeInsets.symmetric(vertical: 16),
// //                     ),
// //                     obscureText: !_showPassword,
// //                     validator: (value) {
// //                       if (value == null || value.isEmpty) {
// //                         return 'Veuillez entrer un mot de passe';
// //                       }
// //                       return null;
// //                     },
// //                     onChanged: (value) => password = value,
// //                   ),
// //                   SizedBox(height: 12),
                  
// //                   // Mot de passe oublié
// //                   Align(
// //                     alignment: Alignment.centerRight,
// //                     child: TextButton(
// //                       onPressed: () {
// //                         // Implémenter la fonctionnalité mot de passe oublié
// //                       },
// //                       child: Text(
// //                         'Mot de passe oublié?',
// //                         style: TextStyle(
// //                           color: Theme.of(context).primaryColor,
// //                           fontWeight: FontWeight.w500,
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                   SizedBox(height: 20),
                  
// //                   // Message d'erreur
// //                   if (errorMessage.isNotEmpty)
// //                     Container(
// //                       padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
// //                       decoration: BoxDecoration(
// //                         color: Colors.red[50],
// //                         borderRadius: BorderRadius.circular(8),
// //                         border: Border.all(color: Colors.red[200]!),
// //                       ),
// //                       child: Row(
// //                         children: [
// //                           Icon(Icons.error_outline, color: Colors.red),
// //                           SizedBox(width: 12),
// //                           Expanded(
// //                             child: Text(
// //                               errorMessage,
// //                               style: TextStyle(color: Colors.red[700]),
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                     ),
                  
// //                   SizedBox(height: 30),
                  
// //                   // Bouton de connexion
// //                   ElevatedButton(
// //                     onPressed: isLoading ? null : _login,
// //                     child: isLoading
// //                         ? Row(
// //                             mainAxisAlignment: MainAxisAlignment.center,
// //                             children: [
// //                               SizedBox(
// //                                 width: 20,
// //                                 height: 20,
// //                                 child: CircularProgressIndicator(
// //                                   color: Colors.white,
// //                                   strokeWidth: 2,
// //                                 ),
// //                               ),
// //                               SizedBox(width: 12),
// //                               Text(
// //                                 'Connexion en cours...',
// //                                 style: TextStyle(
// //                                   fontSize: 16,
// //                                   fontWeight: FontWeight.bold,
// //                                 ),
// //                               ),
// //                             ],
// //                           )
// //                         : Text(
// //                             'Se connecter',
// //                             style: TextStyle(
// //                               fontSize: 16,
// //                               fontWeight: FontWeight.bold,
// //                             ),
// //                           ),
// //                     style: ElevatedButton.styleFrom(
// //                       foregroundColor: Colors.white, 
// //                       backgroundColor: Theme.of(context).primaryColor,
// //                       padding: EdgeInsets.symmetric(vertical: 16),
// //                       shape: RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.circular(12),
// //                       ),
// //                       elevation: 2,
// //                     ),
// //                   ),
                  
// //                   SizedBox(height: 24),
                  
// //                   // Séparateur
// //                   Row(
// //                     children: [
// //                       Expanded(child: Divider(thickness: 1)),
// //                       Padding(
// //                         padding: const EdgeInsets.symmetric(horizontal: 16),
// //                         child: Text(
// //                           'OU',
// //                           style: TextStyle(
// //                             color: Colors.grey[600],
// //                             fontWeight: FontWeight.w500,
// //                           ),
// //                         ),
// //                       ),
// //                       Expanded(child: Divider(thickness: 1)),
// //                     ],
// //                   ),
                  
// //                   SizedBox(height: 24),
                  
// //                   // Lien vers la page d'inscription
// //                   Row(
// //                     mainAxisAlignment: MainAxisAlignment.center,
// //                     children: [
// //                       Text(
// //                         'Pas encore inscrit?',
// //                         style: TextStyle(color: Colors.grey[600]),
// //                       ),
// //                       TextButton(
// //                         onPressed: () => Navigator.pushReplacementNamed(context, '/register'),
// //                         child: Text(
// //                           'Créer un compte',
// //                           style: TextStyle(
// //                             color: Theme.of(context).primaryColor,
// //                             fontWeight: FontWeight.bold,
// //                           ),
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   Future<void> _login() async {
// //     // Vérifier que le formulaire est valide
// //     if (_formKey.currentState?.validate() ?? false) {
// //       setState(() {
// //         isLoading = true;
// //         errorMessage = '';
// //       });
      
// //       try {
// //         print("Tentative de connexion avec: $email / ${password.length} caractères");
        
// //         // Se connecter et récupérer les informations de l'utilisateur, y compris son rôle
// //         final userInfo = await _authService.signIn(
// //           email: email,
// //           password: password,
// //         );
        
// //         // Vérifier si userInfo contient les données nécessaires
// //         if (userInfo == null || !userInfo.containsKey('role') || userInfo['role'] == null) {
// //           throw Exception("Informations utilisateur incomplètes ou rôle manquant");
// //         }
        
// //         final role = userInfo['role'].toString();
// //         print("Connexion réussie. Rôle: '$role'");
        
// //         // Vérifier explicitement le rôle avant la redirection
// //         if (role.trim().isEmpty) {
// //           throw Exception("Rôle utilisateur vide");
// //         }
        
// //         // Afficher un message de succès
// //         if (mounted) {
// //           ScaffoldMessenger.of(context).showSnackBar(
// //             SnackBar(
// //               content: Text('Connexion réussie!'),
// //               backgroundColor: Colors.green,
// //               duration: Duration(seconds: 2),
// //             ),
// //           );
          
// //           // Attendre que le snackbar s'affiche avant de naviguer
// //           await Future.delayed(Duration(milliseconds: 500));
          
// //           // Rediriger vers la HomeScreen
// //           if (mounted) {
// //             Navigator.pushReplacementNamed(context, '/home');
// //           }
// //         }
// //       } catch (e) {
// //         print("Erreur de connexion: $e");
// //         setState(() {
// //           errorMessage = e.toString();
// //           // Supprimer "Exception: " du message d'erreur pour une meilleure présentation
// //           if (errorMessage.startsWith('Exception: ')) {
// //             errorMessage = errorMessage.substring('Exception: '.length);
// //           }
// //         });
// //       } finally {
// //         if (mounted) {
// //           setState(() {
// //             isLoading = false;
// //           });
// //         }
// //       }
// //     }
// //   }
// // }
// import 'package:flutter/material.dart';
// import '../services/auth_service.dart';

// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final AuthService _authService = AuthService();
//   final _formKey = GlobalKey<FormState>();
  
//   String email = '';
//   String password = '';
//   bool isLoading = false;
//   String errorMessage = '';
//   bool _showPassword = false;

//   @override
//   Widget build(BuildContext context) {
//     // Le reste du code de build reste inchangé
//     // (Garder tout le code d'interface utilisateur que vous aviez)
//     return Scaffold(
//       // Votre code UI existant
//       backgroundColor: Colors.grey[50],
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   // Logo ou icône de l'application
//                   Center(
//                     child: Container(
//                       height: 100,
//                       width: 100,
//                       decoration: BoxDecoration(
//                         color: Theme.of(context).primaryColor.withOpacity(0.1),
//                         shape: BoxShape.circle,
//                       ),
//                       child: Icon(
//                         Icons.medical_services,
//                         size: 50,
//                         color: Theme.of(context).primaryColor,
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 30),
                  
//                   // Titre
//                   Text(
//                     'Bienvenue',
//                     style: TextStyle(
//                       fontSize: 32, 
//                       fontWeight: FontWeight.bold,
//                       color: Theme.of(context).primaryColor,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   SizedBox(height: 10),
                  
//                   // Sous-titre
//                   Text(
//                     'Connectez-vous pour continuer',
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.grey[600],
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   SizedBox(height: 40),
                  
//                   // Email
//                   TextFormField(
//                     decoration: InputDecoration(
//                       labelText: 'Email',
//                       hintText: 'exemple@email.com',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide.none,
//                       ),
//                       filled: true,
//                       fillColor: Colors.grey[200],
//                       prefixIcon: Icon(Icons.email, color: Theme.of(context).primaryColor),
//                       contentPadding: EdgeInsets.symmetric(vertical: 16),
//                     ),
//                     keyboardType: TextInputType.emailAddress,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Veuillez entrer un email';
//                       }
//                       if (!value.contains('@')) {
//                         return 'Veuillez entrer un email valide';
//                       }
//                       return null;
//                     },
//                     onChanged: (value) => email = value.trim(),
//                   ),
//                   SizedBox(height: 20),
                  
//                   // Mot de passe
//                   TextFormField(
//                     decoration: InputDecoration(
//                       labelText: 'Mot de passe',
//                       hintText: '••••••••',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide.none,
//                       ),
//                       filled: true,
//                       fillColor: Colors.grey[200],
//                       prefixIcon: Icon(Icons.lock, color: Theme.of(context).primaryColor),
//                       suffixIcon: IconButton(
//                         icon: Icon(
//                           _showPassword ? Icons.visibility : Icons.visibility_off,
//                           color: Colors.grey[600],
//                         ),
//                         onPressed: () {
//                           setState(() {
//                             _showPassword = !_showPassword;
//                           });
//                         },
//                       ),
//                       contentPadding: EdgeInsets.symmetric(vertical: 16),
//                     ),
//                     obscureText: !_showPassword,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Veuillez entrer un mot de passe';
//                       }
//                       return null;
//                     },
//                     onChanged: (value) => password = value,
//                   ),
//                   SizedBox(height: 12),
                  
//                   // Mot de passe oublié
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: TextButton(
//                       onPressed: () {
//                         // Implémenter la fonctionnalité mot de passe oublié
//                       },
//                       child: Text(
//                         'Mot de passe oublié?',
//                         style: TextStyle(
//                           color: Theme.of(context).primaryColor,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 20),
                  
//                   // Message d'erreur
//                   if (errorMessage.isNotEmpty)
//                     Container(
//                       padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//                       decoration: BoxDecoration(
//                         color: Colors.red[50],
//                         borderRadius: BorderRadius.circular(8),
//                         border: Border.all(color: Colors.red[200]!),
//                       ),
//                       child: Row(
//                         children: [
//                           Icon(Icons.error_outline, color: Colors.red),
//                           SizedBox(width: 12),
//                           Expanded(
//                             child: Text(
//                               errorMessage,
//                               style: TextStyle(color: Colors.red[700]),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
                  
//                   SizedBox(height: 30),
                  
//                   // Bouton de connexion
//                   ElevatedButton(
//                     onPressed: isLoading ? null : _login,
//                     style: ElevatedButton.styleFrom(
//                       foregroundColor: Colors.white, 
//                       backgroundColor: Theme.of(context).primaryColor,
//                       padding: EdgeInsets.symmetric(vertical: 16),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       elevation: 2,
//                     ),
//                     child: isLoading
//                         ? Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               SizedBox(
//                                 width: 20,
//                                 height: 20,
//                                 child: CircularProgressIndicator(
//                                   color: Colors.white,
//                                   strokeWidth: 2,
//                                 ),
//                               ),
//                               SizedBox(width: 12),
//                               Text(
//                                 'Connexion en cours...',
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           )
//                         : Text(
//                             'Se connecter',
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                   ),
                  
//                   SizedBox(height: 24),
                  
//                   // Séparateur
//                   Row(
//                     children: [
//                       Expanded(child: Divider(thickness: 1)),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 16),
//                         child: Text(
//                           'OU',
//                           style: TextStyle(
//                             color: Colors.grey[600],
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ),
//                       Expanded(child: Divider(thickness: 1)),
//                     ],
//                   ),
                  
//                   SizedBox(height: 24),
                  
//                   // Lien vers la page d'inscription
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         'Pas encore inscrit?',
//                         style: TextStyle(color: Colors.grey[600]),
//                       ),
//                       TextButton(
//                         onPressed: () => Navigator.pushReplacementNamed(context, '/register'),
//                         child: Text(
//                           'Créer un compte',
//                           style: TextStyle(
//                             color: Theme.of(context).primaryColor,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> _login() async {
//     // Vérifier que le formulaire est valide
//     if (_formKey.currentState?.validate() ?? false) {
//       setState(() {
//         isLoading = true;
//         errorMessage = '';
//       });
      
//       try {
//         print("Tentative de connexion avec: $email");
        
//         // Se connecter et récupérer les informations de l'utilisateur, y compris son rôle
//         final userInfo = await _authService.signIn(
//           email: email,
//           password: password,
//         );
        
//         print("Réponse de signIn: $userInfo");
        
//         // Vérifier si userInfo contient les données nécessaires
//         if (userInfo == null) {
//           throw Exception("Aucune information utilisateur retournée");
//         }
        
//         final role = userInfo['role']?.toString() ?? 'unknown';
//         print("Connexion réussie. Rôle: '$role'");
        
//         // Afficher un message de succès
//         if (mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text('Connexion réussie! Rôle: $role'),
//               backgroundColor: Colors.green,
//               duration: Duration(seconds: 2),
//             ),
//           );
//         }
        
//         // Utiliser Future.delayed pour s'assurer que setState est appelé correctement
//         await Future.delayed(Duration(milliseconds: 500));
        
//         // Rediriger vers la page d'accueil appropriée
//         if (mounted) {
//           print("Navigation vers /home");
//           Navigator.of(context).pushReplacementNamed('/home');
//         }
//       } catch (e) {
//         print("Erreur de connexion: $e");
//         if (mounted) {
//           setState(() {
//             errorMessage = e.toString();
//             // Supprimer "Exception: " du message d'erreur pour une meilleure présentation
//             if (errorMessage.startsWith('Exception: ')) {
//               errorMessage = errorMessage.substring('Exception: '.length);
//             }
//           });
//         }
//       } finally {
//         if (mounted) {
//           setState(() {
//             isLoading = false;
//           });
//         }
//       }
//     }
//   }
// }
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mediclic/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();
  String email = '';
  String password = '';
  String errorMessage = '';
  bool isLoading = false;

  Future<void> _signIn() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
        errorMessage = '';
      });

      try {
        // Connexion avec Firebase Auth
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.trim(),
          password: password,
        );

        if (!mounted) return;

        // Après connexion réussie, naviguer vers la page d'accueil
        Navigator.pushReplacementNamed(context, '/home');
      } on FirebaseAuthException catch (e) {
        setState(() {
          if (e.code == 'user-not-found') {
            errorMessage = 'Aucun utilisateur trouvé avec cet email.';
          } else if (e.code == 'wrong-password') {
            errorMessage = 'Mot de passe incorrect.';
          } else {
            errorMessage = 'Erreur de connexion: ${e.message}';
          }
        });
      } catch (e) {
        setState(() {
          errorMessage = 'Une erreur est survenue: $e';
        });
      } finally {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'MediClic',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(height: 40),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer votre email';
                    }
                    return null;
                  },
                  onChanged: (value) => email = value,
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Mot de passe',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer votre mot de passe';
                    }
                    return null;
                  },
                  onChanged: (value) => password = value,
                ),
                SizedBox(height: 10),
                if (errorMessage.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      errorMessage,
                      style: TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: isLoading ? null : _signIn,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    child: isLoading
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text('Se connecter', style: TextStyle(fontSize: 16)),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}