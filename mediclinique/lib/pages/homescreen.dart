import 'package:flutter/material.dart';
import 'package:mediclic/clinique/pages/CliniqueHomeScreen.dart';
import 'package:mediclic/clinique/pages/profilClinique.dart';
import 'package:mediclic/doctor/pages/dashboard.dart';
import 'package:mediclic/doctor/pages/historique.dart';
import 'package:mediclic/doctor/pages/profil.dart';
import 'package:mediclic/services/auth_service.dart';

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
    setState(() {
      _isLoading = true;
    });
    
    try {
      String? role = await _authService.getUserRole();
      print("Rôle brut récupéré: '$role'"); // Log pour déboguer
      
      if (mounted) {
        setState(() {
          _userRole = role;
          _isLoading = false;
        });
        print("Rôle utilisateur normalisé: '${_userRole?.trim().toLowerCase()}'");
      }
    } catch (e) {
      print("Erreur lors de la récupération du rôle: $e");
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Afficher un indicateur de chargement pendant la récupération du rôle
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

    // Si le rôle n'a pas été récupéré, afficher un message d'erreur
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
              Text("Veuillez vous reconnecter", style: TextStyle(fontSize: 16)),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  _fetchUserRole(); // Tentative de récupération du rôle
                },
                child: Text("Réessayer"),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: Text("Retour à la connexion"),
              ),
            ],
          ),
        ),
      );
    }

    // Normaliser le rôle pour gérer les différentes orthographes
    String normalizedRole = _userRole!.trim().toLowerCase();
    print("Construction de l'interface pour le rôle: $normalizedRole");

    // Définir les pages en fonction du rôle
    List<Widget> pages = [];
    List<BottomNavigationBarItem> items = [];

    // Correction du double switch et erreur de syntaxe
    switch (normalizedRole) {
      case 'medecin':
      case 'docteur':
      case 'doctor': // Ajout d'autres variantes possibles
        pages = [
          DoctorHomePage(),
          HistoriquePage(),
          DoctorProfilePage(),
        ];
        items = [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Accueil"),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: "Rendez-vous"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
        ];
        break;
      case 'clinique':
      case 'clinic': // Ajout d'autres variantes possibles
        pages = [
          RegisterDoctorWidget(),  // Page d'accueil pour clinique
          ClinicProfileScreen(),    // Profil de la clinique
        ];
        items = [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Accueil"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
        ];
        break;
      default:
        // Rôle inconnu, afficher un écran d'erreur
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.warning_amber_rounded, size: 60, color: Colors.orange),
                SizedBox(height: 16),
                Text("Rôle non reconnu: $_userRole", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text("Veuillez contacter l'administrateur", style: TextStyle(fontSize: 16)),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: Text("Retour à la connexion"),
                ),
              ],
            ),
          ),
        );
    }

    // Vérifier que l'index sélectionné est valide
    if (_selectedIndex >= pages.length) {
      _selectedIndex = 0;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          normalizedRole.contains('medecin') || normalizedRole.contains('docteur') || normalizedRole.contains('doctor') ? 
          "Espace Médecin" : "Espace Clinique"
        ),
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
        items: items,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
      ),
    );
  }
}