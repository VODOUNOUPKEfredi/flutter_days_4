import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CNHU Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const DoctorHomePage(),
    );
  }
}

class DoctorHomePage extends StatelessWidget {
  const DoctorHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: const Color(0xFF8E6CC9),
              width: double.infinity,
              child: const Text(
                'CNHU',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            
            // Dashboard Title
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Dashboard',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            
            // Statistics Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  // Rendez-vous aujourd'hui
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade200),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                          .collection('appointments')
                          .where('date', isEqualTo: DateTime.now().toString().substring(0, 10))
                          .snapshots(),
                        builder: (context, snapshot) {
                          int appointmentCount = 0;
                          if (snapshot.hasData) {
                            appointmentCount = snapshot.data!.docs.length;
                          }
                          
                          return Column(
                            children: [
                              const Text(
                                'Rendez-vous aujourd\'hui',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    snapshot.hasData ? appointmentCount.toString() : '...',
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Icon(Icons.calendar_today, size: 16, color: Colors.blue.shade300),
                                ],
                              ),
                            ],
                          );
                        }
                      ),
                    ),
                  ),
                  
                  const SizedBox(width: 12),
                  
                  // Patients en attente
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade200),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                          .collection('appointments')
                          .where('status', isEqualTo: 'waiting')
                          .snapshots(),
                        builder: (context, snapshot) {
                          int waitingCount = 0;
                          if (snapshot.hasData) {
                            waitingCount = snapshot.data!.docs.length;
                          }
                          
                          return Column(
                            children: [
                              const Text(
                                'Patients en attente',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    snapshot.hasData ? waitingCount.toString() : '...',
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Icon(Icons.access_time, size: 16, color: Colors.red.shade300),
                                ],
                              ),
                            ],
                          );
                        }
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Upcoming Patients Section
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Prochains patients',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      'Voir tout',
                      style: TextStyle(
                        color: Color(0xFF8E6CC9),
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Patient List
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                  .collection('appointments')
                  .where('date', isEqualTo: DateTime.now().toString().substring(0, 10))
                  .orderBy('time')
                  .limit(5)
                  .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  
                  final appointments = snapshot.data!.docs;
                  
                  return Column(
                    children: appointments.map((doc) {
                      final data = doc.data() as Map<String, dynamic>;
                      return PatientCard(
                        name: data['patientName'] ?? 'Patient',
                        detail: '${data['doctorName'] ?? 'Dr'} - ${data['department'] ?? 'Département'}',
                        time: '${data['time'] ?? '--:--'} Salle ${data['room'] ?? '--'}',
                        actionText: 'Voir',
                        actionColor: const Color(0xFF8E6CC9),
                      );
                    }).toList(),
                  );
                }
              ),
            ),
            
            // Doctor Availability Section
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 24),
              child: Row(
                children: const [
                  Text(
                    'Disponibilité des médecins',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            
            // Doctor List
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                  .collection('doctors')
                  .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  
                  final doctors = snapshot.data!.docs;
                  
                  return Column(
                    children: doctors.map((doc) {
                      final data = doc.data() as Map<String, dynamic>;
                      final isAvailable = data['isAvailable'] ?? false;
                      
                      return DoctorCard(
                        name: data['name'] ?? 'Dr',
                        status: isAvailable ? 'Disponible' : 'En consultation',
                        statusColor: isAvailable ? const Color(0xFF8E6CC9) : Colors.red,
                      );
                    }).toList(),
                  );
                }
              ),
            ),
            
            const SizedBox(height: 60), // Space for bottom navigation
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey.shade200)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Icons.grid_view, color: Colors.grey.shade400),
            Icon(Icons.access_time, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }
}

class PatientCard extends StatelessWidget {
  final String name;
  final String detail;
  final String time;
  final String actionText;
  final Color actionColor;

  const PatientCard({
    Key? key,
    required this.name,
    required this.detail,
    required this.time,
    required this.actionText,
    required this.actionColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Color(0xFFF9D277),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(Icons.person_outline, color: Colors.white),
            ),
          ),
          const SizedBox(width: 12),
          
          // Patient Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  detail,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          
          // Action Button
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: actionColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              actionText,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DoctorCard extends StatelessWidget {
  final String name;
  final String status;
  final Color statusColor;

  const DoctorCard({
    Key? key,
    required this.name,
    required this.status,
    required this.statusColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 30,
            height: 30,
            decoration: const BoxDecoration(
              color: Color(0xFFF9D277),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(Icons.person_outline, color: Colors.white, size: 16),
            ),
          ),
          const SizedBox(width: 12),
          
          // Doctor Info
          Expanded(
            child: Text(
              name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          
          // Status
          Text(
            status,
            style: TextStyle(
              color: statusColor,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}