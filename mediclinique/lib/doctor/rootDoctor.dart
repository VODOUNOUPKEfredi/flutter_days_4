import 'package:flutter/material.dart';
import 'package:mediclic/clinique/pages/profilClinique.dart';
import 'package:mediclic/doctor/pages/dashboard.dart';
import 'package:mediclic/doctor/pages/docteurdispo.dart';
import 'package:mediclic/doctor/pages/historique.dart';
import 'package:mediclic/doctor/pages/profil.dart';
import 'package:mediclic/pages/register_page.dart';
import 'package:mediclic/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  String? _userRole;
  int _selectedIndex = 0;
  bool _isLoading = true;
  late AnimationController _animationController;
  
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fetchUserRole();
  }
  
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _fetchUserRole() async {
    try {
      // Récupérer l'utilisateur actuel
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        throw Exception("Utilisateur non connecté");
      }
      
      // Passer l'UID à getUserRole
      String? role = await AuthService().getUserRole(currentUser.uid);
      if (mounted) {
        setState(() {
          _userRole = role;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _userRole = null;
          _isLoading = false;
        });
      }
      debugPrint("Erreur lors de la récupération du rôle: $e");
    }
  }

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
      _animationController.reset();
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png', // Remplacez par votre logo
                height: 80,
                width: 80,
              ),
              const SizedBox(height: 24),
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text(
                'Chargement...',
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Pages du médecin
    final List<Widget> doctorPages = [
      FadeTransition(
        opacity: _animationController..forward(),
        child: const DoctorHomePage(),
      ),
      FadeTransition(
        opacity: _animationController..forward(),
        child: const HistoriquePage(),
      ),
      FadeTransition(
        opacity: _animationController..forward(),
        child:  AvailabilityCalendar()
      ),
      FadeTransition(
        opacity: _animationController..forward(),
        child:  DoctorProfilePage(),
      ),
    ];

    // Pages de la clinique
    final List<Widget> clinicPages = [
      FadeTransition(
        opacity: _animationController..forward(),
        child:  RegisterPage(),
      ),
      FadeTransition(
        opacity: _animationController..forward(),
        child: ClinicProfileScreen(),
      ),
      FadeTransition(
        opacity: _animationController..forward(),
        child:  ClinicProfileScreen(),
      ),
    ];

    // Déterminer les pages en fonction du rôle
    final List<Widget> pages = _userRole == 'medecin' ? doctorPages : clinicPages;

    return Scaffold(
      body: Stack(
        children: [
          // Page actuelle
          pages[_selectedIndex],
          
          // Barre de navigation personnalisée
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                  child: _userRole == 'medecin'
                      ? _buildDoctorNavBar()
                      : _buildClinicNavBar(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorNavBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildNavItem(0, Icons.home_rounded, 'Accueil'),
        _buildNavItem(1, Icons.calendar_today_rounded, 'Historique '),
        _buildNavItem(2, Icons.calendar_month_rounded, 'Disponibilité'),
        _buildNavItem(3, Icons.person_rounded, 'Profil'),
      ],
    );
  }

  Widget _buildClinicNavBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildNavItem(0, Icons.home_rounded, 'Accueil'),
        _buildNavItem(1, Icons.people_rounded, 'Patients'),
        _buildNavItem(2, Icons.person_rounded, 'Profil'),
      ],
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final bool isSelected = _selectedIndex == index;
    
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Theme.of(context).primaryColor.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? Theme.of(context).primaryColor : Colors.grey,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Theme.of(context).primaryColor : Colors.grey,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}