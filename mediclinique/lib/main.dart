// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:mediclic/doctor/rootDoctor.dart';
// import 'firebase_options.dart';

// // Import des pages
// import './pages/login_page.dart';
// import './pages/register_page.dart';

// void main() async {
//   // Initialiser les liaisons Flutter
//   WidgetsFlutterBinding.ensureInitialized();
  
//   try {
//     // Initialiser Firebase avec les options par défaut pour la plateforme
//     await Firebase.initializeApp(
//       options: DefaultFirebaseOptions.currentPlatform,
//     );
//     print("Firebase initialisé avec succès");
//   } catch (e) {
//     print("Erreur lors de l'initialisation de Firebase: $e");
//   }
  
//   // Lancer l'application
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Application Médicale',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: LoginPage(),
//       routes: {
//         '/login': (context) => LoginPage(),
//         '/register': (context) => RegisterPage(),
//         '/home': (context) => HomeScreen(),
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mediclic/clinique/pages/CliniqueHomeScreen.dart';
import 'package:mediclic/doctor/pages/dashboard.dart';
import 'package:mediclic/doctor/rootDoctor.dart';
import 'package:mediclic/splashScreen.dart';
import 'firebase_options.dart';

// Import des pages
import './pages/login_page.dart';
// import './doctor/rootDoctor.dart'; // Décommentez si nécessaire

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

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Application Médicale',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: LoginPage(),
//       routes: {
//         '/login': (context) => LoginPage(),
//         '/register': (context) => RegisterPage(),
//         '/home': (context) => HomeScreen(),
//       },
//     );
//   }
// }

// // Classe HomeScreen temporaire pour tester la navigation
// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Accueil'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Bienvenue sur votre application médicale',
//               style: TextStyle(fontSize: 20),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 20),
//             Text(
//               'Connexion réussie!',
//               style: TextStyle(fontSize: 16, color: Colors.green),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 // Déconnexion
//                 Navigator.pushReplacementNamed(context, '/login');
//               },
//               child: Text('Déconnexion'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MediClic',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/doctor_home': (context) => DoctorHomePage(),
        '/clinique_home': (context) => RegisterDoctorWidget(),  // Votre page d'accueil clinique
      },
      debugShowCheckedModeBanner: false,
    );
  }
}