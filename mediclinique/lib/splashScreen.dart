// import 'package:flutter/material.dart';
// import 'package:mediclic/services/auth_service.dart';

// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   final AuthService _authService = AuthService();

//   @override
//   void initState() {
//     super.initState();
//     _checkUserAndNavigate();
//   }

//   Future<void> _checkUserAndNavigate() async {
//     await Future.delayed(Duration(seconds: 2));

//     if (!mounted) return;

//     // Vérifier si l'utilisateur est connecté
//     String? userId = _authService.getCurrentUserId();
//     if (userId != null) {
//       // L'utilisateur est connecté, récupérer son rôle
//       String? role = await _authService.getUserRole(userId);
//       print("Rôle utilisateur au démarrage: $role");

//       if (!mounted) return;

//       // Navigation selon le rôle
//       if (role == "medecin") {
//         Navigator.pushReplacementNamed(context, '/medecinHome');
//       } else if (role == "clinique") {
//         Navigator.pushReplacementNamed(context, '/cliniqueHome');
//       } else {
//         // Si le rôle n'est pas défini, rediriger vers une page d'erreur ou login
//         Navigator.pushReplacementNamed(context, '/login');
//       }
//     } else {
//       // L'utilisateur n'est pas connecté, aller à la page de connexion
//       Navigator.pushReplacementNamed(context, '/login');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset('images/1.png', width: 150), // Remplace par ton logo
//             SizedBox(height: 30),
//             CircularProgressIndicator(),
//             SizedBox(height: 20),
//             Text('Chargement...', style: TextStyle(fontSize: 18)),
//           ],
//         ),
//       ),
//     );
//   }
// }
