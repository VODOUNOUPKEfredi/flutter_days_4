
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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erreur lors du chargement du profil'))
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
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
          
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profil mis à jour avec succès'))
          );
        }
      } catch (e) {
        print('Erreur lors de la mise à jour du profil: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erreur lors de la mise à jour du profil'))
        );
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
        ? const Center(child: CircularProgressIndicator())
        : CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 200,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(_name ?? ''),
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).primaryColor,
                          Theme.of(context).primaryColor.withOpacity(0.7),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: _photoUrl != null 
                      ? Image.network(
                          _photoUrl!,
                          fit: BoxFit.cover,
                          color: Colors.black.withOpacity(0.3),
                          colorBlendMode: BlendMode.darken,
                        )
                      : null,
                  ),
                ),
                actions: [
                  IconButton(
                    icon: Icon(_isEditing ? Icons.close : Icons.edit),
                    onPressed: () {
                      setState(() {
                        _isEditing = !_isEditing;
                      });
                    },
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: _isEditing 
                  ? _buildEditProfileForm()
                  : _buildProfileContent(),
              ),
            ],
          ),
      floatingActionButton: _isEditing 
        ? FloatingActionButton(
            onPressed: _updateProfile,
            child: const Icon(Icons.save),
          ) 
        : null,
    );
  }
  
  Widget _buildProfileContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProfileHeader(),
          const SizedBox(height: 24),
          _buildInfoSection(),
          const Divider(height: 32),
          _buildBioSection(),
          const Divider(height: 32),
          _buildStatsSection(),
          const Divider(height: 32),
          _buildEducationSection(),
          const Divider(height: 32),
          _buildExperienceSection(),
          const Divider(height: 32),
          _buildScheduleSection(),
          const SizedBox(height: 24),
          Center(
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
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          const SizedBox(height: 0),
        ],
      ),
    );
  }
  
  Widget _buildProfileHeader() {
    return Row(
      children: [
        Container(
          width: 100,
          height: 100,
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
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _name ?? 'Docteur',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                _speciality ?? 'Spécialité non spécifiée',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.star, size: 16, color: Colors.yellow[600]),
                  const SizedBox(width: 4),
                  Text('$_rating/5', style: const TextStyle(fontSize: 14)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildRowInfo("Email:", _email ?? 'Non spécifié'),
        _buildRowInfo("Téléphone:", _phone ?? 'Non spécifié'),
        _buildRowInfo("Adresse:", _address ?? 'Non spécifié'),
      ],
    );
  }
  
  Widget _buildRowInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
  
  Widget _buildBioSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("À propos de moi:", style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text(_bio ?? 'Aucune information disponible'),
      ],
    );
  }
  
  Widget _buildStatsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildRowInfo("Expérience:", '$_experienceYears années'),
        _buildRowInfo("Nombre de patients:", _patientCount.toString()),
      ],
    );
  }
  
  Widget _buildEducationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Formation:", style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ..._educations.map((education) => Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Text('- $education'),
            )),
      ],
    );
  }
  
  Widget _buildExperienceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Expérience:", style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ..._experiences.map((experience) => Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Text('- $experience'),
            )),
      ],
    );
  }
  
  Widget _buildScheduleSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Disponibilités:", style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        _schedule != null && _schedule!.isNotEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _schedule!.entries.map((entry) {
                  String day = entry.key;
                  String time = entry.value;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Text('$day: $time'),
                  );
                }).toList(),
              )
            : const Text("Aucune disponibilité définie"),
      ],
    );
  }

  Widget _buildEditProfileForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField("Nom", _nameController, false),
            _buildTextField("Téléphone", _phoneController, false),
            _buildTextField("Spécialité", _specialityController, false),
            _buildTextField("Adresse", _addressController, false),
            _buildTextField("À propos de moi", _bioController, true),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton.icon(
                onPressed: _updateProfile,
                icon: const Icon(Icons.save),
                label: const Text("Sauvegarder"),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildTextField(String label, TextEditingController controller, bool multiline) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
        controller: controller,
        maxLines: multiline ? 3 : 1,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
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
