import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mediclic/clinique/pages/inscritMedecin.dart';
import 'package:mediclic/doctor/pages/dashboard.dart';
import 'package:mediclic/pages/homescreen.dart';
import 'package:mediclic/pages/register_page.dart';
import 'package:mediclic/pages/login_page.dart';
import 'package:mediclic/services/auth_service.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MediClinique',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: AuthWrapper(), // Gère la redirection au démarrage
      debugShowCheckedModeBanner: false,
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterPage(),
        '/doctor_home': (context) => DoctorHomePage(),
        '/clinique_home': (context) => RegisterMedecinPage(),
        '/inscrit_medecin': (context) => RegisterMedecinPage(),
        '/home': (context) => LoginScreen(),
      },
      onGenerateRoute: (settings) {
        // Gestionnaire pour les routes non définies explicitement
        print('Route demandée: ${settings.name}');
        return MaterialPageRoute(builder: (context) => LoginScreen());
      },
      onUnknownRoute: (settings) {
        // Handler de dernier recours pour les routes inconnues
        return MaterialPageRoute(builder: (context) => LoginScreen());
      },
    );
  }
}

class AuthWrapper extends StatefulWidget {
  @override
  _AuthWrapperState createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  final AuthService _authService = AuthService();
  late Future<String?> _roleFuture;

  @override
  void initState() {
    super.initState();
    _roleFuture = _checkUserAndNavigate();
  }

  Future<String?> _checkUserAndNavigate() async {
    await Future.delayed(Duration(seconds: 2));
    if (!mounted) return null;

    String? userId = _authService.getCurrentUserId();
    if (userId != null) {
      return await _authService.getUserRole(userId);
    }
    return null; // Aucun utilisateur connecté
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _roleFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingScreen();
        } else {
          String? role = snapshot.data;
          if (role != null) {
            // Utiliser le HomeContainer pour afficher la navigation en fonction du rôle
            return HomeContainer(userRole: role);
          } else {
            return LoginScreen();
          }
        }
      },
    );
  }
}

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/1.png', width: 150, errorBuilder: (context, error, stackTrace) {
              return Icon(Icons.error, size: 50, color: Colors.red);
            }),
            SizedBox(height: 30),
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text('Chargement...', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}