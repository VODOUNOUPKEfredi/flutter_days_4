
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
// import 'package:intl/intl.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'CNHU History',
//       theme: ThemeData(
//         primaryColor: const Color(0xFF8E6CC9),
//         colorScheme: ColorScheme.fromSeed(
//           seedColor: const Color(0xFF8E6CC9),
//           brightness: Brightness.light,
//         ),
//         textTheme: GoogleFonts.poppinsTextTheme(),
//         scaffoldBackgroundColor: Colors.grey[50],
//         appBarTheme: const AppBarTheme(
//           elevation: 0,
//           backgroundColor: Color(0xFF8E6CC9),
//           foregroundColor: Colors.white,
//         ),
//       ),
//       home: const HistoriquePage(),
//     );
//   }
// }

// class Consultation {
//   final String patientName;
//   final String doctorName;
//   final String specialty;
//   final DateTime dateTime;
//   final String roomNumber;
//   final String avatarColor;

//   Consultation({
//     required this.patientName,
//     required this.doctorName,
//     required this.specialty,
//     required this.dateTime,
//     required this.roomNumber,
//     required this.avatarColor,
//   });
// }

// class HistoriquePage extends StatefulWidget {
//   const HistoriquePage({Key? key}) : super(key: key);

//   @override
//   State<HistoriquePage> createState() => _HistoriquePageState();
// }

// class _HistoriquePageState extends State<HistoriquePage> with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   int _selectedNavIndex = 0;
//   bool _isSearching = false;
//   final TextEditingController _searchController = TextEditingController();
//   late List<Consultation> _consultations;
//   late List<Consultation> _filteredConsultations;
  
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
    
//     // Données dynamiques
//     _consultations = [
//       Consultation(
//         patientName: 'Elisée Elisee',
//         doctorName: 'Dr Focas',
//         specialty: 'Cardiologie',
//         dateTime: DateTime(2025, 1, 18, 18, 30),
//         roomNumber: '23',
//         avatarColor: '0xFFF9D277',
//       ),
//       Consultation(
//         patientName: 'Marie Donou',
//         doctorName: 'Dr Agbodande',
//         specialty: 'Pneumologie',
//         dateTime: DateTime(2025, 1, 15, 10, 0),
//         roomNumber: '12',
//         avatarColor: '0xFFFF8A65',
//       ),
//       Consultation(
//         patientName: 'Paul Koudogbo',
//         doctorName: 'Dr Zinsou',
//         specialty: 'Ophtalmologie',
//         dateTime: DateTime(2025, 1, 20, 14, 15),
//         roomNumber: '05',
//         avatarColor: '0xFF4FC3F7',
//       ),
//       Consultation(
//         patientName: 'Sophie Alao',
//         doctorName: 'Dr Adedemy',
//         specialty: 'Pédiatrie',
//         dateTime: DateTime(2025, 1, 25, 9, 45),
//         roomNumber: '17',
//         avatarColor: '0xFF81C784',
//       ),
//       Consultation(
//         patientName: 'Thomas Fanou',
//         doctorName: 'Dr Vodouhe',
//         specialty: 'Neurologie',
//         dateTime: DateTime(2025, 1, 22, 16, 0),
//         roomNumber: '08',
//         avatarColor: '0xFFBA68C8',
//       ),
//     ];
    
//     _filteredConsultations = List.from(_consultations);
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     _searchController.dispose();
//     super.dispose();
//   }

//   void _filterConsultations(String query) {
//     setState(() {
//       if (query.isEmpty) {
//         _filteredConsultations = List.from(_consultations);
//       } else {
//         _filteredConsultations = _consultations.where((consultation) {
//           return consultation.patientName.toLowerCase().contains(query.toLowerCase()) ||
//               consultation.doctorName.toLowerCase().contains(query.toLowerCase()) ||
//               consultation.specialty.toLowerCase().contains(query.toLowerCase());
//         }).toList();
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           // Header avec recherche dynamique
//           Container(
//             padding: const EdgeInsets.only(bottom: 8),
//             color: Theme.of(context).primaryColor,
//             child: SafeArea(
//               bottom: false,
//               child: _isSearching
//                   ? Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16),
//                       child: TextField(
//                         controller: _searchController,
//                         style: const TextStyle(color: Colors.white),
//                         decoration: InputDecoration(
//                           hintText: 'Rechercher...',
//                           hintStyle: const TextStyle(color: Colors.white70),
//                           border: InputBorder.none,
//                           prefixIcon: const Icon(Icons.search, color: Colors.white),
//                           suffixIcon: IconButton(
//                             icon: const Icon(Icons.close, color: Colors.white),
//                             onPressed: () {
//                               setState(() {
//                                 _isSearching = false;
//                                 _searchController.clear();
//                                 _filteredConsultations = List.from(_consultations);
//                               });
//                             },
//                           ),
//                         ),
//                         onChanged: _filterConsultations,
//                         autofocus: true,
//                       ),
//                     )
//                   : Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text(
//                             'CNHU',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 18,
//                             ),
//                           ),
//                           IconButton(
//                             icon: const Icon(Icons.search, color: Colors.white),
//                             onPressed: () {
//                               setState(() {
//                                 _isSearching = true;
//                               });
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//             ),
//           ),

//           // Page Title et TabBar
//           Container(
//             width: double.infinity,
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.1),
//                   spreadRadius: 1,
//                   blurRadius: 4,
//                   offset: const Offset(0, 2),
//                 ),
//               ],
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   'Historique des consultations',
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 18,
//                   ),
//                 ),
//                 const SizedBox(height: 12),
//                 TabBar(
//                   controller: _tabController,
//                   labelColor: Theme.of(context).primaryColor,
//                   unselectedLabelColor: Colors.grey,
//                   indicatorColor: Theme.of(context).primaryColor,
//                   tabs: const [
//                     Tab(text: 'Passées'),
//                     Tab(text: 'À venir'),
//                   ],
//                 ),
//               ],
//             ),
//           ),

//           // Consultation List
//           Expanded(
//             child: TabBarView(
//               controller: _tabController,
//               children: [
//                 // Consultations passées
//                 _filteredConsultations.isEmpty
//                     ? const Center(
//                         child: Text('Aucune consultation trouvée'),
//                       )
//                     : AnimationLimiter(
//                         child: ListView.builder(
//                           padding: const EdgeInsets.all(16),
//                           itemCount: _filteredConsultations.length,
//                           itemBuilder: (context, index) {
//                             return AnimationConfiguration.staggeredList(
//                               position: index,
//                               duration: const Duration(milliseconds: 375),
//                               child: SlideAnimation(
//                                 verticalOffset: 50.0,
//                                 child: FadeInAnimation(
//                                   child: Padding(
//                                     padding: const EdgeInsets.only(bottom: 12),
//                                     child: ConsultationCard(
//                                       consultation: _filteredConsultations[index],
//                                       onTap: () => _showConsultationDetails(context, _filteredConsultations[index]),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
                
//                 // Consultations à venir (simulées pour l'exemple)
//                 const Center(
//                   child: Text('Aucune consultation à venir'),
//                 ),
//               ],
//             ),
//           ),

//           // Bottom Navigation
//           Container(
//             padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.05),
//                   blurRadius: 10,
//                   offset: const Offset(0, -5),
//                 ),
//               ],
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 _buildNavItem(0, Icons.calendar_today, 'Consultations', Theme.of(context).primaryColor),
//                 _buildNavItem(1, Icons.phone, 'Contact', Colors.green),
//                 _buildNavItem(2, Icons.notifications, 'Alertes', Colors.orange),
//                 _buildNavItem(3, Icons.person, 'Profil', Colors.blue),
//               ],
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Theme.of(context).primaryColor,
//         child: const Icon(Icons.add),
//         onPressed: () {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text('Nouvelle consultation'),
//               duration: Duration(seconds: 2),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildNavItem(int index, IconData icon, String label, Color color) {
//     final isSelected = _selectedNavIndex == index;
    
//     return InkWell(
//       onTap: () {
//         setState(() {
//           _selectedNavIndex = index;
//         });
//       },
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               color: isSelected ? color.withOpacity(0.1) : Colors.transparent,
//               shape: BoxShape.circle,
//             ),
//             child: Icon(
//               icon,
//               color: isSelected ? color : Colors.grey,
//               size: 24,
//             ),
//           ),
//           const SizedBox(height: 4),
//           Text(
//             label,
//             style: TextStyle(
//               color: isSelected ? color : Colors.grey,
//               fontSize: 12,
//               fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showConsultationDetails(BuildContext context, Consultation consultation) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (context) => Container(
//         height: MediaQuery.of(context).size.height * 0.7,
//         decoration: const BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(20),
//             topRight: Radius.circular(20),
//           ),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Modal header
//             Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Theme.of(context).primaryColor,
//                 borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(20),
//                   topRight: Radius.circular(20),
//                 ),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Text(
//                     'Détails de la consultation',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                     ),
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.close, color: Colors.white),
//                     onPressed: () => Navigator.pop(context),
//                   ),
//                 ],
//               ),
//             ),
            
//             // Patient info
//             Padding(
//               padding: const EdgeInsets.all(16),
//               child: Row(
//                 children: [
//                   Container(
//                     width: 60,
//                     height: 60,
//                     decoration: BoxDecoration(
//                       color: Color(int.parse(consultation.avatarColor)),
//                       shape: BoxShape.circle,
//                     ),
//                     child: const Center(
//                       child: Icon(Icons.person, color: Colors.white, size: 32),
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         consultation.patientName,
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 18,
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Container(
//                         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                         decoration: BoxDecoration(
//                           color: Theme.of(context).primaryColor.withOpacity(0.1),
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Text(
//                           'Patient',
//                           style: TextStyle(
//                             color: Theme.of(context).primaryColor,
//                             fontSize: 12,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
            
//             const Divider(),
            
//             // Consultation details
//             Expanded(
//               child: ListView(
//                 padding: const EdgeInsets.all(16),
//                 children: [
//                   _detailItem(Icons.medical_services, 'Spécialité', consultation.specialty),
//                   _detailItem(Icons.person, 'Médecin', consultation.doctorName),
//                   _detailItem(
//                     Icons.calendar_today, 
//                     'Date', 
//                     DateFormat('dd MMMM yyyy').format(consultation.dateTime)
//                   ),
//                   _detailItem(
//                     Icons.access_time, 
//                     'Heure', 
//                     DateFormat('HH:mm').format(consultation.dateTime)
//                   ),
//                   _detailItem(Icons.room, 'Salle', consultation.roomNumber),
//                   _detailItem(Icons.notes, 'Notes', 'Aucune note disponible'),
//                 ],
//               ),
//             ),
            
//             // Action buttons
//             Padding(
//               padding: const EdgeInsets.all(16),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: ElevatedButton.icon(
//                       icon: const Icon(Icons.file_download),
//                       label: const Text('Télécharger'),
//                       style: ElevatedButton.styleFrom(
//                         padding: const EdgeInsets.symmetric(vertical: 12),
//                         backgroundColor: Colors.grey[200],
//                         foregroundColor: Colors.black87,
//                       ),
//                       onPressed: () {},
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   Expanded(
//                     child: ElevatedButton.icon(
//                       icon: const Icon(Icons.share),
//                       label: const Text('Partager'),
//                       style: ElevatedButton.styleFrom(
//                         padding: const EdgeInsets.symmetric(vertical: 12),
//                       ),
//                       onPressed: () {},
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _detailItem(IconData icon, String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 16),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             padding: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: Theme.of(context).primaryColor.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Icon(
//               icon,
//               color: Theme.of(context).primaryColor,
//               size: 20,
//             ),
//           ),
//           const SizedBox(width: 16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   label,
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: Colors.grey[600],
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   value,
//                   style: const TextStyle(
//                     fontSize: 16,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ConsultationCard extends StatelessWidget {
//   final Consultation consultation;
//   final VoidCallback onTap;

//   const ConsultationCard({
//     Key? key,
//     required this.consultation,
//     required this.onTap,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 2,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(12),
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Row(
//             children: [
//               // Avatar avec animation au survol
//               TweenAnimationBuilder(
//                 tween: Tween<double>(begin: 0, end: 1),
//                 duration: const Duration(milliseconds: 500),
//                 builder: (context, double value, child) {
//                   return Transform.scale(
//                     scale: 0.9 + (0.1 * value),
//                     child: Container(
//                       width: 50,
//                       height: 50,
//                       decoration: BoxDecoration(
//                         color: Color(int.parse(consultation.avatarColor)),
//                         shape: BoxShape.circle,
//                         boxShadow: [
//                           BoxShadow(
//                             color: Color(int.parse(consultation.avatarColor)).withOpacity(0.3),
//                             blurRadius: 8,
//                             spreadRadius: 2,
//                           ),
//                         ],
//                       ),
//                       child: const Center(
//                         child: Icon(Icons.person_outline, color: Colors.white, size: 28),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//               const SizedBox(width: 16),
              
//               // Patient Info
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       consultation.patientName,
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Row(
//                       children: [
//                         const Icon(Icons.medical_services, size: 14, color: Colors.grey),
//                         const SizedBox(width: 4),
//                         Text(
//                           '${consultation.doctorName} - ${consultation.specialty}',
//                           style: TextStyle(
//                             fontSize: 14,
//                             color: Colors.grey.shade600,
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 4),
//                     Row(
//                       children: [
//                         const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
//                         const SizedBox(width: 4),
//                         Text(
//                           '${DateFormat('dd MMM yyyy - HH:mm').format(consultation.dateTime)} - Salle ${consultation.roomNumber}',
//                           style: TextStyle(
//                             fontSize: 14,
//                             color: Colors.grey.shade600,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
              
//               // Action Button avec effet d'animation
//               Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Theme.of(context).primaryColor.withOpacity(0.3),
//                       blurRadius: 4,
//                       offset: const Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: ElevatedButton(
//                   onPressed: onTap,
//                   style: ElevatedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                   ),
//                   child: const Text(
//                     'Voir',
//                     style: TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
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
      title: 'CNHU History',
      theme: ThemeData(
        primaryColor: const Color(0xFF8E6CC9),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF8E6CC9),
          brightness: Brightness.light,
        ),
        textTheme: GoogleFonts.poppinsTextTheme(),
        scaffoldBackgroundColor: Colors.grey[50],
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Color(0xFF8E6CC9),
          foregroundColor: Colors.white,
        ),
      ),
      home: const HistoriquePage(),
    );
  }
}

class Consultation {
  final String id;
  final String patientName;
  final String doctorName;
  final String specialty;
  final DateTime dateTime;
  final String roomNumber;
  final String avatarColor;
  final String diagnostic;
  final String motif;
  final String notes;
  final String traitement;
  final String type;
  final String userId;

  Consultation({
    required this.id,
    required this.patientName,
    required this.doctorName,
    required this.specialty,
    required this.dateTime,
    required this.roomNumber,
    required this.avatarColor,
    required this.diagnostic,
    required this.motif,
    required this.notes,
    required this.traitement,
    required this.type,
    required this.userId,
  });

  factory Consultation.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    
    // Conversion de Timestamp en DateTime si nécessaire
    DateTime dateTime;
    if (data['date'] is Timestamp) {
      dateTime = (data['date'] as Timestamp).toDate();
    } else {
      // Fallback si le format est différent
      dateTime = DateTime.now();
    }

    return Consultation(
      id: doc.id,
      patientName: data['patientName'] ?? 'Patient inconnu',
      doctorName: data['medecin'] ?? 'Dr. Non spécifié',
      specialty: data['specialty'] ?? 'Non spécifiée',
      dateTime: dateTime,
      roomNumber: data['roomNumber'] ?? '00',
      avatarColor: data['avatarColor'] ?? '0xFF8E6CC9',
      diagnostic: data['diagnostic'] ?? '',
      motif: data['motif'] ?? '',
      notes: data['notes'] ?? '',
      traitement: data['traitement'] ?? '',
      type: data['type'] ?? '',
      userId: data['user_id'] ?? '',
    );
  }
}

class HistoriquePage extends StatefulWidget {
  const HistoriquePage({Key? key}) : super(key: key);

  @override
  State<HistoriquePage> createState() => _HistoriquePageState();
}

class _HistoriquePageState extends State<HistoriquePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedNavIndex = 0;
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  List<Consultation> _consultations = [];
  List<Consultation> _filteredConsultations = [];
  bool _isLoading = true;
  String _errorMessage = '';
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadConsultations();
  }

  Future<void> _loadConsultations() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      // Récupération des données depuis Firestore
      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('consultations')
          .orderBy('date', descending: true)
          .get();

      final List<Consultation> loadedConsultations = snapshot.docs
          .map((doc) => Consultation.fromFirestore(doc))
          .toList();

      setState(() {
        _consultations = loadedConsultations;
        _filteredConsultations = List.from(_consultations);
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Erreur lors du chargement des données: $e';
        _isLoading = false;
      });
      print('Erreur de chargement: $e');
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _filterConsultations(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredConsultations = List.from(_consultations);
      } else {
        _filteredConsultations = _consultations.where((consultation) {
          return consultation.patientName.toLowerCase().contains(query.toLowerCase()) ||
              consultation.doctorName.toLowerCase().contains(query.toLowerCase()) ||
              consultation.specialty.toLowerCase().contains(query.toLowerCase()) ||
              consultation.diagnostic.toLowerCase().contains(query.toLowerCase()) ||
              consultation.motif.toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header avec recherche dynamique
          Container(
            padding: const EdgeInsets.only(bottom: 8),
            color: Theme.of(context).primaryColor,
            child: SafeArea(
              bottom: false,
              child: _isSearching
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextField(
                        controller: _searchController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Rechercher...',
                          hintStyle: const TextStyle(color: Colors.white70),
                          border: InputBorder.none,
                          prefixIcon: const Icon(Icons.search, color: Colors.white),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.close, color: Colors.white),
                            onPressed: () {
                              setState(() {
                                _isSearching = false;
                                _searchController.clear();
                                _filteredConsultations = List.from(_consultations);
                              });
                            },
                          ),
                        ),
                        onChanged: _filterConsultations,
                        autofocus: true,
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'CNHU',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.search, color: Colors.white),
                            onPressed: () {
                              setState(() {
                                _isSearching = true;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
            ),
          ),

          // Page Title et TabBar
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Historique des consultations',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 12),
                TabBar(
                  controller: _tabController,
                  labelColor: Theme.of(context).primaryColor,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Theme.of(context).primaryColor,
                  tabs: const [
                    Tab(text: 'Passées'),
                    Tab(text: 'À venir'),
                  ],
                ),
              ],
            ),
          ),

          // Consultation List
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Consultations passées
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _errorMessage.isNotEmpty
                        ? Center(child: Text(_errorMessage, style: const TextStyle(color: Colors.red)))
                        : _filteredConsultations.isEmpty
                            ? const Center(child: Text('Aucune consultation trouvée'))
                            : RefreshIndicator(
                                onRefresh: _loadConsultations,
                                child: AnimationLimiter(
                                  child: ListView.builder(
                                    padding: const EdgeInsets.all(16),
                                    itemCount: _filteredConsultations.length,
                                    itemBuilder: (context, index) {
                                      return AnimationConfiguration.staggeredList(
                                        position: index,
                                        duration: const Duration(milliseconds: 375),
                                        child: SlideAnimation(
                                          verticalOffset: 50.0,
                                          child: FadeInAnimation(
                                            child: Padding(
                                              padding: const EdgeInsets.only(bottom: 12),
                                              child: ConsultationCard(
                                                consultation: _filteredConsultations[index],
                                                onTap: () => _showConsultationDetails(context, _filteredConsultations[index]),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                
                // Consultations à venir (à implémenter avec une requête spécifique)
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : const Center(child: Text('Aucune consultation à venir')),
              ],
            ),
          ),

          // Bottom Navigation
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(0, Icons.calendar_today, 'Consultations', Theme.of(context).primaryColor),
                _buildNavItem(1, Icons.phone, 'Contact', Colors.green),
                _buildNavItem(2, Icons.notifications, 'Alertes', Colors.orange),
                _buildNavItem(3, Icons.person, 'Profil', Colors.blue),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add),
        onPressed: () {
          // Navigation vers l'écran d'ajout de consultation
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Nouvelle consultation'),
              duration: Duration(seconds: 2),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label, Color color) {
    final isSelected = _selectedNavIndex == index;
    
    return InkWell(
      onTap: () {
        setState(() {
          _selectedNavIndex = index;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isSelected ? color.withOpacity(0.1) : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isSelected ? color : Colors.grey,
              size: 24,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? color : Colors.grey,
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  void _showConsultationDetails(BuildContext context, Consultation consultation) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Modal header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Détails de la consultation',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            
            // Patient info
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Color(int.parse(consultation.avatarColor)),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(Icons.person, color: Colors.white, size: 32),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        consultation.patientName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'Patient',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            const Divider(),
            
            // Consultation details
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _detailItem(Icons.medical_services, 'Spécialité', consultation.specialty),
                  _detailItem(Icons.person, 'Médecin', consultation.doctorName),
                  _detailItem(
                    Icons.calendar_today, 
                    'Date', 
                    DateFormat('dd MMMM yyyy').format(consultation.dateTime)
                  ),
                  _detailItem(
                    Icons.access_time, 
                    'Heure', 
                    DateFormat('HH:mm').format(consultation.dateTime)
                  ),
                  _detailItem(Icons.room, 'Salle', consultation.roomNumber),
                  _detailItem(Icons.description, 'Motif', 
                    consultation.motif.isNotEmpty ? consultation.motif : 'Non spécifié'),
                  _detailItem(Icons.medical_information, 'Diagnostic', 
                    consultation.diagnostic.isNotEmpty ? consultation.diagnostic : 'Non spécifié'),
                  _detailItem(Icons.medication, 'Traitement', 
                    consultation.traitement.isNotEmpty ? consultation.traitement : 'Non spécifié'),
                  _detailItem(Icons.notes, 'Notes', 
                    consultation.notes.isNotEmpty ? consultation.notes : 'Aucune note disponible'),
                ],
              ),
            ),
            
            // Action buttons
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.file_download),
                      label: const Text('Télécharger'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        backgroundColor: Colors.grey[200],
                        foregroundColor: Colors.black87,
                      ),
                      onPressed: () {
                        // Logique pour télécharger
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.share),
                      label: const Text('Partager'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () {
                        // Logique pour partager
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _detailItem(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: Theme.of(context).primaryColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ConsultationCard extends StatelessWidget {
  final Consultation consultation;
  final VoidCallback onTap;

  const ConsultationCard({
    Key? key,
    required this.consultation,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Avatar avec animation au survol
              TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: 1),
                duration: const Duration(milliseconds: 500),
                builder: (context, double value, child) {
                  return Transform.scale(
                    scale: 0.9 + (0.1 * value),
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(int.parse(consultation.avatarColor)),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Color(int.parse(consultation.avatarColor)).withOpacity(0.3),
                            blurRadius: 8,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Icon(Icons.person_outline, color: Colors.white, size: 28),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(width: 16),
              
              // Patient Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      consultation.patientName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.medical_services, size: 14, color: Colors.grey),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            '${consultation.doctorName} - ${consultation.specialty}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            '${DateFormat('dd MMM yyyy - HH:mm').format(consultation.dateTime)} - Salle ${consultation.roomNumber}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Action Button avec effet d'animation
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).primaryColor.withOpacity(0.3),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: onTap,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Voir',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}