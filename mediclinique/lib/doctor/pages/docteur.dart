import 'package:flutter/material.dart';
import 'package:mediclic/main.dart';
import 'package:mediclic/doctor/pages/dossier1.dart';
void main() async {
  
  
  // Lancer l'application
  runApp(MyApp());
}
class DocteurPage extends StatefulWidget {
  const DocteurPage({super.key});

  @override
  State<DocteurPage> createState() => _DocteurPageState();
}

class _DocteurPageState extends State<DocteurPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
DossierMedicalForm(),
        ],
      ),
    );
  }
}
