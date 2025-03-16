
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
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
//                     child: isLoading
//                         ? CircularProgressIndicator(color: Colors.white)
//                         : Text('Se connecter', style: TextStyle(fontSize: 16)),
//                   ),
//                   style: ElevatedButton.styleFrom(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
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
import 'package:flutter/gestures.dart';
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
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    child: isLoading
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text('Se connecter', style: TextStyle(fontSize: 16)),
                  ),
                ),
                SizedBox(height: 20),
                // Bouton pour aller à la page d'inscription
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  child: Text(
                    "Créer un compte",
                    style: TextStyle(color: Colors.purple, fontSize: 16),
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
