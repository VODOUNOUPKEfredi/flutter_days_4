import 'package:flutter/material.dart';
import 'package:mediclic/services/auth_service.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _checkUserAndNavigate();
  }

  Future<void> _checkUserAndNavigate() async {
    // Attendre un peu pour l'animation
    await Future.delayed(Duration(seconds: 2));
    
    if (!mounted) return;

    // Vérifier si l'utilisateur est connecté
    if (_authService.getCurrentUserId() != null) {
      // L'utilisateur est connecté, récupérer son rôle
      String? role = await _authService.getUserRole();
      print("Rôle utilisateur au démarrage: $role");
      
      if (!mounted) return;

      // Naviguer selon le rôle
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      // L'utilisateur n'est pas connecté, aller à la page de connexion
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo.png', width: 150),  // Remplacez par votre logo
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