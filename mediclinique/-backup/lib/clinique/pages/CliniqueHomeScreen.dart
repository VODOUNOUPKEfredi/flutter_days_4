import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mediclic/pages/userDoctor.dart';
import 'package:mediclic/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Cliniquehomescreen extends StatefulWidget {
  const Cliniquehomescreen({Key? key}) : super(key: key);

  @override
  _CliniquehomescreenState createState() => _CliniquehomescreenState();
}

class _CliniquehomescreenState extends State<Cliniquehomescreen> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  // Contrôleurs pour les champs du formulaire
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  
  // Variables pour les disponibilités
  DateTime _selectedDate = DateTime.now();
  String _startTime = '08:00';
  String _endTime = '17:00';
  List<DoctorAvailability> _availabilities = [];
  
  bool _isLoading = false;
  String _errorMessage = '';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _fullNameController.dispose();
    super.dispose();
  }

  // Fonction pour sélectionner une date
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // Fonction pour sélectionner l'heure de début
  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: int.parse(_startTime.split(':')[0]),
        minute: int.parse(_startTime.split(':')[1]),
      ),
    );
    if (picked != null) {
      setState(() {
        _startTime = '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
      });
    }
  }

  // Fonction pour sélectionner l'heure de fin
  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: int.parse(_endTime.split(':')[0]),
        minute: int.parse(_endTime.split(':')[1]),
      ),
    );
    if (picked != null) {
      setState(() {
        _endTime = '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
      });
    }
  }

  // Fonction pour ajouter une disponibilité
  void _addAvailability() {
    // Vérifier si les horaires sont valides
    final startTimeParts = _startTime.split(':');
    final endTimeParts = _endTime.split(':');
    
    final startDateTime = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      int.parse(startTimeParts[0]),
      int.parse(startTimeParts[1]),
    );
    
    final endDateTime = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      int.parse(endTimeParts[0]),
      int.parse(endTimeParts[1]),
    );
    
    if (endDateTime.isBefore(startDateTime)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("L'heure de fin doit être après l'heure de début")),
      );
      return;
    }
    
    // Créer une nouvelle disponibilité (avec un ID temporaire qui sera remplacé lors de l'enregistrement)
    final availability = DoctorAvailability(
      doctorId: 'temp_id',
      date: _selectedDate,
      startTime: _startTime,
      endTime: _endTime,
    );
    
    setState(() {
      _availabilities.add(availability);
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Disponibilité ajoutée: ${DateFormat('dd/MM/yyyy').format(_selectedDate)} de $_startTime à $_endTime')),
    );
  }

  // Fonction pour supprimer une disponibilité
  void _removeAvailability(int index) {
    setState(() {
      _availabilities.removeAt(index);
    });
  }

  // Fonction pour enregistrer le médecin et ses disponibilités
  Future<void> _registerDoctor() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _errorMessage = '';
      });

      // Vérification des mots de passe
      if (_passwordController.text != _confirmPasswordController.text) {
        setState(() {
          _errorMessage = 'Les mots de passe ne correspondent pas';
          _isLoading = false;
        });
        return;
      }

      try {
        // Enregistrer le médecin avec AuthService
        String? error = await _authService.registerMedecin(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          fullName: _fullNameController.text.trim(),
           specialite: '',
        );

        if (error != null) {
          setState(() {
            _errorMessage = error;
            _isLoading = false;
          });
          return;
        }

        // Récupérer l'ID du médecin nouvellement créé
        String? doctorId = _authService.getCurrentUserId();
        if (doctorId == null) {
          setState(() {
            _errorMessage = "Impossible de récupérer l'ID du médecin";
            _isLoading = false;
          });
          return;
        }

        // Enregistrer les disponibilités du médecin
        for (var availability in _availabilities) {
          // Mettre à jour l'ID du médecin
          final availabilityData = availability.toMap();
          availabilityData['doctor_id'] = doctorId;
          
          // Enregistrer dans Firestore
          await _firestore.collection('doctor_availabilities').add(availabilityData);
        }

        // Inscription réussie, revenir à l'écran précédent
        if (mounted) {
          Navigator.pop(context, true);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Médecin inscrit avec succès')),
          );
        }
      } catch (e) {
        setState(() {
          _errorMessage = 'Erreur lors de l\'inscription: ${e.toString()}';
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inscription du Médecin'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Informations du médecin
              const Text(
                'Informations du médecin',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _fullNameController,
                decoration: const InputDecoration(
                  labelText: 'Nom complet',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer le nom complet';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un email';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                    return 'Veuillez entrer un email valide';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Mot de passe',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un mot de passe';
                  }
                  if (value.length < 6) {
                    return 'Le mot de passe doit contenir au moins 6 caractères';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _confirmPasswordController,
                decoration: const InputDecoration(
                  labelText: 'Confirmer le mot de passe',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez confirmer le mot de passe';
                  }
                  if (value != _passwordController.text) {
                    return 'Les mots de passe ne correspondent pas';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              
              // Section des disponibilités
              const Text(
                'Ajouter des disponibilités',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              
              // Sélection de la date
              ListTile(
                title: const Text('Date'),
                subtitle: Text(DateFormat('dd/MM/yyyy').format(_selectedDate)),
                trailing: const Icon(Icons.calendar_today),
                onTap: () => _selectDate(context),
              ),
              
              // Sélection de l'heure de début
              ListTile(
                title: const Text('Heure de début'),
                subtitle: Text(_startTime),
                trailing: const Icon(Icons.access_time),
                onTap: () => _selectStartTime(context),
              ),
              
              // Sélection de l'heure de fin
              ListTile(
                title: const Text('Heure de fin'),
                subtitle: Text(_endTime),
                trailing: const Icon(Icons.access_time),
                onTap: () => _selectEndTime(context),
              ),
              
              // Bouton pour ajouter une disponibilité
              ElevatedButton.icon(
                onPressed: _addAvailability,
                icon: const Icon(Icons.add),
                label: const Text('Ajouter cette disponibilité'),
              ),
              const SizedBox(height: 16),
              
              // Liste des disponibilités ajoutées
              if (_availabilities.isNotEmpty) ...[
                const Text(
                  'Disponibilités programmées:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _availabilities.length,
                  itemBuilder: (context, index) {
                    final availability = _availabilities[index];
                    return Card(
                      child: ListTile(
                        title: Text(DateFormat('dd/MM/yyyy').format(availability.date)),
                        subtitle: Text('${availability.startTime} - ${availability.endTime}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _removeAvailability(index),
                        ),
                      ),
                    );
                  },
                ),
              ],
              
              const SizedBox(height: 32),
              
              // Affichage des erreurs
              if (_errorMessage.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.red[100],
                  child: Text(
                    _errorMessage,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              
              // Bouton d'inscription
              ElevatedButton(
                onPressed: _isLoading ? null : _registerDoctor,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Inscrire le médecin', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}