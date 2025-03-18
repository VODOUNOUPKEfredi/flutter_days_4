import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Consultations Médicales',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const ConsultationsPage(),
    );
  }
}

class ConsultationsPage extends StatefulWidget {
  const ConsultationsPage({Key? key}) : super(key: key);

  @override
  _ConsultationsPageState createState() => _ConsultationsPageState();
}

class _ConsultationsPageState extends State<ConsultationsPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<DocumentSnapshot> _consultations = [];
  bool _isLoading = true;

  // Filtres de recherche
  String? _selectedType;
  String? _selectedMedecin;
  DateTime? _startDate;
  DateTime? _endDate;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _fetchConsultations();
  }

  Future<void> _fetchConsultations() async {
    setState(() {
      _isLoading = true;
    });

    try {
      Query query = _firestore.collection('consultations');

      // Application des filtres
      if (_selectedType != null && _selectedType!.isNotEmpty) {
        query = query.where('type', isEqualTo: _selectedType);
      }
      if (_selectedMedecin != null && _selectedMedecin!.isNotEmpty) {
        query = query.where('medecin', isEqualTo: _selectedMedecin);
      }
      if (_startDate != null) {
        query = query.where('date', isGreaterThanOrEqualTo: _startDate);
      }
      if (_endDate != null) {
        query = query.where('date', isLessThanOrEqualTo: _endDate);
      }

      QuerySnapshot snapshot = await query.get();
      
      // Filtrage supplémentaire pour la recherche textuelle
      List<DocumentSnapshot> filteredDocs = snapshot.docs;
      if (_searchQuery.isNotEmpty) {
        filteredDocs = filteredDocs.where((doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          String motif = data['motif']?.toString().toLowerCase() ?? '';
          String diagnostic = data['diagnostic']?.toString().toLowerCase() ?? '';
          String notes = data['notes']?.toString().toLowerCase() ?? '';
          String query = _searchQuery.toLowerCase();
          
          return motif.contains(query) || 
                 diagnostic.contains(query) || 
                 notes.contains(query);
        }).toList();
      }

      setState(() {
        _consultations = filteredDocs;
        _isLoading = false;
      });
    } catch (e) {
      print('Erreur lors de la récupération des consultations: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Filtrer les consultations'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(labelText: 'Type'),
                      value: _selectedType,
                      items: ['Consultation', 'Suivi', 'Urgence', 'Autre']
                          .map((type) => DropdownMenuItem(
                                value: type,
                                child: Text(type),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedType = value;
                        });
                      },
                    ),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(labelText: 'Médecin'),
                      value: _selectedMedecin,
                      items: ['Dr. Martin', 'Dr. Dupont', 'Dr. Dubois', 'Dr. Bernard']
                          .map((medecin) => DropdownMenuItem(
                                value: medecin,
                                child: Text(medecin),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedMedecin = value;
                        });
                      },
                    ),
                    ListTile(
                      title: const Text('Date de début'),
                      subtitle: Text(_startDate == null
                          ? 'Non définie'
                          : DateFormat('dd/MM/yyyy').format(_startDate!)),
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: _startDate ?? DateTime.now(),
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2030),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            _startDate = pickedDate;
                          });
                        }
                      },
                    ),
                    ListTile(
                      title: const Text('Date de fin'),
                      subtitle: Text(_endDate == null
                          ? 'Non définie'
                          : DateFormat('dd/MM/yyyy').format(_endDate!)),
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: _endDate ?? DateTime.now(),
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2030),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            _endDate = pickedDate;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      _selectedType = null;
                      _selectedMedecin = null;
                      _startDate = null;
                      _endDate = null;
                    });
                  },
                  child: const Text('Réinitialiser'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Annuler'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _fetchConsultations();
                  },
                  child: const Text('Appliquer'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showConsultationDetails(DocumentSnapshot consultation) {
    Map<String, dynamic> data = consultation.data() as Map<String, dynamic>;
    
    // Vérification de la présence de la date et utilisation sécurisée
    Timestamp? timestamp = data['date'] as Timestamp?;
    String dateStr = timestamp != null
        ? DateFormat('dd/MM/yyyy à HH:mm').format(timestamp.toDate())
        : 'Date non disponible';
    
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Consultation du $dateStr'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDetailRow('Type', data['type'] ?? ''),
                _buildDetailRow('Médecin', data['medecin'] ?? ''),
                _buildDetailRow('Patient', data['user_id'] ?? ''),
                _buildDetailRow('Motif', data['motif'] ?? ''),
                _buildDetailRow('Diagnostic', data['diagnostic'] ?? ''),
                _buildDetailRow('Traitement', data['traitement'] ?? ''),
                _buildDetailRow('Notes', data['notes'] ?? ''),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Fermer'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _navigateToEditConsultation(consultation);
              },
              child: const Text('Modifier'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(value.isNotEmpty ? value : 'Non renseigné'),
          const Divider(),
        ],
      ),
    );
  }

  void _navigateToEditConsultation(DocumentSnapshot consultation) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ConsultationFormPage(
          consultation: consultation,
          onSave: () {
            _fetchConsultations();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consultations Médicales'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Rechercher...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              onSubmitted: (value) {
                _fetchConsultations();
              },
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _consultations.isEmpty
                    ? const Center(child: Text('Aucune consultation trouvée'))
                    : ListView.builder(
                        itemCount: _consultations.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot consultation = _consultations[index];
                          Map<String, dynamic> data = consultation.data() as Map<String, dynamic>;
                          
                          // Gestion sécurisée du Timestamp
                          Timestamp? timestamp = data['date'] as Timestamp?;
                          String dateStr = timestamp != null
                              ? DateFormat('dd/MM/yyyy à HH:mm').format(timestamp.toDate())
                              : 'Date non disponible';
                          
                          return Card(
                            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                            child: ListTile(
                              title: Text(
                                'Consultation du $dateStr',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Type: ${data['type'] ?? 'Non renseigné'}'),
                                  Text('Médecin: ${data['medecin'] ?? 'Non renseigné'}'),
                                  Text('Motif: ${data['motif'] ?? 'Non renseigné'}'),
                                ],
                              ),
                              trailing: const Icon(Icons.chevron_right),
                              onTap: () => _showConsultationDetails(consultation),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ConsultationFormPage(
                onSave: () {
                  _fetchConsultations();
                },
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ConsultationFormPage extends StatefulWidget {
  final DocumentSnapshot? consultation;
  final Function onSave;

  const ConsultationFormPage({
    Key? key,
    this.consultation,
    required this.onSave,
  }) : super(key: key);

  @override
  _ConsultationFormPageState createState() => _ConsultationFormPageState();
}

class _ConsultationFormPageState extends State<ConsultationFormPage> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _isLoading = false;

  late TextEditingController _motifController;
  late TextEditingController _diagnosticController;
  late TextEditingController _traitementController;
  late TextEditingController _notesController;
  late TextEditingController _userIdController;
  String? _selectedType;
  String? _selectedMedecin;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _motifController = TextEditingController();
    _diagnosticController = TextEditingController();
    _traitementController = TextEditingController();
    _notesController = TextEditingController();
    _userIdController = TextEditingController();

    if (widget.consultation != null) {
      Map<String, dynamic> data = widget.consultation!.data() as Map<String, dynamic>;
      _motifController.text = data['motif'] ?? '';
      _diagnosticController.text = data['diagnostic'] ?? '';
      _traitementController.text = data['traitement'] ?? '';
      _notesController.text = data['notes'] ?? '';
      _userIdController.text = data['user_id'] ?? '';
      _selectedType = data['type'];
      _selectedMedecin = data['medecin'];
      
      // Gestion sécurisée du Timestamp
      Timestamp? timestamp = data['date'] as Timestamp?;
      if (timestamp != null) {
        _selectedDate = timestamp.toDate();
      }
    }
  }

  @override
  void dispose() {
    _motifController.dispose();
    _diagnosticController.dispose();
    _traitementController.dispose();
    _notesController.dispose();
    _userIdController.dispose();
    super.dispose();
  }

  Future<void> _saveConsultation() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        Map<String, dynamic> consultationData = {
          'motif': _motifController.text,
          'diagnostic': _diagnosticController.text,
          'traitement': _traitementController.text,
          'notes': _notesController.text,
          'user_id': _userIdController.text,
          'type': _selectedType,
          'medecin': _selectedMedecin,
          'date': Timestamp.fromDate(_selectedDate),
        };

        if (widget.consultation != null) {
          // Mise à jour d'une consultation existante
          await _firestore
              .collection('consultations')
              .doc(widget.consultation!.id)
              .update(consultationData);
        } else {
          // Création d'une nouvelle consultation
          await _firestore.collection('consultations').add(consultationData);
        }

        widget.onSave();
        Navigator.of(context).pop();
      } catch (e) {
        print('Erreur lors de l\'enregistrement de la consultation: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur: $e')),
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
      appBar: AppBar(
        title: Text(widget.consultation != null
            ? 'Modifier la consultation'
            : 'Nouvelle consultation'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: const Text('Date et heure'),
                      subtitle: Text(
                          DateFormat('dd/MM/yyyy à HH:mm').format(_selectedDate)),
                      trailing: const Icon(Icons.calendar_today),
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: _selectedDate,
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2030),
                        );
                        if (pickedDate != null) {
                          TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.fromDateTime(_selectedDate),
                          );
                          if (pickedTime != null) {
                            setState(() {
                              _selectedDate = DateTime(
                                pickedDate.year,
                                pickedDate.month,
                                pickedDate.day,
                                pickedTime.hour,
                                pickedTime.minute,
                              );
                            });
                          }
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Type',
                        border: OutlineInputBorder(),
                      ),
                      value: _selectedType,
                      items: ['Consultation', 'Suivi', 'Urgence', 'Autre']
                          .map((type) => DropdownMenuItem(
                                value: type,
                                child: Text(type),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedType = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez sélectionner un type';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Médecin',
                        border: OutlineInputBorder(),
                      ),
                      value: _selectedMedecin,
                      items: ['Dr. Martin', 'Dr. Dupont', 'Dr. Dubois', 'Dr. Bernard']
                          .map((medecin) => DropdownMenuItem(
                                value: medecin,
                                child: Text(medecin),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedMedecin = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez sélectionner un médecin';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _userIdController,
                      decoration: const InputDecoration(
                        labelText: 'ID Patient',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer l\'ID du patient';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _motifController,
                      decoration: const InputDecoration(
                        labelText: 'Motif',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 2,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer le motif de la consultation';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _diagnosticController,
                      decoration: const InputDecoration(
                        labelText: 'Diagnostic',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _traitementController,
                      decoration: const InputDecoration(
                        labelText: 'Traitement',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _notesController,
                      decoration: const InputDecoration(
                        labelText: 'Notes',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 4,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _saveConsultation,
                        child: Text(
                          widget.consultation != null ? 'Mettre à jour' : 'Enregistrer',
                          style: const TextStyle(fontSize: 16),
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