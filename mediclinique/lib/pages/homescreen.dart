
// // // // // import 'package:flutter/material.dart';
// // // // // import 'package:mediclic/clinique/pages/CliniqueHomeScreen.dart';
// // // // // import 'package:mediclic/clinique/pages/profilClinique.dart';
// // // // // import 'package:mediclic/doctor/pages/dashboard.dart';
// // // // // import 'package:mediclic/doctor/pages/historique.dart';
// // // // // import 'package:mediclic/doctor/pages/profil.dart';
// // // // // import 'package:mediclic/pages/register_page.dart';
// // // // // import 'package:mediclic/services/auth_service.dart';
// // // // // import 'package:firebase_auth/firebase_auth.dart';

// // // // // class HomeScreen extends StatefulWidget {
// // // // //   @override
// // // // //   _HomeScreenState createState() => _HomeScreenState();
// // // // // }

// // // // // class _HomeScreenState extends State<HomeScreen> {
// // // // //   String? _userRole;
// // // // //   int _selectedIndex = 0;
// // // // //   final AuthService _authService = AuthService();
// // // // //   bool _isLoading = true;

// // // // //   @override
// // // // //   void initState() {
// // // // //     super.initState();
// // // // //     _fetchUserRole();
// // // // //   }

// // // // //   Future<void> _fetchUserRole() async {
// // // // //     setState(() {
// // // // //       _isLoading = true;
// // // // //     });

// // // // //     try {
// // // // //       User? currentUser = FirebaseAuth.instance.currentUser; // Récupérer l'utilisateur actuel
// // // // //       if (currentUser == null) {
// // // // //         throw Exception("Utilisateur non connecté");
// // // // //       }

// // // // //       // Passer l'UID à getUserRole
// // // // //       String? role = await _authService.getUserRole(currentUser.uid);
// // // // //       print("Rôle brut récupéré: '$role'"); // Log pour déboguer

// // // // //       if (mounted) {
// // // // //         setState(() {
// // // // //           _userRole = role?.trim().toLowerCase();  // Normalisation du rôle
// // // // //           _isLoading = false;
// // // // //         });
// // // // //         print("Rôle utilisateur normalisé: '${_userRole}'");
// // // // //       }
// // // // //     } catch (e) {
// // // // //       print("Erreur lors de la récupération du rôle: $e");
// // // // //       if (mounted) {
// // // // //         setState(() {
// // // // //           _isLoading = false;
// // // // //         });
// // // // //       }
// // // // //     }
// // // // //   }

// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     if (_isLoading) {
// // // // //       return Scaffold(
// // // // //         body: Center(
// // // // //           child: Column(
// // // // //             mainAxisAlignment: MainAxisAlignment.center,
// // // // //             children: [
// // // // //               CircularProgressIndicator(),
// // // // //               SizedBox(height: 16),
// // // // //               Text("Chargement de votre profil...", style: TextStyle(fontSize: 16)),
// // // // //             ],
// // // // //           ),
// // // // //         ),
// // // // //       );
// // // // //     }

// // // // //     if (_userRole == null) {
// // // // //       return Scaffold(
// // // // //         body: Center(
// // // // //           child: Column(
// // // // //             mainAxisAlignment: MainAxisAlignment.center,
// // // // //             children: [
// // // // //               Icon(Icons.error_outline, size: 60, color: Colors.red),
// // // // //               SizedBox(height: 16),
// // // // //               Text("Impossible de charger votre profil", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
// // // // //               SizedBox(height: 8),
// // // // //               Text("Veuillez vous reconnecter", style: TextStyle(fontSize: 16)),
// // // // //               SizedBox(height: 24),
// // // // //               ElevatedButton(
// // // // //                 onPressed: () => _fetchUserRole(),
// // // // //                 child: Text("Réessayer"),
// // // // //               ),
// // // // //               SizedBox(height: 16),
// // // // //               ElevatedButton(
// // // // //                 onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
// // // // //                 child: Text("Retour à la connexion"),
// // // // //               ),
// // // // //             ],
// // // // //           ),
// // // // //         ),
// // // // //       );
// // // // //     }

// // // // //     String normalizedRole = _userRole!;
// // // // //     print("Construction de l'interface pour le rôle: $normalizedRole");

// // // // //     List<Widget> pages = [];
// // // // //     List<BottomNavigationBarItem> items = [];

// // // // //     switch (normalizedRole) {
// // // // //       case 'medecin':
// // // // //       case 'docteur':
// // // // //       case 'doctor':
// // // // //         pages = [
// // // // //           DoctorHomePage(),
// // // // //           HistoriquePage(),
// // // // //           DoctorProfilePage(),
// // // // //         ];
// // // // //         items = [
// // // // //           BottomNavigationBarItem(icon: Icon(Icons.home), label: "Accueil"),
// // // // //           BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: "Rendez-vous"),
// // // // //           BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
// // // // //         ];
// // // // //         break;
// // // // //       case 'clinique':
// // // // //       case 'clinic':
// // // // //         pages = [
// // // // //           RegisterPage(),  // ✅ Correction ici
// // // // //           ClinicProfileScreen(),
// // // // //         ];
// // // // //         items = [
// // // // //           BottomNavigationBarItem(icon: Icon(Icons.home), label: "Accueil"),
// // // // //           BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
// // // // //         ];
// // // // //         break;
// // // // //       default:
// // // // //         return Scaffold(
// // // // //           body: Center(
// // // // //             child: Column(
// // // // //               mainAxisAlignment: MainAxisAlignment.center,
// // // // //               children: [
// // // // //                 Icon(Icons.warning_amber_rounded, size: 60, color: Colors.orange),
// // // // //                 SizedBox(height: 16),
// // // // //                 Text("Rôle non reconnu: $_userRole", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
// // // // //                 SizedBox(height: 8),
// // // // //                 Text("Veuillez contacter l'administrateur", style: TextStyle(fontSize: 16)),
// // // // //                 SizedBox(height: 24),
// // // // //                 ElevatedButton(
// // // // //                   onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
// // // // //                   child: Text("Retour à la connexion"),
// // // // //                 ),
// // // // //               ],
// // // // //             ),
// // // // //           ),
// // // // //         );
// // // // //     }

// // // // //     if (_selectedIndex >= pages.length) {
// // // // //       _selectedIndex = 0;
// // // // //     }

// // // // //     return Scaffold(
// // // // //       appBar: AppBar(
// // // // //         title: Text(
// // // // //           normalizedRole.contains('medecin') || normalizedRole.contains('docteur') || normalizedRole.contains('doctor') ? 
// // // // //           "Espace Médecin" : "Espace Clinique"
// // // // //         ),
// // // // //         actions: [
// // // // //           IconButton(
// // // // //             icon: Icon(Icons.logout),
// // // // //             onPressed: () async {
// // // // //               await _authService.signOut();
// // // // //               Navigator.pushReplacementNamed(context, '/login');
// // // // //             },
// // // // //           ),
// // // // //         ],
// // // // //       ),
// // // // //       body: pages[_selectedIndex],
// // // // //       bottomNavigationBar: BottomNavigationBar(
// // // // //         currentIndex: _selectedIndex,
// // // // //         onTap: (index) => setState(() => _selectedIndex = index),
// // // // //         items: items,
// // // // //         selectedItemColor: Theme.of(context).primaryColor,
// // // // //         unselectedItemColor: Colors.grey,
// // // // //         type: BottomNavigationBarType.fixed,
// // // // //         showUnselectedLabels: true,
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // // }
// // // // import 'package:flutter/material.dart';
// // // // import 'package:mediclic/clinique/pages/CliniqueHomeScreen.dart';
// // // // import 'package:mediclic/clinique/pages/profilClinique.dart';
// // // // import 'package:mediclic/doctor/pages/dashboard.dart';
// // // // import 'package:mediclic/doctor/pages/historique.dart';
// // // // import 'package:mediclic/doctor/pages/profil.dart';
// // // // import 'package:mediclic/pages/admin.dart';
// // // // import 'package:mediclic/pages/register_page.dart';
// // // // import 'package:mediclic/services/auth_service.dart';
// // // // import 'package:firebase_auth/firebase_auth.dart';

// // // // class HomeScreen extends StatefulWidget {
// // // //   @override
// // // //   _HomeScreenState createState() => _HomeScreenState();
// // // // }

// // // // class _HomeScreenState extends State<HomeScreen> {
// // // //   String? _userRole;
// // // //   int _selectedIndex = 0;
// // // //   final AuthService _authService = AuthService();
// // // //   bool _isLoading = true;

// // // //   @override
// // // //   void initState() {
// // // //     super.initState();
// // // //     _fetchUserRole();
// // // //   }

// // // //   Future<void> _fetchUserRole() async {
// // // //     setState(() => _isLoading = true);
// // // //     try {
// // // //       User? currentUser = FirebaseAuth.instance.currentUser;
// // // //       if (currentUser == null) throw Exception("Utilisateur non connecté");
// // // //       String? role = await _authService.getUserRole(currentUser.uid);
// // // //       if (mounted) {
// // // //         setState(() {
// // // //           _userRole = role?.trim().toLowerCase();
// // // //           _isLoading = false;
// // // //         });
// // // //       }
// // // //     } catch (e) {
// // // //       if (mounted) {
// // // //         setState(() => _isLoading = false);
// // // //       }
// // // //     }
// // // //   }

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     if (_isLoading) {
// // // //       return Scaffold(
// // // //         body: Center(
// // // //           child: Column(
// // // //             mainAxisAlignment: MainAxisAlignment.center,
// // // //             children: [
// // // //               CircularProgressIndicator(),
// // // //               SizedBox(height: 16),
// // // //               Text("Chargement de votre profil...", style: TextStyle(fontSize: 16)),
// // // //             ],
// // // //           ),
// // // //         ),
// // // //       );
// // // //     }

// // // //     if (_userRole == null) {
// // // //       return Scaffold(
// // // //         body: Center(
// // // //           child: Column(
// // // //             mainAxisAlignment: MainAxisAlignment.center,
// // // //             children: [
// // // //               Icon(Icons.error_outline, size: 60, color: Colors.red),
// // // //               SizedBox(height: 16),
// // // //               Text("Impossible de charger votre profil", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
// // // //               SizedBox(height: 8),
// // // //               ElevatedButton(onPressed: _fetchUserRole, child: Text("Réessayer")),
// // // //               SizedBox(height: 16),
// // // //               ElevatedButton(onPressed: () => Navigator.pushReplacementNamed(context, '/login'), child: Text("Retour à la connexion")),
// // // //             ],
// // // //           ),
// // // //         ),
// // // //       );
// // // //     }

// // // //     Map<String, List<dynamic>> roleConfig = {
// // // //       'medecin': [
// // // //         [DoctorHomePage(), HistoriquePage(), DoctorProfilePage()],
// // // //         ["Accueil", "Rendez-vous", "Profil"],
// // // //         [Icons.home, Icons.calendar_today, Icons.person]
// // // //       ],
// // // //       'clinique': [
// // // //         [RegisterClinicWidget(), ClinicProfileScreen()],
// // // //         ["Accueil", "Profil"],
// // // //         [Icons.home, Icons.person]
// // // //       ],
// // // //       'admin': [
// // // //         [AdminPage()],
// // // //         ["Dashboard"],
// // // //         [Icons.dashboard]
// // // //       ],
// // // //     };

// // // //     String normalizedRole = _userRole!;
// // // //     if (!roleConfig.containsKey(normalizedRole)) {
// // // //       return Scaffold(
// // // //         body: Center(
// // // //           child: Column(
// // // //             mainAxisAlignment: MainAxisAlignment.center,
// // // //             children: [
// // // //               Icon(Icons.warning_amber_rounded, size: 60, color: Colors.orange),
// // // //               SizedBox(height: 16),
// // // //               Text("Rôle non reconnu: $_userRole", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
// // // //               SizedBox(height: 24),
// // // //               ElevatedButton(onPressed: () => Navigator.pushReplacementNamed(context, '/login'), child: Text("Retour à la connexion")),
// // // //             ],
// // // //           ),
// // // //         ),
// // // //       );
// // // //     }

// // // //     List<Widget> pages = roleConfig[normalizedRole]![0];
// // // //     List<String> labels = roleConfig[normalizedRole]![1];
// // // //     List<IconData> icons = roleConfig[normalizedRole]![2];

// // // //     return Scaffold(
// // // //       appBar: AppBar(
// // // //         title: Text(normalizedRole == 'admin' ? "Espace Admin" : "Espace ${normalizedRole.capitalize()}"),
// // // //         actions: [
// // // //           IconButton(
// // // //             icon: Icon(Icons.logout),
// // // //             onPressed: () async {
// // // //               await _authService.signOut();
// // // //               Navigator.pushReplacementNamed(context, '/login');
// // // //             },
// // // //           ),
// // // //         ],
// // // //       ),
// // // //       body: pages[_selectedIndex],
// // // //       bottomNavigationBar: BottomNavigationBar(
// // // //         currentIndex: _selectedIndex,
// // // //         onTap: (index) => setState(() => _selectedIndex = index),
// // // //         items: List.generate(labels.length, (index) => BottomNavigationBarItem(icon: Icon(icons[index]), label: labels[index])),
// // // //         selectedItemColor: Theme.of(context).primaryColor,
// // // //         unselectedItemColor: Colors.grey,
// // // //         type: BottomNavigationBarType.fixed,
// // // //         showUnselectedLabels: true,
// // // //       ),
// // // //     );
// // // //   }
// // // // }

// // // // extension StringExtension on String {
// // // //   String capitalize() => this.isNotEmpty ? '${this[0].toUpperCase()}${this.substring(1)}' : this;
// // // // }
// // // import 'package:flutter/material.dart';
// // // import 'package:mediclic/clinique/pages/CliniqueHomeScreen.dart';
// // // import 'package:mediclic/clinique/pages/profilClinique.dart';
// // // import 'package:mediclic/doctor/pages/dashboard.dart';
// // // import 'package:mediclic/doctor/pages/historique.dart';
// // // import 'package:mediclic/doctor/pages/profil.dart';
// // // import 'package:mediclic/pages/admin.dart';
// // // import 'package:mediclic/pages/register_page.dart';
// // // import 'package:mediclic/services/auth_service.dart';
// // // import 'package:firebase_auth/firebase_auth.dart';

// // // class HomeScreen extends StatefulWidget {
// // //   @override
// // //   _HomeScreenState createState() => _HomeScreenState();
// // // }

// // // class _HomeScreenState extends State<HomeScreen> {
// // //   String? _userRole;
// // //   int _selectedIndex = 0;
// // //   final AuthService _authService = AuthService();
// // //   bool _isLoading = true;

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     _fetchUserRole();
// // //   }

// // //   Future<void> _fetchUserRole() async {
// // //     setState(() => _isLoading = true);
// // //     try {
// // //       User? currentUser = FirebaseAuth.instance.currentUser;
// // //       if (currentUser == null) throw Exception("Utilisateur non connecté");
// // //       String? role = await _authService.getUserRole(currentUser.uid);
// // //       if (mounted) {
// // //         setState(() {
// // //           _userRole = role?.trim().toLowerCase();
// // //           _isLoading = false;
// // //         });
// // //         print("Rôle utilisateur récupéré: $_userRole"); // Log pour debug
// // //       }
// // //     } catch (e) {
// // //       print("Erreur lors de la récupération du rôle: $e"); // Log pour debug
// // //       if (mounted) {
// // //         setState(() => _isLoading = false);
// // //       }
// // //     }
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     print("Building HomeScreen: role=$_userRole, index=$_selectedIndex"); // Log pour debug
    
// // //     if (_isLoading) {
// // //       return Scaffold(
// // //         body: Center(
// // //           child: Column(
// // //             mainAxisAlignment: MainAxisAlignment.center,
// // //             children: [
// // //               CircularProgressIndicator(),
// // //               SizedBox(height: 16),
// // //               Text("Chargement de votre profil...", style: TextStyle(fontSize: 16)),
// // //             ],
// // //           ),
// // //         ),
// // //       );
// // //     }

// // //     if (_userRole == null) {
// // //       return Scaffold(
// // //         body: Center(
// // //           child: Column(
// // //             mainAxisAlignment: MainAxisAlignment.center,
// // //             children: [
// // //               Icon(Icons.error_outline, size: 60, color: Colors.red),
// // //               SizedBox(height: 16),
// // //               Text("Impossible de charger votre profil", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
// // //               SizedBox(height: 8),
// // //               ElevatedButton(onPressed: _fetchUserRole, child: Text("Réessayer")),
// // //               SizedBox(height: 16),
// // //               ElevatedButton(onPressed: () => Navigator.pushReplacementNamed(context, '/login'), child: Text("Retour à la connexion")),
// // //             ],
// // //           ),
// // //         ),
// // //       );
// // //     }

// // //     Map<String, List<dynamic>> roleConfig = {
// // //       'medecin': [
// // //         [DoctorHomePage(), HistoriquePage(), DoctorProfilePage()],
// // //         ["Accueil", "Rendez-vous", "Profil"],
// // //         [Icons.home, Icons.calendar_today, Icons.person]
// // //       ],
// // //       'clinique': [
// // //         [RegisterClinicWidget(), ClinicProfileScreen()],
// // //         ["Accueil", "Profil"],
// // //         [Icons.home, Icons.person]
// // //       ],
// // //       'admin': [
// // //         [AdminPage()],
// // //         ["Dashboard"],
// // //         [Icons.dashboard]
// // //       ],
// // //     };

// // //     String normalizedRole = _userRole!;
// // //     if (!roleConfig.containsKey(normalizedRole)) {
// // //       return Scaffold(
// // //         body: Center(
// // //           child: Column(
// // //             mainAxisAlignment: MainAxisAlignment.center,
// // //             children: [
// // //               Icon(Icons.warning_amber_rounded, size: 60, color: Colors.orange),
// // //               SizedBox(height: 16),
// // //               Text("Rôle non reconnu: $_userRole", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
// // //               SizedBox(height: 24),
// // //               ElevatedButton(onPressed: () => Navigator.pushReplacementNamed(context, '/login'), child: Text("Retour à la connexion")),
// // //             ],
// // //           ),
// // //         ),
// // //       );
// // //     }

// // //     List<Widget> pages = roleConfig[normalizedRole]![0];
// // //     List<String> labels = roleConfig[normalizedRole]![1];
// // //     List<IconData> icons = roleConfig[normalizedRole]![2];

// // //     // S'assurer que l'index sélectionné est valide
// // //     if (_selectedIndex >= pages.length) {
// // //       _selectedIndex = 0;
// // //     }

// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text(normalizedRole == 'admin' ? "Espace Admin" : "Espace ${normalizedRole.capitalize()}"),
// // //         actions: [
// // //           IconButton(
// // //             icon: Icon(Icons.logout),
// // //             onPressed: () async {
// // //               await _authService.signOut();
// // //               Navigator.pushReplacementNamed(context, '/login');
// // //             },
// // //           ),
// // //         ],
// // //       ),
// // //       body: IndexedStack(
// // //         index: _selectedIndex,
// // //         children: pages,
// // //       ),
// // //       bottomNavigationBar: BottomNavigationBar(
// // //         currentIndex: _selectedIndex,
// // //         onTap: (index) {
// // //           print("Navigation tapped: index=$index"); // Log pour debug
// // //           setState(() => _selectedIndex = index);
// // //         },
// // //         items: List.generate(
// // //           labels.length, 
// // //           (index) => BottomNavigationBarItem(
// // //             icon: Icon(icons[index]), 
// // //             label: labels[index]
// // //           )
// // //         ),
// // //         selectedItemColor: Theme.of(context).primaryColor,
// // //         unselectedItemColor: Colors.grey,
// // //         type: BottomNavigationBarType.fixed,
// // //         showUnselectedLabels: true,
// // //       ),
// // //     );
// // //   }
// // // }

// // // extension StringExtension on String {
// // //   String capitalize() => this.isNotEmpty ? '${this[0].toUpperCase()}${this.substring(1)}' : this;
// // // }
// // import 'package:flutter/material.dart';
// // import 'package:mediclic/clinique/pages/CliniqueHomeScreen.dart';
// // import 'package:mediclic/clinique/pages/profilClinique.dart';
// // import 'package:mediclic/doctor/pages/dashboard.dart';
// // import 'package:mediclic/doctor/pages/historique.dart';
// // import 'package:mediclic/doctor/pages/profil.dart';
// // import 'package:mediclic/pages/admin.dart';
// // import 'package:mediclic/pages/register_page.dart';
// // import 'package:mediclic/services/auth_service.dart';
// // import 'package:firebase_auth/firebase_auth.dart';

// // class HomeScreen extends StatefulWidget {
// //   @override
// //   _HomeScreenState createState() => _HomeScreenState();
// // }

// // class _HomeScreenState extends State<HomeScreen> {
// //   String? _userRole;
// //   int _selectedIndex = 0;
// //   final AuthService _authService = AuthService();
// //   bool _isLoading = true;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _fetchUserRole();
// //   }

// //   Future<void> _fetchUserRole() async {
// //     setState(() => _isLoading = true);
// //     try {
// //       User? currentUser = FirebaseAuth.instance.currentUser;
// //       if (currentUser == null) throw Exception("Utilisateur non connecté");
      
// //       String? role = await _authService.getUserRole(currentUser.uid);
      
// //       // Log pour debug
// //       print("Rôle récupéré de Firebase: $role");
      
// //       if (mounted) {
// //         setState(() {
// //           _userRole = role?.trim().toLowerCase();
// //           _isLoading = false;
// //         });
// //       }
// //     } catch (e) {
// //       print("Erreur lors de la récupération du rôle: $e");
// //       if (mounted) {
// //         setState(() => _isLoading = false);
// //       }
// //     }
// //   }

// //   void _changeIndex(int index) {
// //     print("Changement d'index vers: $index");
// //     if (mounted) {
// //       setState(() {
// //         _selectedIndex = index;
// //       });
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     print("Build appelé avec rôle: $_userRole et index: $_selectedIndex");
    
// //     if (_isLoading) {
// //       return Scaffold(
// //         body: Center(
// //           child: Column(
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             children: [
// //               CircularProgressIndicator(),
// //               SizedBox(height: 16),
// //               Text("Chargement de votre profil...", style: TextStyle(fontSize: 16)),
// //             ],
// //           ),
// //         ),
// //       );
// //     }

// //     if (_userRole == null) {
// //       return Scaffold(
// //         body: Center(
// //           child: Column(
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             children: [
// //               Icon(Icons.error_outline, size: 60, color: Colors.red),
// //               SizedBox(height: 16),
// //               Text("Impossible de charger votre profil", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
// //               SizedBox(height: 8),
// //               ElevatedButton(onPressed: _fetchUserRole, child: Text("Réessayer")),
// //               SizedBox(height: 16),
// //               ElevatedButton(
// //                 onPressed: () async {
// //                   await _authService.signOut();
// //                   Navigator.pushReplacementNamed(context, '/login');
// //                 },
// //                 child: Text("Retour à la connexion")
// //               ),
// //             ],
// //           ),
// //         ),
// //       );
// //     }

// //     // Interface médecin
// //     if (_userRole == 'medecin' || _userRole == 'docteur') {
// //       List<Widget> pages = [
// //         DoctorHomePage(),
// //         HistoriquePage(),
// //         DoctorProfilePage(),
// //       ];
      
// //       // S'assurer que l'index est valide
// //       if (_selectedIndex >= pages.length) {
// //         _selectedIndex = 0;
// //       }
      
// //       return Scaffold(
// //         appBar: AppBar(
// //           title: Text("Espace Médecin"),
// //           actions: [
// //             IconButton(
// //               icon: Icon(Icons.logout),
// //               onPressed: () async {
// //                 await _authService.signOut();
// //                 Navigator.pushReplacementNamed(context, '/login');
// //               },
// //             ),
// //           ],
// //         ),
// //         body: pages[_selectedIndex],
// //         bottomNavigationBar: Container(
// //           decoration: BoxDecoration(
// //             boxShadow: [
// //               BoxShadow(
// //                 color: Colors.black12,
// //                 blurRadius: 8,
// //               ),
// //             ],
// //           ),
// //           child: BottomNavigationBar(
// //             currentIndex: _selectedIndex,
// //             onTap: _changeIndex,
// //             items: [
// //               BottomNavigationBarItem(icon: Icon(Icons.home), label: "Accueil"),
// //               BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: "Rendez-vous"),
// //               BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
// //             ],
// //             selectedItemColor: Theme.of(context).primaryColor,
// //             unselectedItemColor: Colors.grey,
// //             type: BottomNavigationBarType.fixed,
// //             elevation: 10,
// //           ),
// //         ),
// //       );
// //     }
    
// //     // Interface clinique
// //     else if (_userRole == 'clinique' || _userRole == 'clinic') {
// //       List<Widget> pages = [
// //         RegisterClinicWidget(),
// //         ClinicProfileScreen(),
// //       ];
      
// //       if (_selectedIndex >= pages.length) {
// //         _selectedIndex = 0;
// //       }
      
// //       return Scaffold(
// //         appBar: AppBar(
// //           title: Text("Espace Clinique"),
// //           actions: [
// //             IconButton(
// //               icon: Icon(Icons.logout),
// //               onPressed: () async {
// //                 await _authService.signOut();
// //                 Navigator.pushReplacementNamed(context, '/login');
// //               },
// //             ),
// //           ],
// //         ),
// //         body: pages[_selectedIndex],
// //         bottomNavigationBar: Container(
// //           decoration: BoxDecoration(
// //             boxShadow: [
// //               BoxShadow(
// //                 color: Colors.black12,
// //                 blurRadius: 8,
// //               ),
// //             ],
// //           ),
// //           child: BottomNavigationBar(
// //             currentIndex: _selectedIndex,
// //             onTap: _changeIndex,
// //             items: [
// //               BottomNavigationBarItem(icon: Icon(Icons.home), label: "Accueil"),
// //               BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
// //             ],
// //             selectedItemColor: Theme.of(context).primaryColor,
// //             unselectedItemColor: Colors.grey,
// //             type: BottomNavigationBarType.fixed,
// //             elevation: 10,
// //           ),
// //         ),
// //       );
// //     }
    
// //     // Interface admin
// //     else if (_userRole == 'admin') {
// //       return Scaffold(
// //         appBar: AppBar(
// //           title: Text("Espace Admin"),
// //           actions: [
// //             IconButton(
// //               icon: Icon(Icons.logout),
// //               onPressed: () async {
// //                 await _authService.signOut();
// //                 Navigator.pushReplacementNamed(context, '/login');
// //               },
// //             ),
// //           ],
// //         ),
// //         body: AdminPage(),
// //         bottomNavigationBar: Container(
// //           decoration: BoxDecoration(
// //             boxShadow: [
// //               BoxShadow(
// //                 color: Colors.black12,
// //                 blurRadius: 8,
// //               ),
// //             ],
// //           ),
// //           child: BottomNavigationBar(
// //             currentIndex: 0,
// //             items: [
// //               BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Dashboard"),
// //             ],
// //             selectedItemColor: Theme.of(context).primaryColor,
// //             unselectedItemColor: Colors.grey,
// //           ),
// //         ),
// //       );
// //     }
    
// //     // Rôle non reconnu
// //     else {
// //       return Scaffold(
// //         body: Center(
// //           child: Column(
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             children: [
// //               Icon(Icons.warning_amber_rounded, size: 60, color: Colors.orange),
// //               SizedBox(height: 16),
// //               Text("Rôle non reconnu: $_userRole", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
// //               SizedBox(height: 24),
// //               ElevatedButton(
// //                 onPressed: () async {
// //                   await _authService.signOut();
// //                   Navigator.pushReplacementNamed(context, '/login');
// //                 },
// //                 child: Text("Retour à la connexion")
// //               ),
// //             ],
// //           ),
// //         ),
// //       );
// //     }
// //   }
// // }

// // extension StringExtension on String {
// //   String capitalize() => this.isNotEmpty ? '${this[0].toUpperCase()}${this.substring(1)}' : this;
// // }
// import 'package:flutter/material.dart';
// // Importez ici les autres packages nécessaires

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   int _selectedIndex = 0;
  
//   // Définissez la méthode HomeContainer ici
//   Widget homeContainer() {
//     return Container(
//       padding: EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Bienvenue sur MediClinique',
//             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 20),
//           Card(
//             elevation: 4,
//             child: Padding(
//               padding: EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Prochains rendez-vous',
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 10),
//                   // Liste des rendez-vous
//                   // Vous pouvez ajouter ici votre logique pour afficher les rendez-vous
//                 ],
//               ),
//             ),
//           ),
//           SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: () {
//               // Navigation vers la page des disponibilités
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => AvailabilityCalendar(doctorId: 'doctor123'),
//                 ),
//               );
//             },
//             child: Text('Gérer mes disponibilités'),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.purple,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
  
//   // Définissez vos autres containers ici
//   Widget appointmentsContainer() {
//     return Container(
//       child: Center(
//         child: Text('Rendez-vous'),
//       ),
//     );
//   }
  
//   Widget filesContainer() {
//     return Container(
//       child: Center(
//         child: Text('Dossiers'),
//       ),
//     );
//   }
  
//   Widget calendarContainer() {
//     return Container(
//       child: Center(
//         child: Text('Calendrier'),
//       ),
//     );
//   }
  
//   Widget profileContainer() {
//     return Container(
//       child: Center(
//         child: Text('Profil'),
//       ),
//     );
//   }
  
//   @override
//   Widget build(BuildContext context) {
//     // Liste des widgets à afficher en fonction de l'index sélectionné
//     final List<Widget> _widgetOptions = [
//       homeContainer(), // Utilisation de la méthode correctement nommée
//       appointmentsContainer(),
//       filesContainer(),
//       calendarContainer(),
//       profileContainer(),
//     ];
    
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('MediClinique'),
//         backgroundColor: Colors.purple,
//       ),
//       body: _widgetOptions.elementAt(_selectedIndex),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Tableau',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.history),
//             label: 'Historique',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.calendar_today),
//             label: 'RDV',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.folder),
//             label: 'Dossiers',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profil',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: Colors.purple,
//         unselectedItemColor: Colors.grey,
//         onTap: (index) {
//           setState(() {
//             _selectedIndex = index;
//           });
//         },
//         type: BottomNavigationBarType.fixed,
//       ),
//     );
//   }
// }

// // Ajoutez cette classe si vous ne l'avez pas déjà importée
// class AvailabilityCalendar extends StatelessWidget {
//   final String doctorId;
  
//   const AvailabilityCalendar({Key? key, required this.doctorId}) : super(key: key);
  
//   @override
//   Widget build(BuildContext context) {
//     // Implémentation du calendrier des disponibilités...
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Disponibilités'),
//         backgroundColor: Colors.purple,
//       ),
//       body: Center(
//         child: Text('Calendrier des disponibilités pour le docteur $doctorId'),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:mediclic/clinique/pages/CliniqueHomeScreen.dart';
import 'package:mediclic/clinique/pages/profilClinique.dart';
import 'package:mediclic/doctor/pages/dashboard.dart';
import 'package:mediclic/doctor/pages/dossier1.dart';
import 'package:mediclic/doctor/pages/historique.dart';
import 'package:mediclic/doctor/pages/profil.dart';
import 'package:mediclic/doctor/pages/rdv.dart';
import 'package:mediclic/pages/root.dart';
import 'package:mediclic/services/auth_service.dart';

// Imports pour les pages médecin

// Widget Container principal pour gérer la navigation et les pages selon le rôle
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
      // Configuration pour le médecin avec 6 pages
      _widgetOptions = [
        DoctorHomePage(),
        HistoriquePage(),
        RdvPage(),
        DossierMedicalForm(),
         AvailabilityCalendar(doctorId: '',),
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
      // Configuration pour la clinique avec 2 pages
      _widgetOptions = [
        RegisterClinicWidget(),
        ClinicProfileScreen(),
      ];
      _appBarTitles = ["Accueil", "Profil"];
      _navigationItems = [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Accueil"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
      ];
    } else {
      // Rôle par défaut ou patient
      // _widgetOptions = [
      // //   PatientHomePage(),
      // //   PatientAppointmentsPage(),
      // //   PatientDoctorsPage(),
      // //   PatientProfilePage(),
      // // ];
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