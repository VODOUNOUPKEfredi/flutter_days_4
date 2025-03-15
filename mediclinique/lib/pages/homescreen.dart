
// import 'package:flutter/material.dart';
// import 'package:mediclic/clinique/pages/CliniqueHomeScreen.dart';
// import 'package:mediclic/clinique/pages/profilClinique.dart';
// import 'package:mediclic/doctor/pages/dashboard.dart';
// import 'package:mediclic/doctor/pages/historique.dart';
// import 'package:mediclic/doctor/pages/profil.dart';
// import 'package:mediclic/pages/register_page.dart';
// import 'package:mediclic/services/auth_service.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   String? _userRole;
//   int _selectedIndex = 0;
//   final AuthService _authService = AuthService();
//   bool _isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _fetchUserRole();
//   }

//   Future<void> _fetchUserRole() async {
//     setState(() {
//       _isLoading = true;
//     });

//     try {
//       User? currentUser = FirebaseAuth.instance.currentUser; // Récupérer l'utilisateur actuel
//       if (currentUser == null) {
//         throw Exception("Utilisateur non connecté");
//       }

//       // Passer l'UID à getUserRole
//       String? role = await _authService.getUserRole(currentUser.uid);
//       print("Rôle brut récupéré: '$role'"); // Log pour déboguer

//       if (mounted) {
//         setState(() {
//           _userRole = role?.trim().toLowerCase();  // Normalisation du rôle
//           _isLoading = false;
//         });
//         print("Rôle utilisateur normalisé: '${_userRole}'");
//       }
//     } catch (e) {
//       print("Erreur lors de la récupération du rôle: $e");
//       if (mounted) {
//         setState(() {
//           _isLoading = false;
//         });
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_isLoading) {
//       return Scaffold(
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               CircularProgressIndicator(),
//               SizedBox(height: 16),
//               Text("Chargement de votre profil...", style: TextStyle(fontSize: 16)),
//             ],
//           ),
//         ),
//       );
//     }

//     if (_userRole == null) {
//       return Scaffold(
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(Icons.error_outline, size: 60, color: Colors.red),
//               SizedBox(height: 16),
//               Text("Impossible de charger votre profil", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//               SizedBox(height: 8),
//               Text("Veuillez vous reconnecter", style: TextStyle(fontSize: 16)),
//               SizedBox(height: 24),
//               ElevatedButton(
//                 onPressed: () => _fetchUserRole(),
//                 child: Text("Réessayer"),
//               ),
//               SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
//                 child: Text("Retour à la connexion"),
//               ),
//             ],
//           ),
//         ),
//       );
//     }

//     String normalizedRole = _userRole!;
//     print("Construction de l'interface pour le rôle: $normalizedRole");

//     List<Widget> pages = [];
//     List<BottomNavigationBarItem> items = [];

//     switch (normalizedRole) {
//       case 'medecin':
//       case 'docteur':
//       case 'doctor':
//         pages = [
//           DoctorHomePage(),
//           HistoriquePage(),
//           DoctorProfilePage(),
//         ];
//         items = [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: "Accueil"),
//           BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: "Rendez-vous"),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
//         ];
//         break;
//       case 'clinique':
//       case 'clinic':
//         pages = [
//           RegisterPage(),  // ✅ Correction ici
//           ClinicProfileScreen(),
//         ];
//         items = [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: "Accueil"),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
//         ];
//         break;
//       default:
//         return Scaffold(
//           body: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(Icons.warning_amber_rounded, size: 60, color: Colors.orange),
//                 SizedBox(height: 16),
//                 Text("Rôle non reconnu: $_userRole", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                 SizedBox(height: 8),
//                 Text("Veuillez contacter l'administrateur", style: TextStyle(fontSize: 16)),
//                 SizedBox(height: 24),
//                 ElevatedButton(
//                   onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
//                   child: Text("Retour à la connexion"),
//                 ),
//               ],
//             ),
//           ),
//         );
//     }

//     if (_selectedIndex >= pages.length) {
//       _selectedIndex = 0;
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           normalizedRole.contains('medecin') || normalizedRole.contains('docteur') || normalizedRole.contains('doctor') ? 
//           "Espace Médecin" : "Espace Clinique"
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.logout),
//             onPressed: () async {
//               await _authService.signOut();
//               Navigator.pushReplacementNamed(context, '/login');
//             },
//           ),
//         ],
//       ),
//       body: pages[_selectedIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         onTap: (index) => setState(() => _selectedIndex = index),
//         items: items,
//         selectedItemColor: Theme.of(context).primaryColor,
//         unselectedItemColor: Colors.grey,
//         type: BottomNavigationBarType.fixed,
//         showUnselectedLabels: true,
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:mediclic/clinique/pages/CliniqueHomeScreen.dart';
import 'package:mediclic/clinique/pages/profilClinique.dart';
import 'package:mediclic/doctor/pages/dashboard.dart';
import 'package:mediclic/doctor/pages/historique.dart';
import 'package:mediclic/doctor/pages/profil.dart';
import 'package:mediclic/pages/admin.dart';
import 'package:mediclic/pages/register_page.dart';
import 'package:mediclic/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _userRole;
  int _selectedIndex = 0;
  final AuthService _authService = AuthService();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserRole();
  }

  Future<void> _fetchUserRole() async {
    setState(() => _isLoading = true);
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) throw Exception("Utilisateur non connecté");
      String? role = await _authService.getUserRole(currentUser.uid);
      if (mounted) {
        setState(() {
          _userRole = role?.trim().toLowerCase();
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text("Chargement de votre profil...", style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      );
    }

    if (_userRole == null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 60, color: Colors.red),
              SizedBox(height: 16),
              Text("Impossible de charger votre profil", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              ElevatedButton(onPressed: _fetchUserRole, child: Text("Réessayer")),
              SizedBox(height: 16),
              ElevatedButton(onPressed: () => Navigator.pushReplacementNamed(context, '/login'), child: Text("Retour à la connexion")),
            ],
          ),
        ),
      );
    }

    Map<String, List<dynamic>> roleConfig = {
      'medecin': [
        [DoctorHomePage(), HistoriquePage(), DoctorProfilePage()],
        ["Accueil", "Rendez-vous", "Profil"],
        [Icons.home, Icons.calendar_today, Icons.person]
      ],
      'clinique': [
        [RegisterClinicWidget(), ClinicProfileScreen()],
        ["Accueil", "Profil"],
        [Icons.home, Icons.person]
      ],
      'admin': [
        [AdminPage()],
        ["Dashboard"],
        [Icons.dashboard]
      ],
    };

    String normalizedRole = _userRole!;
    if (!roleConfig.containsKey(normalizedRole)) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.warning_amber_rounded, size: 60, color: Colors.orange),
              SizedBox(height: 16),
              Text("Rôle non reconnu: $_userRole", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 24),
              ElevatedButton(onPressed: () => Navigator.pushReplacementNamed(context, '/login'), child: Text("Retour à la connexion")),
            ],
          ),
        ),
      );
    }

    List<Widget> pages = roleConfig[normalizedRole]![0];
    List<String> labels = roleConfig[normalizedRole]![1];
    List<IconData> icons = roleConfig[normalizedRole]![2];

    return Scaffold(
      appBar: AppBar(
        title: Text(normalizedRole == 'admin' ? "Espace Admin" : "Espace ${normalizedRole.capitalize()}"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await _authService.signOut();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: List.generate(labels.length, (index) => BottomNavigationBarItem(icon: Icon(icons[index]), label: labels[index])),
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() => this.isNotEmpty ? '${this[0].toUpperCase()}${this.substring(1)}' : this;
}
