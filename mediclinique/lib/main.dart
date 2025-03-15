
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:mediclic/clinique/pages/CliniqueHomeScreen.dart';
// import 'package:mediclic/doctor/pages/dashboard.dart';
// import 'package:mediclic/doctor/rootDoctor.dart';
// import 'package:mediclic/splashScreen.dart';
// import 'firebase_options.dart';

// // Import des pages
// import './pages/login_page.dart';
// // import './doctor/rootDoctor.dart'; // Décommentez si nécessaire

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
//       title: 'MediClic',
//       theme: ThemeData(
//         primarySwatch: Colors.purple,
//         scaffoldBackgroundColor: Colors.white,
//       ),
//       initialRoute: '/splash',
//       routes: {
//         '/splash': (context) => SplashScreen(),
//         '/login': (context) => LoginScreen(),
//         '/home': (context) => HomeScreen(),
//         '/doctor_home': (context) => DoctorHomePage(),
//         '/clinique_home': (context) => RegisterDoctorWidget(),  // Votre page d'accueil clinique
//       },
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mediclic/clinique/pages/CliniqueHomeScreen.dart';
import 'package:mediclic/doctor/pages/dashboard.dart';
import 'package:mediclic/doctor/pages/docteurdispo.dart';
import 'package:mediclic/doctor/rootDoctor.dart';
import 'package:mediclic/splashScreen.dart';
import 'firebase_options.dart';

// Import des pages
import './pages/login_page.dart';

void main() async {
  // Initialiser les liaisons Flutter
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    // Initialiser Firebase
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
        '/clinique_home': (context) => AvailabilityCalendar(),  // ✅ Correction ici
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
