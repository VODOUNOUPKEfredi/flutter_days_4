// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class HomeScreen extends StatefulWidget {
//   final String userRole; // Récupérer le rôle après connexion
//   const HomeScreen({required this.userRole, Key? key}) : super(key: key);

//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   int _selectedIndex = 0;

//   // Définition des pages pour chaque rôle
//   final List<Widget> _medecinPages = [
//     Page1(), // Remplace par tes pages
//     Page2(),
//     Page3(),
//     Page4(),
//     Page5(),
//   ];

//   final List<Widget> _cliniquePages = [
//     Page1(), // Remplace par tes pages
//     Page2(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     bool isMedecin = widget.userRole == "medecin";
//     List<Widget> pages = isMedecin ? _medecinPages : _cliniquePages;

//     return Scaffold(
//       body: pages[_selectedIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         onTap: (index) {
//           setState(() {
//             _selectedIndex = index;
//           });
//         },
//         backgroundColor: Colors.black, // Design moderne
//         selectedItemColor: Colors.white,
//         unselectedItemColor: Colors.grey,
//         showUnselectedLabels: true,
//         type: BottomNavigationBarType.fixed, // Permet d'afficher tous les labels
//         items: isMedecin
//             ? [
//                 BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Dashboard"),
//                 BottomNavigationBarItem(icon: Icon(Icons.person), label: "Patients"),
//                 BottomNavigationBarItem(icon: Icon(Icons.history), label: "Historique"),
//                 BottomNavigationBarItem(icon: Icon(Icons.notifications), label: "Notifications"),
//                 BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Paramètres"),
//               ]
//             : [
//                 BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Dashboard"),
//                 BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Paramètres"),
//               ],
//       ),
//     );
//   }
// }
