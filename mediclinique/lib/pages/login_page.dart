
// // import 'package:flutter/material.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:mediclic/services/auth_service.dart';

// // class LoginScreen extends StatefulWidget {
// //   @override
// //   _LoginScreenState createState() => _LoginScreenState();
// // }

// // class _LoginScreenState extends State<LoginScreen> {
// //   final _formKey = GlobalKey<FormState>();
// //   final AuthService _authService = AuthService();
// //   String email = '';
// //   String password = '';
// //   String errorMessage = '';
// //   bool isLoading = false;

// //   Future<void> _signIn() async {
// //     if (_formKey.currentState!.validate()) {
// //       setState(() {
// //         isLoading = true;
// //         errorMessage = '';
// //       });

// //       try {
// //         // Connexion avec Firebase Auth
// //         await FirebaseAuth.instance.signInWithEmailAndPassword(
// //           email: email.trim(),
// //           password: password,
// //         );

// //         if (!mounted) return;

// //         // Après connexion réussie, naviguer vers la page d'accueil
// //         Navigator.pushReplacementNamed(context, '/home');
// //       } on FirebaseAuthException catch (e) {
// //         setState(() {
// //           if (e.code == 'user-not-found') {
// //             errorMessage = 'Aucun utilisateur trouvé avec cet email.';
// //           } else if (e.code == 'wrong-password') {
// //             errorMessage = 'Mot de passe incorrect.';
// //           } else {
// //             errorMessage = 'Erreur de connexion: ${e.message}';
// //           }
// //         });
// //       } catch (e) {
// //         setState(() {
// //           errorMessage = 'Une erreur est survenue: $e';
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

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Center(
// //         child: SingleChildScrollView(
// //           padding: const EdgeInsets.all(24.0),
// //           child: Form(
// //             key: _formKey,
// //             child: Column(
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               children: [
// //                 Text(
// //                   'MediClic',
// //                   style: TextStyle(
// //                     fontSize: 28,
// //                     fontWeight: FontWeight.bold,
// //                     color: Theme.of(context).primaryColor,
// //                   ),
// //                 ),
// //                 SizedBox(height: 40),
// //                 TextFormField(
// //                   decoration: InputDecoration(
// //                     labelText: 'Email',
// //                     border: OutlineInputBorder(),
// //                     prefixIcon: Icon(Icons.email),
// //                   ),
// //                   keyboardType: TextInputType.emailAddress,
// //                   validator: (value) {
// //                     if (value == null || value.isEmpty) {
// //                       return 'Veuillez entrer votre email';
// //                     }
// //                     return null;
// //                   },
// //                   onChanged: (value) => email = value,
// //                 ),
// //                 SizedBox(height: 20),
// //                 TextFormField(
// //                   decoration: InputDecoration(
// //                     labelText: 'Mot de passe',
// //                     border: OutlineInputBorder(),
// //                     prefixIcon: Icon(Icons.lock),
// //                   ),
// //                   obscureText: true,
// //                   validator: (value) {
// //                     if (value == null || value.isEmpty) {
// //                       return 'Veuillez entrer votre mot de passe';
// //                     }
// //                     return null;
// //                   },
// //                   onChanged: (value) => password = value,
// //                 ),
// //                 SizedBox(height: 10),
// //                 if (errorMessage.isNotEmpty)
// //                   Padding(
// //                     padding: const EdgeInsets.only(bottom: 10.0),
// //                     child: Text(
// //                       errorMessage,
// //                       style: TextStyle(color: Colors.red),
// //                       textAlign: TextAlign.center,
// //                     ),
// //                   ),
// //                 SizedBox(height: 20),
// //                 ElevatedButton(
// //                   onPressed: isLoading ? null : _signIn,
// //                   child: Padding(
// //                     padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
// //                     child: isLoading
// //                         ? CircularProgressIndicator(color: Colors.white)
// //                         : Text('Se connecter', style: TextStyle(fontSize: 16)),
// //                   ),
// //                   style: ElevatedButton.styleFrom(
// //                     shape: RoundedRectangleBorder(
// //                       borderRadius: BorderRadius.circular(8),
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:mediclic/services/auth_service.dart';

// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final AuthService _authService = AuthService();
//   String email = '';
//   String password = '';
//   String errorMessage = '';
//   bool isLoading = false;

//   Future<void> _signIn() async {
//     if (_formKey.currentState!.validate()) {
//       setState(() {
//         isLoading = true;
//         errorMessage = '';
//       });

//       try {
//         // Connexion avec Firebase Auth
//         await FirebaseAuth.instance.signInWithEmailAndPassword(
//           email: email.trim(),
//           password: password,
//         );

//         if (!mounted) return;

//         // Après connexion réussie, naviguer vers la page d'accueil
//         Navigator.pushReplacementNamed(context, '/home');
//       } on FirebaseAuthException catch (e) {
//         setState(() {
//           if (e.code == 'user-not-found') {
//             errorMessage = 'Aucun utilisateur trouvé avec cet email.';
//           } else if (e.code == 'wrong-password') {
//             errorMessage = 'Mot de passe incorrect.';
//           } else {
//             errorMessage = 'Erreur de connexion: ${e.message}';
//           }
//         });
//       } catch (e) {
//         setState(() {
//           errorMessage = 'Une erreur est survenue: $e';
//         });
//       } finally {
//         if (mounted) {
//           setState(() {
//             isLoading = false;
//           });
//         }
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(24.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   'MediClic',
//                   style: TextStyle(
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold,
//                     color: Theme.of(context).primaryColor,
//                   ),
//                 ),
//                 SizedBox(height: 40),
//                 TextFormField(
//                   decoration: InputDecoration(
//                     labelText: 'Email',
//                     border: OutlineInputBorder(),
//                     prefixIcon: Icon(Icons.email),
//                   ),
//                   keyboardType: TextInputType.emailAddress,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Veuillez entrer votre email';
//                     }
//                     return null;
//                   },
//                   onChanged: (value) => email = value,
//                 ),
//                 SizedBox(height: 20),
//                 TextFormField(
//                   decoration: InputDecoration(
//                     labelText: 'Mot de passe',
//                     border: OutlineInputBorder(),
//                     prefixIcon: Icon(Icons.lock),
//                   ),
//                   obscureText: true,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Veuillez entrer votre mot de passe';
//                     }
//                     return null;
//                   },
//                   onChanged: (value) => password = value,
//                 ),
//                 SizedBox(height: 10),
//                 if (errorMessage.isNotEmpty)
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 10.0),
//                     child: Text(
//                       errorMessage,
//                       style: TextStyle(color: Colors.red),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                 SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: isLoading ? null : _signIn,
//                   style: ElevatedButton.styleFrom(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
//                     child: isLoading
//                         ? CircularProgressIndicator(color: Colors.white)
//                         : Text('Se connecter', style: TextStyle(fontSize: 16)),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 // Bouton pour aller à la page d'inscription
//                 TextButton(
//                   onPressed: () {
//                     Navigator.pushNamed(context, '/register');
//                   },
//                   child: Text(
//                     "Créer un compte",
//                     style: TextStyle(color: Colors.purple, fontSize: 16),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:mediclic/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mediclic/pages/homescreen.dart';
import 'package:mediclic/doctor/pages/dashboard.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _authService = AuthService();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F0F5),
      appBar: AppBar(
        backgroundColor: Color(0xFF673AB7),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Connexion', style: TextStyle(color: Colors.white)),
        elevation: 0,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  color: Color(0xFF673AB7),
                  padding: EdgeInsets.only(bottom: 20),
                  child: Center(
                    child: Text(
                      'Se connecter',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Informations de connexion',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 16),
                          TextField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              errorText: _errorMessage,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              prefixIcon: Icon(Icons.email),
                            ),
                          ),
                          SizedBox(height: 16),
                          TextField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Mot de passe',
                              errorText: _errorMessage,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              prefixIcon: Icon(Icons.lock),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF673AB7),
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Se connecter',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    child: Text(
                      'Créer un compte',
                      style: TextStyle(
                        color: Color(0xFF673AB7),
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null; // Reset error message
    });

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    try {
      // Connexion avec l'email et le mot de passe
      String? loginError = await _authService.loginUser(email, password);
      if (loginError != null) {
        setState(() {
          _errorMessage = loginError;
        });
        return;
      }

      // Récupérer l'ID de l'utilisateur connecté
      String? userId = _authService.getCurrentUserId();
      if (userId != null) {
        // Vérifier le rôle de l'utilisateur
        String? role = await _authService.getUserRole(userId);
        if (role == 'admin') {
          Navigator.pushReplacementNamed(context, '/home'); // Redirige vers la page d'accueil admin
        } else if (role == 'clinic') {
          bool isClinic = await _authService.isClinic();
          if (isClinic) {
            Navigator.pushReplacementNamed(context, '/clinique_home'); // Page de la clinique
          } else {
            setState(() {
              _errorMessage = 'Utilisateur non autorisé pour ce rôle.';
            });
          }
        } else if (role == 'medecin') {
          Navigator.pushReplacementNamed(context, '/doctor_home'); // Page du médecin
        } else {
          setState(() {
            _errorMessage = 'Rôle utilisateur inconnu.';
          });
        }
      } else {
        setState(() {
          _errorMessage = 'Impossible de récupérer l\'ID de l\'utilisateur.';
        });
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = e.message;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}