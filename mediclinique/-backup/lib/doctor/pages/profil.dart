
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:mediclic/services/auth_service.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:intl/intl.dart';

// class DoctorProfilePage extends StatefulWidget {
//   const DoctorProfilePage({Key? key}) : super(key: key);

//   @override
//   _DoctorProfilePageState createState() => _DoctorProfilePageState();
// }

// class _DoctorProfilePageState extends State<DoctorProfilePage> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
//   bool _isLoading = true;
//   bool _isEditing = false;
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
//   // Informations du médecin
//   String? _email;
//   String? _name;
//   String? _speciality;
//   String? _phone;
//   String? _address;
//   String? _bio;
//   String? _photoUrl;
//   List<String> _educations = [];
//   List<String> _experiences = [];
//   Map<String, dynamic>? _schedule;
//   double _rating = 0.0;
//   int _patientCount = 0;
//   int _experienceYears = 0;
  
//   // Contrôleurs pour l'édition
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _bioController = TextEditingController();
//   final TextEditingController _specialityController = TextEditingController();
//   final TextEditingController _addressController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _fetchProfile();
//   }
  
//   @override
//   void dispose() {
//     _nameController.dispose();
//     _phoneController.dispose();
//     _bioController.dispose();
//     _specialityController.dispose();
//     _addressController.dispose();
//     super.dispose();
//   }

//   Future<void> _fetchProfile() async {
//     setState(() {
//       _isLoading = true;
//     });
    
//     try {
//       User? user = _auth.currentUser;
//       if (user != null) {
//         // Récupérer les informations de base de l'utilisateur
//         _email = user.email;
        
//         // Récupérer les données détaillées du médecin depuis Firestore
//         DocumentSnapshot doctorDoc = await _firestore.collection('doctors').doc(user.uid).get();
        
//         if (doctorDoc.exists) {
//           Map<String, dynamic> data = doctorDoc.data() as Map<String, dynamic>;
          
//           setState(() {
//             _name = data['name'] ?? 'Dr. ' + (user.displayName ?? 'Inconnu');
//             _speciality = data['speciality'] ?? 'Non spécifié';
//             _phone = data['phone'] ?? 'Non spécifié';
//             _address = data['address'] ?? 'Non spécifié';
//             _bio = data['bio'] ?? 'Aucune information disponible';
//             _photoUrl = data['photoUrl'] ?? user.photoURL;
//             _educations = List<String>.from(data['education'] ?? []);
//             _experiences = List<String>.from(data['experience'] ?? []);
//             _schedule = data['schedule'] as Map<String, dynamic>?;
//             _rating = (data['rating'] ?? 0.0).toDouble();
//             _patientCount = data['patientCount'] ?? 0;
//             _experienceYears = data['experienceYears'] ?? 0;
            
//             // Initialiser les contrôleurs pour l'édition
//             _nameController.text = _name?.replaceFirst('Dr. ', '') ?? '';
//             _phoneController.text = _phone ?? '';
//             _bioController.text = _bio ?? '';
//             _specialityController.text = _speciality ?? '';
//             _addressController.text = _address ?? '';
//           });
//         } else {
//           // Créer un document pour le médecin s'il n'existe pas
//           String displayName = user.displayName ?? 'Nouveau Médecin';
//           await _firestore.collection('doctors').doc(user.uid).set({
//             'name': 'Dr. ' + displayName,
//             'email': user.email,
//             'photoUrl': user.photoURL,
//             'createdAt': FieldValue.serverTimestamp(),
//           });
          
//           setState(() {
//             _name = 'Dr. ' + displayName;
//           });
//         }
//       }
//     } catch (e) {
//       print('Erreur lors de la récupération du profil: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Erreur lors du chargement du profil'))
//       );
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
  
//   Future<void> _updateProfile() async {
//     if (_formKey.currentState!.validate()) {
//       setState(() {
//         _isLoading = true;
//       });
      
//       try {
//         User? user = _auth.currentUser;
//         if (user != null) {
//           // Mettre à jour le profil dans Firestore
//           await _firestore.collection('doctors').doc(user.uid).update({
//             'name': 'Dr. ' + _nameController.text.trim(),
//             'speciality': _specialityController.text.trim(),
//             'phone': _phoneController.text.trim(),
//             'address': _addressController.text.trim(),
//             'bio': _bioController.text.trim(),
//             'updatedAt': FieldValue.serverTimestamp(),
//           });
          
//           // Mettre à jour le displayName dans Firebase Auth
//           await user.updateDisplayName(_nameController.text.trim());
          
//           _fetchProfile(); // Recharger les données
//           setState(() {
//             _isEditing = false;
//           });
          
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Profil mis à jour avec succès'))
//           );
//         }
//       } catch (e) {
//         print('Erreur lors de la mise à jour du profil: $e');
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Erreur lors de la mise à jour du profil'))
//         );
//       } finally {
//         setState(() {
//           _isLoading = false;
//         });
//       }
//     }
//   }
  
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _isLoading 
//         ? const Center(child: CircularProgressIndicator())
//         : CustomScrollView(
//             slivers: [
//               SliverAppBar(
//                 expandedHeight: 200,
//                 pinned: true,
//                 flexibleSpace: FlexibleSpaceBar(
//                   title: Text(_name ?? ''),
//                   background: Container(
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: [
//                           Theme.of(context).primaryColor,
//                           Theme.of(context).primaryColor.withOpacity(0.7),
//                         ],
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                       ),
//                     ),
//                     child: _photoUrl != null 
//                       ? Image.network(
//                           _photoUrl!,
//                           fit: BoxFit.cover,
//                           color: Colors.black.withOpacity(0.3),
//                           colorBlendMode: BlendMode.darken,
//                         )
//                       : null,
//                   ),
//                 ),
//                 actions: [
//                   IconButton(
//                     icon: Icon(_isEditing ? Icons.close : Icons.edit),
//                     onPressed: () {
//                       setState(() {
//                         _isEditing = !_isEditing;
//                       });
//                     },
//                   ),
//                 ],
//               ),
//               SliverToBoxAdapter(
//                 child: _isEditing 
//                   ? _buildEditProfileForm()
//                   : _buildProfileContent(),
//               ),
//             ],
//           ),
//       floatingActionButton: _isEditing 
//         ? FloatingActionButton(
//             onPressed: _updateProfile,
//             child: const Icon(Icons.save),
//           ) 
//         : null,
//     );
//   }
  
//   Widget _buildProfileContent() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _buildProfileHeader(),
//           const SizedBox(height: 24),
//           _buildInfoSection(),
//           const Divider(height: 32),
//           _buildBioSection(),
//           const Divider(height: 32),
//           _buildStatsSection(),
//           const Divider(height: 32),
//           _buildEducationSection(),
//           const Divider(height: 32),
//           _buildExperienceSection(),
//           const Divider(height: 32),
//           _buildScheduleSection(),
//           const SizedBox(height: 24),
//           Center(
//             child: ElevatedButton.icon(
//               onPressed: () async {
//                 await _auth.signOut();
//                 if (mounted) {
//                   Navigator.pop(context);
//                 }
//               },
//               icon: const Icon(Icons.logout),
//               label: const Text("Se déconnecter"),
//               style: ElevatedButton.styleFrom(
//                 padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 0),
//         ],
//       ),
//     );
//   }
  
//   Widget _buildProfileHeader() {
//     return Row(
//       children: [
//         Container(
//           width: 100,
//           height: 100,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             border: Border.all(
//               color: Theme.of(context).primaryColor,
//               width: 3,
//             ),
//           ),
//           child: ClipOval(
//             child: _photoUrl != null 
//               ? CachedNetworkImage(
//                   imageUrl: _photoUrl!,
//                   fit: BoxFit.cover,
//                   placeholder: (context, url) => const CircularProgressIndicator(),
//                   errorWidget: (context, url, error) => const Icon(Icons.person, size: 60),
//                 )
//               : const Icon(Icons.person, size: 60),
//           ),
//         ),
//         const SizedBox(width: 20),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 _name ?? 'Docteur',
//                 style: const TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               Text(
//                 _speciality ?? 'Spécialité non spécifiée',
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: Colors.grey[600],
//                 ),
//               ),
//               const SizedBox(height: 8),
//               Row(
//                 children: [
//                   Icon(Icons.star, size: 16, color: Colors.yellow[600]),
//                   const SizedBox(width: 4),
//                   Text('$_rating/5', style: const TextStyle(fontSize: 14)),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
  
//   Widget _buildInfoSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _buildRowInfo("Email:", _email ?? 'Non spécifié'),
//         _buildRowInfo("Téléphone:", _phone ?? 'Non spécifié'),
//         _buildRowInfo("Adresse:", _address ?? 'Non spécifié'),
//       ],
//     );
//   }
  
//   Widget _buildRowInfo(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8.0),
//       child: Row(
//         children: [
//           Text(
//             label,
//             style: const TextStyle(
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(width: 8),
//           Expanded(child: Text(value)),
//         ],
//       ),
//     );
//   }
  
//   Widget _buildBioSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text("À propos de moi:", style: TextStyle(fontWeight: FontWeight.bold)),
//         const SizedBox(height: 8),
//         Text(_bio ?? 'Aucune information disponible'),
//       ],
//     );
//   }
  
//   Widget _buildStatsSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _buildRowInfo("Expérience:", '$_experienceYears années'),
//         _buildRowInfo("Nombre de patients:", _patientCount.toString()),
//       ],
//     );
//   }
  
//   Widget _buildEducationSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text("Formation:", style: TextStyle(fontWeight: FontWeight.bold)),
//         const SizedBox(height: 8),
//         ..._educations.map((education) => Padding(
//               padding: const EdgeInsets.only(bottom: 4.0),
//               child: Text('- $education'),
//             )),
//       ],
//     );
//   }
  
//   Widget _buildExperienceSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text("Expérience:", style: TextStyle(fontWeight: FontWeight.bold)),
//         const SizedBox(height: 8),
//         ..._experiences.map((experience) => Padding(
//               padding: const EdgeInsets.only(bottom: 4.0),
//               child: Text('- $experience'),
//             )),
//       ],
//     );
//   }
  
//   Widget _buildScheduleSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text("Disponibilités:", style: TextStyle(fontWeight: FontWeight.bold)),
//         const SizedBox(height: 8),
//         _schedule != null && _schedule!.isNotEmpty
//             ? Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: _schedule!.entries.map((entry) {
//                   String day = entry.key;
//                   String time = entry.value;
//                   return Padding(
//                     padding: const EdgeInsets.only(bottom: 4.0),
//                     child: Text('$day: $time'),
//                   );
//                 }).toList(),
//               )
//             : const Text("Aucune disponibilité définie"),
//       ],
//     );
//   }

//   Widget _buildEditProfileForm() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Form(
//         key: _formKey,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildTextField("Nom", _nameController, false),
//             _buildTextField("Téléphone", _phoneController, false),
//             _buildTextField("Spécialité", _specialityController, false),
//             _buildTextField("Adresse", _addressController, false),
//             _buildTextField("À propos de moi", _bioController, true),
//             const SizedBox(height: 16),
//             Center(
//               child: ElevatedButton.icon(
//                 onPressed: _updateProfile,
//                 icon: const Icon(Icons.save),
//                 label: const Text("Sauvegarder"),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
  
//   Widget _buildTextField(String label, TextEditingController controller, bool multiline) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 10.0),
//       child: TextFormField(
//         controller: controller,
//         maxLines: multiline ? 3 : 1,
//         decoration: InputDecoration(
//           labelText: label,
//           border: const OutlineInputBorder(),
//         ),
//         validator: (value) {
//           if (value == null || value.isEmpty) {
//             return 'Ce champ ne peut pas être vide';
//           }
//           return null;
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mediclic/services/auth_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

class DoctorProfilePage extends StatefulWidget {
  const DoctorProfilePage({Key? key}) : super(key: key);

  @override
  _DoctorProfilePageState createState() => _DoctorProfilePageState();
}

class _DoctorProfilePageState extends State<DoctorProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  bool _isLoading = true;
  bool _isEditing = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  // Informations du médecin
  String? _email;
  String? _name;
  String? _speciality;
  String? _phone;
  String? _address;
  String? _bio;
  String? _photoUrl;
  List<String> _educations = [];
  List<String> _experiences = [];
  Map<String, dynamic>? _schedule;
  double _rating = 0.0;
  int _patientCount = 0;
  int _experienceYears = 0;
  
  // Contrôleurs pour l'édition
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _specialityController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchProfile();
  }
  
  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _bioController.dispose();
    _specialityController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _fetchProfile() async {
    setState(() {
      _isLoading = true;
    });
    
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        // Récupérer les informations de base de l'utilisateur
        _email = user.email;
        
        // Récupérer les données détaillées du médecin depuis Firestore
        DocumentSnapshot doctorDoc = await _firestore.collection('doctors').doc(user.uid).get();
        
        if (doctorDoc.exists) {
          Map<String, dynamic> data = doctorDoc.data() as Map<String, dynamic>;
          
          setState(() {
            _name = data['name'] ?? 'Dr. ' + (user.displayName ?? 'Inconnu');
            _speciality = data['speciality'] ?? 'Non spécifié';
            _phone = data['phone'] ?? 'Non spécifié';
            _address = data['address'] ?? 'Non spécifié';
            _bio = data['bio'] ?? 'Aucune information disponible';
            _photoUrl = data['photoUrl'] ?? user.photoURL;
            _educations = List<String>.from(data['education'] ?? []);
            _experiences = List<String>.from(data['experience'] ?? []);
            _schedule = data['schedule'] as Map<String, dynamic>?;
            _rating = (data['rating'] ?? 0.0).toDouble();
            _patientCount = data['patientCount'] ?? 0;
            _experienceYears = data['experienceYears'] ?? 0;
            
            // Initialiser les contrôleurs pour l'édition
            _nameController.text = _name?.replaceFirst('Dr. ', '') ?? '';
            _phoneController.text = _phone ?? '';
            _bioController.text = _bio ?? '';
            _specialityController.text = _speciality ?? '';
            _addressController.text = _address ?? '';
          });
        } else {
          // Créer un document pour le médecin s'il n'existe pas
          String displayName = user.displayName ?? 'Nouveau Médecin';
          await _firestore.collection('doctors').doc(user.uid).set({
            'name': 'Dr. ' + displayName,
            'email': user.email,
            'photoUrl': user.photoURL,
            'createdAt': FieldValue.serverTimestamp(),
          });
          
          setState(() {
            _name = 'Dr. ' + displayName;
          });
        }
      }
    } catch (e) {
      print('Erreur lors de la récupération du profil: $e');
      _showSnackBar('Erreur lors du chargement du profil');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
  
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(12),
        backgroundColor: Theme.of(context).primaryColor,
      )
    );
  }
  
  Future<void> _updateProfile() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      
      try {
        User? user = _auth.currentUser;
        if (user != null) {
          // Mettre à jour le profil dans Firestore
          await _firestore.collection('doctors').doc(user.uid).update({
            'name': 'Dr. ' + _nameController.text.trim(),
            'speciality': _specialityController.text.trim(),
            'phone': _phoneController.text.trim(),
            'address': _addressController.text.trim(),
            'bio': _bioController.text.trim(),
            'updatedAt': FieldValue.serverTimestamp(),
          });
          
          // Mettre à jour le displayName dans Firebase Auth
          await user.updateDisplayName(_nameController.text.trim());
          
          _fetchProfile(); // Recharger les données
          setState(() {
            _isEditing = false;
          });
          
          _showSnackBar('Profil mis à jour avec succès');
        }
      } catch (e) {
        print('Erreur lors de la mise à jour du profil: $e');
        _showSnackBar('Erreur lors de la mise à jour du profil');
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading 
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                  strokeWidth: 3,
                ),
                const SizedBox(height: 16),
                Text(
                  'Chargement du profil...',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          )
        : _isEditing
            ? _buildEditProfileForm()
            : _buildProfileContent(),
    );
  }
  
  Widget _buildProfileContent() {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 260,
          pinned: true,
          stretch: true,
          backgroundColor: Theme.of(context).primaryColor,
          flexibleSpace: FlexibleSpaceBar(
            background: Stack(
              fit: StackFit.expand,
              children: [
                // Background gradient
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Theme.of(context).primaryColor,
                        Theme.of(context).primaryColor.withOpacity(0.8),
                      ],
                    ),
                  ),
                ),
                // Profile image and overlay
                _photoUrl != null
                    ? ShaderMask(
                        shaderCallback: (rect) {
                          return LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.8),
                            ],
                          ).createShader(rect);
                        },
                        blendMode: BlendMode.srcOver,
                        child: CachedNetworkImage(
                          imageUrl: _photoUrl!,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: Theme.of(context).primaryColor.withOpacity(0.5),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: Theme.of(context).primaryColor.withOpacity(0.5),
                          ),
                        ),
                      )
                    : Container(),
                // Profile info overlay
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _name ?? 'Docteur',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _speciality ?? 'Spécialité non spécifiée',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            _buildRatingStars(_rating),
                            const SizedBox(width: 8),
                            Text(
                              '$_rating/5',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                _isEditing ? Icons.close : Icons.edit,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  _isEditing = !_isEditing;
                });
              },
            ),
          ],
        ),
        SliverToBoxAdapter(
          child: _buildProfileDetails(),
        ),
      ],
    );
  }
  
  Widget _buildRatingStars(double rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < rating.floor()
              ? Icons.star
              : (index < rating ? Icons.star_half : Icons.star_border),
          color: Colors.amber,
          size: 18,
        );
      }),
    );
  }
  
  Widget _buildProfileDetails() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProfileCard(),
          const SizedBox(height: 16),
          _buildBioCard(),
          const SizedBox(height: 16),
          _buildStatsCard(),
          const SizedBox(height: 16),
          _buildEducationCard(),
          const SizedBox(height: 16),
          _buildExperienceCard(),
          const SizedBox(height: 16),
          _buildScheduleCard(),
          const SizedBox(height: 24),
          _buildLogoutButton(),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
  
  Widget _buildProfileCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("Informations de contact", Icons.contact_phone),
            const SizedBox(height: 12),
            _buildContactRow(Icons.email, "Email", _email ?? 'Non spécifié'),
            _buildContactRow(Icons.phone, "Téléphone", _phone ?? 'Non spécifié'),
            _buildContactRow(Icons.location_on, "Adresse", _address ?? 'Non spécifié'),
          ],
        ),
      ),
    );
  }
  
  Widget _buildContactRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Theme.of(context).primaryColor),
          const SizedBox(width: 12),
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
                const SizedBox(height: 2),
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
  
  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Theme.of(context).primaryColor, size: 20),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }
  
  Widget _buildBioCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("À propos de moi", Icons.person),
            const SizedBox(height: 12),
            Text(
              _bio ?? 'Aucune information disponible',
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildStatsCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("Statistiques", Icons.bar_chart),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildStatItem(
                    Icons.calendar_today,
                    '$_experienceYears',
                    'années d\'expérience',
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    Icons.people,
                    '$_patientCount',
                    'patients traités',
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    Icons.star,
                    '$_rating',
                    'évaluation',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildStatItem(IconData icon, String value, String label) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Icon(
            icon,
            color: Theme.of(context).primaryColor,
            size: 28,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildEducationCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("Formation", Icons.school),
            const SizedBox(height: 12),
            _educations.isEmpty
                ? const Text("Aucune formation spécifiée")
                : Column(
                    children: _educations.map((education) {
                      return _buildBulletPoint(education);
                    }).toList(),
                  ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 8),
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildExperienceCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("Expérience", Icons.work),
            const SizedBox(height: 12),
            _experiences.isEmpty
                ? const Text("Aucune expérience spécifiée")
                : Column(
                    children: _experiences.map((experience) {
                      return _buildBulletPoint(experience);
                    }).toList(),
                  ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildScheduleCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("Disponibilités", Icons.calendar_month),
            const SizedBox(height: 12),
            _schedule != null && _schedule!.isNotEmpty
                ? Column(
                    children: _schedule!.entries.map((entry) {
                      return _buildScheduleRow(entry.key, entry.value);
                    }).toList(),
                  )
                : const Text("Aucune disponibilité définie"),
          ],
        ),
      ),
    );
  }
  
  Widget _buildScheduleRow(String day, String time) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Container(
            width: 80,
            child: Text(
              day,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Theme.of(context).primaryColor.withOpacity(0.5),
                width: 1,
              ),
            ),
            child: Text(
              time,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildLogoutButton() {
    return Center(
      child: ElevatedButton.icon(
        onPressed: () async {
          await _auth.signOut();
          if (mounted) {
            Navigator.pop(context);
          }
        },
        icon: const Icon(Icons.logout),
        label: const Text("Se déconnecter"),
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 2,
        ),
      ),
    );
  }
  
  Widget _buildEditProfileForm() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        setState(() {
                          _isEditing = false;
                        });
                      },
                    ),
                    const Text(
                      "Modifier le profil",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.check),
                  color: Theme.of(context).primaryColor,
                  onPressed: _updateProfile,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Stack(
                          children: [
                            Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Theme.of(context).primaryColor,
                                  width: 3,
                                ),
                              ),
                              child: ClipOval(
                                child: _photoUrl != null
                                    ? CachedNetworkImage(
                                        imageUrl: _photoUrl!,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) => const CircularProgressIndicator(),
                                        errorWidget: (context, url, error) => const Icon(Icons.person, size: 60),
                                      )
                                    : const Icon(Icons.person, size: 60),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context).primaryColor,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                                child: IconButton(
                                  icon: const Icon(Icons.camera_alt, size: 20, color: Colors.white),
                                  onPressed: () {
                                    // Fonctionnalité à implémenter pour changer la photo
                                    _showSnackBar('Fonctionnalité à venir');
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      _buildEditField(
                        "Nom",
                        _nameController,
                        Icons.person,
                        false,
                      ),
                      _buildEditField(
                        "Spécialité",
                        _specialityController,
                        Icons.medical_services,
                        false,
                      ),
                      _buildEditField(
                        "Téléphone",
                        _phoneController,
                        Icons.phone,
                        false,
                        keyboardType: TextInputType.phone,
                      ),
                      _buildEditField(
                        "Adresse",
                        _addressController,
                        Icons.location_on,
                        false,
                      ),
                      _buildEditField(
                        "À propos de moi",
                        _bioController,
                        Icons.description,
                        true,
                      ),
                      const SizedBox(height: 24),
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _updateProfile,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 2,
                          ),
                          child: const Text(
                            "ENREGISTRER LES MODIFICATIONS",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildEditField(
    String label,
    TextEditingController controller,
    IconData icon,
    bool isMultiLine, {
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        maxLines: isMultiLine ? 4 : 1,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Theme.of(context).primaryColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Colors.grey[300]!,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 2,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 16,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Ce champ ne peut pas être vide';
          }
          return null;
        },
      ),
    );
  }
}