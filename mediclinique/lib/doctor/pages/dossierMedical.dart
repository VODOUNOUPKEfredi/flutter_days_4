import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mediclinique',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor: Colors.grey.shade200,
      ),
      home: const PatientInfoScreen(),
    );
  }
}

class PatientInfoScreen extends StatelessWidget {
  const PatientInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // App Bar
          Container(
            color: const Color(0xFF8E6CC9),
            padding: const EdgeInsets.only(top: 40, bottom: 12),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {},
                ),
                const Text(
                  'Mediclinique',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          
          // Patient Avatar Section
          Container(
            color: Colors.grey.shade300,
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Center(
              child: Column(
                children: [
                  const Text(
                    '440 x 82',
                    style: TextStyle(color: Colors.blue),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFC107),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.person_outline,
                        size: 50,
                        color: Colors.amber.shade800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Content
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Personal Information
                const Text(
                  'Informations personnelles du patient',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          SizedBox(width: 80, child: Text('Nom :')),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(vertical: 0),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: const [
                          SizedBox(width: 80, child: Text('Prénom :')),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(vertical: 0),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: const [
                          SizedBox(width: 140, child: Text('Date de naissance :')),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(vertical: 0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                // Add Diagnostic
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Ajouter un diagnostique ou un compte rendu',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.add, size: 20),
                      ),
                    ],
                  ),
                ),
                
                // Current Treatments
                const SizedBox(height: 16),
                const Text(
                  'Traitements en cours',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Pathologie grave',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text('Détails :'),
                      const SizedBox(height: 4),
                      const Text('Traitement en prévision de l\'artériotomie'),
                      const SizedBox(height: 4),
                      const Text('HOPITAL UNIVERSITAIRE CNHU'),
                      Row(
                        children: const [
                          Text('Début : 15/03/2025'),
                          Spacer(),
                          Text('Fin : 30/03/2025'),
                        ],
                      ),
                    ],
                  ),
                ),
                
                // Medical History
                const SizedBox(height: 16),
                const Text(
                  'Antécédents médicaux',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Pathologie grave',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text('Détails :'),
                      const SizedBox(height: 4),
                      const Text('Traitement en prévision de l\'artériotomie'),
                      const SizedBox(height: 4),
                      const Text('HOPITAL UNIVERSITAIRE CNHU'),
                      Row(
                        children: const [
                          Text('Début : 15/03/2025'),
                          Spacer(),
                          Text('Fin : 30/03/2025'),
                        ],
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 40),
              ],
            ),
          ),
          
          // Bottom Navigation
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey.shade300)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(Icons.circle_outlined, color: Colors.grey),
                Icon(Icons.circle, color: Colors.grey.shade400),
                const Icon(Icons.circle_outlined, color: Colors.grey),
              ],
            ),
          ),
        ],
      ),
    );
  }
}