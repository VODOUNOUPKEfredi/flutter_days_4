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
//   bool _showPassword = false; // Pour montrer/cacher le mot de passe

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Connexion'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Text(
//                   'Connexion',
//                   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                   textAlign: TextAlign.center,
//                 ),
//                 SizedBox(height: 20),
                
//                 // Email
//                 TextFormField(
//                   decoration: InputDecoration(
//                     labelText: 'Email',
//                     border: OutlineInputBorder(),
//                     prefixIcon: Icon(Icons.email),
//                   ),
//                   keyboardType: TextInputType.emailAddress,
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Veuillez entrer un email';
//                     }
//                     if (!value.contains('@')) {
//                       return 'Veuillez entrer un email valide';
//                     }
//                     return null;
//                   },
//                   onChanged: (value) => email = value.trim(), // Supprimer les espaces
//                 ),
//                 SizedBox(height: 10),
                
//                 // Mot de passe
//                 TextFormField(
//                   decoration: InputDecoration(
//                     labelText: 'Mot de passe',
//                     border: OutlineInputBorder(),
//                     prefixIcon: Icon(Icons.lock),
//                     suffixIcon: IconButton(
//                       icon: Icon(
//                         _showPassword ? Icons.visibility : Icons.visibility_off,
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           _showPassword = !_showPassword;
//                         });
//                       },
//                     ),
//                   ),
//                   obscureText: !_showPassword,
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Veuillez entrer un mot de passe';
//                     }
//                     return null;
//                   },
//                   onChanged: (value) => password = value,
//                 ),
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
                
//                 // Bouton de connexion
//                 ElevatedButton(
//                   onPressed: isLoading ? null : _login,
//                   child: isLoading
//                       ? Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             SizedBox(
//                               width: 20,
//                               height: 20,
//                               child: CircularProgressIndicator(
//                                 color: Colors.white,
//                                 strokeWidth: 2,
//                               ),
//                             ),
//                             SizedBox(width: 10),
//                             Text('Connexion en cours...'),
//                           ],
//                         )
//                       : Text('Se connecter'),
//                   style: ElevatedButton.styleFrom(
//                     padding: EdgeInsets.symmetric(vertical: 12),
//                   ),
//                 ),
                
//                 SizedBox(height: 15),
                
//                 // Lien vers la page d'inscription
//                 TextButton(
//                   onPressed: () => Navigator.pushReplacementNamed(context, '/register'),
//                   child: Text('Pas encore inscrit? Créer un compte'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void _login() async {
//     if (_formKey.currentState!.validate()) {
//       setState(() {
//         isLoading = true;
//         errorMessage = '';
//       });
      
//       try {
//         print("Tentative de connexion avec: $email / ${password.length} caractères");
        
//         // Se connecter et récupérer les informations de l'utilisateur, y compris son rôle
//         final userInfo = await _authService.signIn(
//           email: email,
//           password: password,
//         );
        
//         print("Connexion réussie. Rôle: ${userInfo['role']}");
        
//         // Afficher un message de succès
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Connexion réussie!'),
//             backgroundColor: Colors.green,
//           ),
//         );
        
//         // Rediriger en fonction du rôle
//         _redirectBasedOnRole(userInfo['role']);
//       } catch (e) {
//         print("Erreur de connexion: $e");
//         setState(() {
//           errorMessage = e.toString();
//           // Supprimer "Exception: " du message d'erreur pour une meilleure présentation
//           if (errorMessage.startsWith('Exception: ')) {
//             errorMessage = errorMessage.substring('Exception: '.length);
//           }
//         });
//       } finally {
//         setState(() {
//           isLoading = false;
//         });
//       }
//     }
//   }
  
//   void _redirectBasedOnRole(String role) {
//     print("Redirection vers la page correspondant au rôle: $role");
    
//     // Rediriger en fonction du rôle récupéré
//     switch (role) {
     
//       case 'clinique':
//         Navigator.pushReplacementNamed(context, '/cliniqueHome');  // Modifié pour la page d'accueil clinique
//         break;
     
//       case 'medecin':
//         Navigator.pushReplacementNamed(context, '/medecinHome');  // Modifié pour la page d'accueil médecin
//         break;
//       default:
//         // Par défaut, rediriger vers une page d'accueil générique
//         Navigator.pushReplacementNamed(context, '/LoginPage');
//         break;
//     }
//   }
// }
import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  
  String email = '';
  String password = '';
  bool isLoading = false;
  String errorMessage = '';
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connexion'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Connexion',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                
                // Email
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer un email';
                    }
                    if (!value.contains('@')) {
                      return 'Veuillez entrer un email valide';
                    }
                    return null;
                  },
                  onChanged: (value) => email = value.trim(),
                ),
                SizedBox(height: 10),
                
                // Mot de passe
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Mot de passe',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _showPassword ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _showPassword = !_showPassword;
                        });
                      },
                    ),
                  ),
                  obscureText: !_showPassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer un mot de passe';
                    }
                    return null;
                  },
                  onChanged: (value) => password = value,
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
                
                // Bouton de connexion
                ElevatedButton(
                  onPressed: isLoading ? null : _login,
                  child: isLoading
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            ),
                            SizedBox(width: 10),
                            Text('Connexion en cours...'),
                          ],
                        )
                      : Text('Se connecter'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
                
                SizedBox(height: 15),
                
                // Lien vers la page d'inscription
                TextButton(
                  onPressed: () => Navigator.pushReplacementNamed(context, '/register'),
                  child: Text('Pas encore inscrit? Créer un compte'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _login() async {
    // Vérifier que le formulaire est valide
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        isLoading = true;
        errorMessage = '';
      });
      
      try {
        print("Tentative de connexion avec: $email / ${password.length} caractères");
        
        // Se connecter et récupérer les informations de l'utilisateur, y compris son rôle
        final userInfo = await _authService.signIn(
          email: email,
          password: password,
        );
        
        // Vérifier si userInfo contient les données nécessaires
        if (userInfo == null || !userInfo.containsKey('role') || userInfo['role'] == null) {
          throw Exception("Informations utilisateur incomplètes ou rôle manquant");
        }
        
        final role = userInfo['role'].toString().toLowerCase();
        print("Connexion réussie. Rôle: '$role'");
        
        // Attendre que l'interface utilisateur soit mise à jour avant de naviguer
        await Future.delayed(Duration(milliseconds: 100));
        
        // Afficher un message de succès
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Connexion réussie!'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
          
          // Attendre que le snackbar s'affiche avant de naviguer
          await Future.delayed(Duration(milliseconds: 500));
          
          // Rediriger en fonction du rôle
          if (mounted) {
            _redirectBasedOnRole(role);
          }
        }
      } catch (e) {
        print("Erreur de connexion: $e");
        setState(() {
          errorMessage = e.toString();
          // Supprimer "Exception: " du message d'erreur pour une meilleure présentation
          if (errorMessage.startsWith('Exception: ')) {
            errorMessage = errorMessage.substring('Exception: '.length);
          }
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
  
  void _redirectBasedOnRole(String role) {
    print("Redirection vers la page correspondant au rôle: '$role'");
    
    // Vérifier si le contexte est toujours valide
    if (!mounted) {
      print("Erreur: Context n'est plus valide");
      return;
    }

    // Rediriger en fonction du rôle récupéré
    switch (role.trim().toLowerCase()) {
      case 'clinique':
        print("Redirection vers /cliniqueHome");
        Navigator.of(context).pushNamedAndRemoveUntil('/cliniqueHome', (route) => false);
        break;
      
      case 'medecin':
        print("Redirection vers /medecinHome");
        Navigator.of(context).pushNamedAndRemoveUntil('/medecinHome', (route) => false);
        break;
      
      default:
        // Afficher un message d'erreur si le rôle n'est pas reconnu
        print("Rôle non reconnu: '$role'");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur: rôle non reconnu ($role)'),
            backgroundColor: Colors.red,
          ),
        );
        // On reste sur la page de connexion
        break;
    }
  }
}