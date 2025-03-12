import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mediclic/firebase_options.dart';
import 'package:mediclic/pages/CliniqueHomeScreen.dart';
import 'package:mediclic/pages/docteur.dart';
import 'package:mediclic/pages/dossierMedical.dart';
import 'package:mediclic/pages/login_page.dart';
import 'package:mediclic/pages/register_page.dart';
import 'package:mediclic/services/roles.dart';

void main() async {
  // Initialiser les liaisons Flutter
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    // Initialiser Firebase avec les options par défaut pour la plateforme
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("Firebase initialisé avec succès");
  } catch (e) {
    print("Erreur lors de l'initialisation de Firebase: $e");
  }
  
  // Lancer l'application
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clinique App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // Utilisation de StreamBuilder pour écouter les changements d'état d'authentification
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData && snapshot.data != null) {
              // L'utilisateur est connecté, déterminer son rôle
              return FutureBuilder<String?>(
                future: _authService.getUserRole(),
                builder: (context, roleSnapshot) {
                  if (roleSnapshot.connectionState == ConnectionState.done) {
                    print("Rôle utilisateur: ${roleSnapshot.data}");
                    if (roleSnapshot.data == 'clinique') {
                      return RegisterDoctorWidget(); // Page pour les cliniques
                    } else if (roleSnapshot.data == 'docteur') {
                      return DocteurPage(); // Page pour les docteurs
                    } else if (roleSnapshot.data == 'medecine') {
                      return PatientInfoScreen(); // Page pour les médecins
                    } else {
                      // Rôle non déterminé ou non reconnu, déconnecter l'utilisateur
                      print("Rôle inconnu ou null, déconnexion");
                      // Ajout d'un délai pour éviter une boucle infinie de déconnexion/reconnexion
                      // Ne déconnectez pas immédiatement
                      return Scaffold(
                        body: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Rôle utilisateur non reconnu: ${roleSnapshot.data}"),
                              ElevatedButton(
                                onPressed: () {
                                  FirebaseAuth.instance.signOut();
                                  Navigator.pushReplacementNamed(context, '/login');
                                },
                                child: Text("Retourner à la connexion"),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  }
                  // Chargement en cours pour déterminer le rôle
                  return Scaffold(
                    body: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 16),
                          Text("Chargement du profil utilisateur..."),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              // L'utilisateur n'est pas connecté
              return LoginPage();
            }
          }
          // Chargement initial de Firebase
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
      routes: {
        '/login': (context) => LoginPage(),
        '/LoginPage': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/cliniqueHome': (context) => RegisterDoctorWidget(),
        '/docteurPage': (context) => DocteurPage(),
        '/medecinHome': (context) => PatientInfoScreen(),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => LoginPage(),
        );
      },
    );
  }
}

// Ici, nous ajoutons un exemple de la classe LoginPage avec la fonctionnalité de redirection
// après authentification réussie. Assurez-vous d'adapter cela à votre implémentation existante.

/*
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  Future<void> _signIn() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Authentification avec Firebase
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      // Récupérer le rôle après connexion
      String? role = await _authService.getUserRole();

      // Note: pas besoin de faire de redirection ici, le StreamBuilder
      // dans MyApp détectera automatiquement le changement d'état d'authentification
      // et redirigera l'utilisateur vers la page appropriée

    } catch (e) {
      // Afficher une erreur
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur de connexion: ${e.toString()}')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Implémentation de l'interface utilisateur...
  }
}

// Exemple de la classe AuthService qui devrait être définie dans services/roles.dart
class AuthService {
  Future<String?> getUserRole() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        // Récupérer le rôle de l'utilisateur depuis Firestore ou une autre source de données
        // Exemple avec Firestore:
        final docRef = FirebaseFirestore.instance.collection('users').doc(user.uid);
        final docSnap = await docRef.get();
        if (docSnap.exists) {
          return docSnap.data()?['role'] as String?;
        }
      } catch (e) {
        print("Erreur lors de la récupération du rôle: $e");
      }
    }
    return null;
  }
}*/
