// import 'package:flutter/material.dart';
// import 'package:mediclinique/clinique/pages/CliniqueHomeScreen.dart';
// import 'package:mediclinique/clinique/pages/profilClinique.dart';
// import 'package:mediclinique/doctor/pages/disponibilitedoctor.dart';
// import 'package:mediclinique/doctor/pages/dashboard.dart';
// import 'package:mediclinique/doctor/pages/dossier1.dart';
// import 'package:mediclinique/doctor/pages/historique.dart';
// import 'package:mediclinique/doctor/pages/profil.dart';
// import 'package:mediclinique/doctor/pages/rdv.dart';
// import 'package:mediclinique/services/auth_service.dart';

// // Imports pour les pages médecin


// // Widget Container principal pour gérer la navigation et les pages selon le rôle
// class HomeContainer extends StatefulWidget {
//   final String userRole;
  
//   HomeContainer({required this.userRole});
  
//   @override
//   _HomeContainerState createState() => _HomeContainerState();
// }

// class _HomeContainerState extends State<HomeContainer> {
//   int _selectedIndex = 0;
//   late List<Widget> _widgetOptions;
//   late List<String> _appBarTitles;
//   late List<BottomNavigationBarItem> _navigationItems;
  
//   @override
//   void initState() {
//     super.initState();
//     _initializeWidgetsByRole();
//   }
  
//   void _initializeWidgetsByRole() {
//     // Configuration des pages selon le rôle
//     if (widget.userRole == "medecin") {
//       // Configuration pour le médecin avec 6 pages
//       _widgetOptions = [
//         DoctorHomePage(),
//         HistoriquePage(),
//         ConsultationsPage(),
//         DossierMedicalForm(),
//         MedicalSchedulerApp(),
//         DoctorProfilePage(),
//       ];
//       _appBarTitles = ["Tableau de bord", "Historique", "Rendez-vous", "Dossiers médicaux", "Calendrier", "Profil"];
//       _navigationItems = [
//         BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Tableau"),
//         BottomNavigationBarItem(icon: Icon(Icons.history), label: "Historique"),
//         BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: "RDV"),
//         BottomNavigationBarItem(icon: Icon(Icons.folder_open), label: "Dossiers"),
//         BottomNavigationBarItem(icon: Icon(Icons.event), label: "Calendrier"),
//         BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
//       ];
//     } else if (widget.userRole == "clinique") {
//       // Configuration pour la clinique avec 2 pages
//       _widgetOptions = [
//         Cliniquehomescreen(),
//         ClinicProfileScreen(),
//       ];
//       _appBarTitles = ["Accueil", "Profil"];
//       _navigationItems = [
//         BottomNavigationBarItem(icon: Icon(Icons.home), label: "Accueil"),
//         BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
//       ];
//     } else {
      
//       _appBarTitles = ["Accueil", "Rendez-vous", "Médecins", "Profil"];
//       _navigationItems = [
//         BottomNavigationBarItem(icon: Icon(Icons.home), label: "Accueil"),
//         BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: "RDV"),
//         BottomNavigationBarItem(icon: Icon(Icons.local_hospital), label: "Médecins"),
//         BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
//       ];
//     }
//   }
  
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(_appBarTitles[_selectedIndex]),
//         backgroundColor: Colors.purple,
//         elevation: 0,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.notifications),
//             onPressed: () {
//               // Naviguer vers les notifications
//             },
//           ),
//           IconButton(
//             icon: Icon(Icons.logout),
//             onPressed: () {
//               _showLogoutDialog(context);
//             },
//           ),
//         ],
//       ),
//       body: _widgetOptions.elementAt(_selectedIndex),
//       bottomNavigationBar: BottomNavigationBar(
//         items: _navigationItems,
//         currentIndex: _selectedIndex,
//         selectedItemColor: Colors.purple,
//         unselectedItemColor: Colors.grey,
//         type: BottomNavigationBarType.fixed,
//         onTap: _onItemTapped,
//         showUnselectedLabels: true,
//       ),
//     );
//   }
  
//   void _showLogoutDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("Déconnexion"),
//           content: Text("Êtes-vous sûr de vouloir vous déconnecter?"),
//           actions: [
//             TextButton(
//               child: Text("Annuler"),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             TextButton(
//               child: Text("Déconnecter"),
//               onPressed: () {
//                 AuthService().signOut();
//                 Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:mediclinique/clinique/pages/CliniqueHomeScreen.dart';
import 'package:mediclinique/clinique/pages/profilClinique.dart';
import 'package:mediclinique/doctor/pages/disponibilitedoctor.dart';
import 'package:mediclinique/doctor/pages/dashboard.dart';
import 'package:mediclinique/doctor/pages/dossier1.dart';
import 'package:mediclinique/doctor/pages/historique.dart';
import 'package:mediclinique/doctor/pages/profil.dart';
import 'package:mediclinique/doctor/pages/rdv.dart';
import 'package:mediclinique/services/auth_service.dart';

class HomeContainer extends StatefulWidget {
  final String userRole;
  
  HomeContainer({required this.userRole});
  
  @override
  _HomeContainerState createState() => _HomeContainerState();
}

class _HomeContainerState extends State<HomeContainer> {
  int _selectedIndex = 0;
  late List<Widget> _widgetOptions;
  late List<String> _appBarTitles;
  late List<BottomNavigationBarItem> _navigationItems;
  
  @override
  void initState() {
    super.initState();
    _initializeWidgetsByRole();
  }
  
  void _initializeWidgetsByRole() {
    // Configuration des pages selon le rôle
    if (widget.userRole == "medecin") {
      _widgetOptions = [
        DoctorHomePage(),
        HistoriquePage(),
        ConsultationsPage(),
        DossierMedicalForm(),
        MedicalSchedulerApp(),
        DoctorProfilePage(),
      ];
      _appBarTitles = ["Tableau de bord", "Historique", "Rendez-vous", "Dossiers médicaux", "Calendrier", "Profil"];
      _navigationItems = [
        BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Tableau"),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: "Historique"),
        BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: "RDV"),
        BottomNavigationBarItem(icon: Icon(Icons.folder_open), label: "Dossiers"),
        BottomNavigationBarItem(icon: Icon(Icons.event), label: "Calendrier"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
      ];
    } else if (widget.userRole == "clinique") {
      _widgetOptions = [
        Cliniquehomescreen(),
        ClinicProfileScreen(),
      ];
      _appBarTitles = ["Accueil", "Profil"];
      _navigationItems = [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Accueil"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
      ];
    } else {
      _appBarTitles = ["Accueil", "Rendez-vous", "Médecins", "Profil"];
      _navigationItems = [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Accueil"),
        BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: "RDV"),
        BottomNavigationBarItem(icon: Icon(Icons.local_hospital), label: "Médecins"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
      ];
    }
  }
  
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitles[_selectedIndex]),
        backgroundColor: Colors.purple,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Naviguer vers les notifications
            },
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              _showLogoutDialog(context);
            },
          ),
        ],
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: _navigationItems,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        showUnselectedLabels: true,
      ),
    );
  }
  
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Déconnexion"),
          content: Text("Êtes-vous sûr de vouloir vous déconnecter?"),
          actions: [
            TextButton(
              child: Text("Annuler"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Déconnecter"),
              onPressed: () {
                AuthService().signOut();
                Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
              },
            ),
          ],
        );
      },
    );
  }
}
