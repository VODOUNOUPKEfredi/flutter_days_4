import 'package:flutter/material.dart';
import 'package:mediclic/pages/home.dart';
import 'package:mediclic/pages/historiqueMedical.dart';
import 'package:mediclic/pages/dossierMedical.dart';
import 'package:mediclic/pages/profil.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});
  // This widget is the root of your application.
  @override
  State<StatefulWidget> createState() {
    return NavigationState();
  }
}

class NavigationState extends State {
  final pages = [Home(), Historiquemedical(), Dossiermedical(), Profil()];
  int initialPageIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      initialPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primarySwatch: Colors.blue,
          canvasColor: const Color.fromARGB(255, 255, 255, 255)),
      home: Scaffold(
        body: pages[initialPageIndex],
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color.fromARGB(255, 7, 185, 255),
          unselectedItemColor: const Color.fromARGB(134, 129, 152, 163),
          iconSize: 30,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: 'Accueil',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'Historique medical',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.file_copy),
              label: 'Dossier medical',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_2_rounded),
              label: 'Profil',
            ),
          ],
          currentIndex: initialPageIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
