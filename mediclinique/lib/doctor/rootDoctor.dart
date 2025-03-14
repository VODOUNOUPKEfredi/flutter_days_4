// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Bottom Navigation Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         brightness: Brightness.light,
//       ),
//       darkTheme: ThemeData(
//         primarySwatch: Colors.blue,
//         brightness: Brightness.dark,
//       ),
//       themeMode: ThemeMode.system,
//       home: const HomeScreen(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   int _selectedIndex = 0;
  
//   // Ceci est juste pour la démonstration, chaque page devrait être une classe séparée
//   static const List<Widget> _pages = <Widget>[
//     Center(child: Text('Page Accueil', style: TextStyle(fontSize: 24))),
//     Center(child: Text('Page Recherche', style: TextStyle(fontSize: 24))),
//     Center(child: Text('Page Favoris', style: TextStyle(fontSize: 24))),
//     Center(child: Text('Page Panier', style: TextStyle(fontSize: 24))),
//     Center(child: Text('Page Profil', style: TextStyle(fontSize: 24))),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Navigation Demo'),
//         elevation: 0,
//       ),
//       body: _pages[_selectedIndex],
//       bottomNavigationBar: Container(
//         decoration: BoxDecoration(
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.1),
//               blurRadius: 10,
//               spreadRadius: 0,
//             ),
//           ],
//         ),
//         child: BottomNavigationBar(
//           items: const <BottomNavigationBarItem>[
//             BottomNavigationBarItem(
//               icon: Icon(Icons.home_outlined),
//               activeIcon: Icon(Icons.home),
//               label: 'Accueil',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.search_outlined),
//               activeIcon: Icon(Icons.search),
//               label: 'Recherche',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.favorite_border_outlined),
//               activeIcon: Icon(Icons.favorite),
//               label: 'Favoris',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.shopping_bag_outlined),
//               activeIcon: Icon(Icons.shopping_bag),
//               label: 'Panier',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.person_outline),
//               activeIcon: Icon(Icons.person),
//               label: 'Profil',
//             ),
//           ],
//           currentIndex: _selectedIndex,
//           selectedItemColor: Theme.of(context).primaryColor,
//           unselectedItemColor: Colors.grey,
//           showUnselectedLabels: true,
//           type: BottomNavigationBarType.fixed,
//           onTap: _onItemTapped,
//         ),
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
import 'package:mediclic/services/auth_service.dart';

// Importation des écrans


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _userRole;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _fetchUserRole();
  }

  Future<void> _fetchUserRole() async {
    String? role = await AuthService().getUserRole();
    if (role != null) {
      setState(() {
        _userRole = role;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_userRole == null) {
      return Scaffold(body: Center(child: CircularProgressIndicator())); // Chargement
    }

    // Définir les pages en fonction du rôle
    List<Widget> pages = _userRole == 'medecin'
        ? [DoctorHomePage(), HistoriquePage(), DoctorProfilePage()]
        : [RegisterDoctorWidget(), ClinicProfileScreen(), ClinicProfileScreen()];

    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: _userRole == 'medecin'
            ? [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Accueil"),
                BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: "Rendez-vous"),
                BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
              ]
            : [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Accueil"),
                BottomNavigationBarItem(icon: Icon(Icons.people), label: "Patients"),
                BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
              ],
      ),
    );
  }
}