// import 'package:flutter/material.dart';
// import 'package:mediclic/services/auth_service.dart';

// class MedicalForm extends StatefulWidget {
//   @override
//   _MedicalFormState createState() => _MedicalFormState();
// }

// class _MedicalFormState extends State<MedicalForm> {
//   int _currentStep = 0;

//   // Champs du formulaire
//   String _fullName = '';
//   String _dateOfBirth = '';
//   String _socialSecurityNumber = '';
//   String _address = '';
//   String _phone = '';
//   String _emergencyContact = '';
//   List<String> _medicalHistory = [];
//   List<String> _familyHistory = [];
//   List<String> _allergies = [];
//   List<String> _currentTreatments = [];
//   List<String> _vaccinations = [];
//   List<String> _recentConsultations = [];
//   List<String> _exams = [];

//   final MedicalRecordService _medicalRecordService = MedicalRecordService();

//   // Fonction pour sauvegarder le dossier médical
//   void _saveForm() async {
//     try {
//       await _medicalRecordService.saveMedicalRecord(
//         fullName: _fullName,
//         dateOfBirth: _dateOfBirth,
//         socialSecurityNumber: _socialSecurityNumber,
//         address: _address,
//         phone: _phone,
//         emergencyContact: _emergencyContact,
//         medicalHistory: _medicalHistory,
//         familyHistory: _familyHistory,
//         allergies: _allergies,
//         currentTreatments: _currentTreatments,
//         vaccinations: _vaccinations,
//         recentConsultations: _recentConsultations,
//         exams: _exams,
//       );
      
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Dossier médical enregistré avec succès !")),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Erreur lors de l'enregistrement: $e")),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Formulaire Dossier Médical'),
//       ),
//       body: Stepper(
//         currentStep: _currentStep,
//         onStepContinue: () {
//           if (_currentStep < 5) {
//             setState(() {
//               _currentStep++;
//             });
//           } else {
//             // Sauvegarde du dossier médical à la dernière étape
//             _saveForm();
//           }
//         },
//         onStepCancel: () {
//           if (_currentStep > 0) {
//             setState(() {
//               _currentStep--;
//             });
//           }
//         },
//         steps: [
//           Step(
//             title: Text('Informations Patient'),
//             content: Column(
//               children: [
//                 TextField(
//                   onChanged: (value) {
//                     _fullName = value;
//                   },
//                   decoration: InputDecoration(labelText: 'Nom complet'),
//                 ),
//                 TextField(
//                   onChanged: (value) {
//                     _dateOfBirth = value;
//                   },
//                   decoration: InputDecoration(labelText: 'Date de naissance'),
//                 ),
//                 TextField(
//                   onChanged: (value) {
//                     _socialSecurityNumber = value;
//                   },
//                   decoration: InputDecoration(labelText: 'Numéro de sécurité sociale'),
//                 ),
//                 // Ajouter d'autres champs ici
//               ],
//             ),
//           ),
//           Step(
//             title: Text('Antécédents Médicaux'),
//             content: Column(
//               children: [
//                 TextField(
//                   onChanged: (value) {
//                     _medicalHistory.add(value);
//                   },
//                   decoration: InputDecoration(labelText: 'Antécédents médicaux'),
//                 ),
//                 // Ajouter d'autres champs ici pour les antécédents médicaux
//               ],
//             ),
//           ),
//           // Ajouter d'autres étapes selon les besoins du formulaire...
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:mediclic/services/auth_service.dart';
import 'package:intl/intl.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:mediclic/services/medicalrecordService.dart';

class DossierMedicalForm extends StatefulWidget {
  @override
  _DossierMedicalFormState createState() => _DossierMedicalFormState();
}

class _DossierMedicalFormState extends State<DossierMedicalForm> {
  int _currentStep = 0;
  final _formKey = GlobalKey<FormState>();
  
  // Contrôleurs pour les TextFields
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _socialSecurityController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emergencyContactController = TextEditingController();
  
  // Champs du formulaire
  String _fullName = '';
  String _dateOfBirth = '';
  String _socialSecurityNumber = '';
  String _address = '';
  String _phone = '';
  String _emergencyContact = '';
  List<String> _medicalHistory = [];
  List<String> _familyHistory = [];
  List<String> _allergies = [];
  List<String> _currentTreatments = [];
  List<String> _vaccinations = [];
  List<String> _recentConsultations = [];
  List<String> _exams = [];
  
  // Pour les listes dynamiques
  final TextEditingController _newItemController = TextEditingController();
  
  // Couleurs du thème
  final Color _primaryColor = Color(0xFF2196F3);
  final Color _accentColor = Color(0xFF03A9F4);
  final Color _backgroundColor = Color(0xFFF5F5F7);
  
  final MedicalRecordService _medicalRecordService = MedicalRecordService();

  @override
  void dispose() {
    _fullNameController.dispose();
    _dateOfBirthController.dispose();
    _socialSecurityController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _emergencyContactController.dispose();
    _newItemController.dispose();
    super.dispose();
  }

  // Fonction pour sélectionner une date
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: _primaryColor,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    
    if (picked != null) {
      setState(() {
        _dateOfBirthController.text = DateFormat('dd/MM/yyyy').format(picked);
        _dateOfBirth = _dateOfBirthController.text;
      });
    }
  }

  // Fonction pour ajouter des items à une liste
  void _addItemToList(List<String> list, String item) {
    if (item.trim().isNotEmpty) {
      setState(() {
        list.add(item.trim());
        _newItemController.clear();
      });
    }
  }

  // Fonction pour supprimer un item d'une liste
  void _removeItemFromList(List<String> list, int index) {
    setState(() {
      list.removeAt(index);
    });
  }

  // Afficher les items d'une liste
  Widget _buildListItems(List<String> items, String emptyMessage, Function(int) onDelete) {
    if (items.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          emptyMessage,
          style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
        ),
      );
    }
    
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 1,
          margin: EdgeInsets.symmetric(vertical: 4),
          child: ListTile(
            title: Text(items[index]),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () => onDelete(index),
            ),
          ),
        );
      },
    );
  }

  // Widget pour ajouter un nouvel élément à une liste
  Widget _buildAddItemField(String placeholder, Function(String) onAdd) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _newItemController,
            decoration: InputDecoration(
              labelText: placeholder,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ),
        SizedBox(width: 10),
        ElevatedButton(
          onPressed: () => onAdd(_newItemController.text),
          child: Icon(Icons.add),
          style: ElevatedButton.styleFrom(
            backgroundColor: _accentColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.all(16),
          ),
        ),
      ],
    );
  }

  // Fonction pour construire un champ de texte stylisé
  Widget _buildTextField({
    required String label, 
    required TextEditingController controller,
    required Function(String) onChanged,
    bool isPhone = false,
    IconData? prefixIcon,
    bool isMultiline = false,
    bool isReadOnly = false,
    Function()? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        readOnly: isReadOnly,
        onTap: onTap,
        keyboardType: isPhone ? TextInputType.phone : (isMultiline ? TextInputType.multiline : TextInputType.text),
        maxLines: isMultiline ? 3 : 1,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: _primaryColor) : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: _primaryColor, width: 2),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Ce champ est requis';
          }
          return null;
        },
      ),
    );
  }

  // Fonction pour sauvegarder le dossier médical
  void _saveForm() async {
    try {
      if (_formKey.currentState!.validate()) {
        // Afficher un indicateur de chargement
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(_primaryColor),
              ),
            );
          },
        );
        
        await _medicalRecordService.saveMedicalRecord(
          fullName: _fullName,
          dateOfBirth: _dateOfBirth,
          socialSecurityNumber: _socialSecurityNumber,
          address: _address,
          phone: _phone,
          emergencyContact: _emergencyContact,
          medicalHistory: _medicalHistory,
          familyHistory: _familyHistory,
          allergies: _allergies,
          currentTreatments: _currentTreatments,
          vaccinations: _vaccinations,
          recentConsultations: _recentConsultations,
          exams: _exams,
        );
        
        // Fermer la boîte de dialogue de chargement
        Navigator.of(context).pop();
        
        // Afficher un message de succès
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Succès'),
              content: Text('Dossier médical enregistré avec succès !'),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              actions: [
                TextButton(
                  child: Text('OK', style: TextStyle(color: _primaryColor)),
                  onPressed: () {
                    Navigator.of(context).pop();
                    // Optionnel: retourner à l'écran précédent
                    // Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      // Fermer la boîte de dialogue de chargement
      Navigator.of(context).pop();
      
      // Afficher un message d'erreur
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Erreur lors de l'enregistrement: $e"),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dossier Médical',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: _primaryColor,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              // Ajouter une fonction d'aide ici
            },
          ),
        ],
      ),
      backgroundColor: _backgroundColor,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Theme(
            data: ThemeData(
              colorScheme: ColorScheme.light(
                primary: _primaryColor,
                secondary: _accentColor,
              ),
            ),
            child: Stepper(
              type: StepperType.vertical,
              physics: ClampingScrollPhysics(),
              currentStep: _currentStep,
              onStepContinue: () {
                if (_currentStep < 5) {
                  setState(() {
                    _currentStep++;
                  });
                } else {
                  _saveForm();
                }
              },
              onStepCancel: () {
                if (_currentStep > 0) {
                  setState(() {
                    _currentStep--;
                  });
                }
              },
              controlsBuilder: (context, details) {
                return Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: details.onStepContinue,
                          child: Text(
                            _currentStep == 5 ? 'ENREGISTRER' : 'CONTINUER',
                            style: TextStyle(fontSize: 16),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _primaryColor,
                            padding: EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      if (_currentStep > 0)
                        Expanded(
                          child: OutlinedButton(
                            onPressed: details.onStepCancel,
                            child: Text('RETOUR', style: TextStyle(fontSize: 16, color: _primaryColor)),
                            style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              side: BorderSide(color: _primaryColor),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              },
              steps: [
                Step(
                  title: Text('Informations Personnelles', style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('Saisissez vos informations de base'),
                  isActive: _currentStep >= 0,
                  state: _currentStep > 0 ? StepState.complete : StepState.indexed,
                  content: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        _buildTextField(
                          label: 'Nom complet',
                          controller: _fullNameController,
                          onChanged: (value) => _fullName = value,
                          prefixIcon: Icons.person,
                        ),
                        _buildTextField(
                          label: 'Date de naissance',
                          controller: _dateOfBirthController,
                          onChanged: (value) => _dateOfBirth = value,
                          isReadOnly: true,
                          onTap: () => _selectDate(context),
                          prefixIcon: Icons.calendar_today,
                        ),
                        _buildTextField(
                          label: 'Numéro de sécurité sociale',
                          controller: _socialSecurityController,
                          onChanged: (value) => _socialSecurityNumber = value,
                          prefixIcon: Icons.badge,
                        ),
                        _buildTextField(
                          label: 'Adresse',
                          controller: _addressController,
                          onChanged: (value) => _address = value,
                          isMultiline: true,
                          prefixIcon: Icons.home,
                        ),
                        _buildTextField(
                          label: 'Téléphone',
                          controller: _phoneController,
                          onChanged: (value) => _phone = value,
                          isPhone: true,
                          prefixIcon: Icons.phone,
                        ),
                        _buildTextField(
                          label: 'Contact d\'urgence',
                          controller: _emergencyContactController,
                          onChanged: (value) => _emergencyContact = value,
                          prefixIcon: Icons.emergency,
                        ),
                      ],
                    ),
                  ),
                ),
                Step(
                  title: Text('Antécédents Médicaux', style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('Vos antécédents médicaux personnels'),
                  isActive: _currentStep >= 1,
                  state: _currentStep > 1 ? StepState.complete : StepState.indexed,
                  content: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ajouter un antécédent médical',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        _buildAddItemField(
                          'Antécédent médical',
                          (value) => _addItemToList(_medicalHistory, value),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Vos antécédents médicaux:',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        _buildListItems(
                          _medicalHistory,
                          'Aucun antécédent médical enregistré',
                          (index) => _removeItemFromList(_medicalHistory, index),
                        ),
                      ],
                    ),
                  ),
                ),
                Step(
                  title: Text('Antécédents Familiaux', style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('Historique médical familial'),
                  isActive: _currentStep >= 2,
                  state: _currentStep > 2 ? StepState.complete : StepState.indexed,
                  content: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ajouter un antécédent familial',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        _buildAddItemField(
                          'Antécédent familial',
                          (value) => _addItemToList(_familyHistory, value),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Vos antécédents familiaux:',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        _buildListItems(
                          _familyHistory,
                          'Aucun antécédent familial enregistré',
                          (index) => _removeItemFromList(_familyHistory, index),
                        ),
                      ],
                    ),
                  ),
                ),
                Step(
                  title: Text('Allergies & Traitements', style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('Vos allergies et traitements actuels'),
                  isActive: _currentStep >= 3,
                  state: _currentStep > 3 ? StepState.complete : StepState.indexed,
                  content: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Allergies',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        _buildAddItemField(
                          'Ajouter une allergie',
                          (value) => _addItemToList(_allergies, value),
                        ),
                        SizedBox(height: 8),
                        _buildListItems(
                          _allergies,
                          'Aucune allergie enregistrée',
                          (index) => _removeItemFromList(_allergies, index),
                        ),
                        
                        SizedBox(height: 24),
                        
                        Text(
                          'Traitements Actuels',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        _buildAddItemField(
                          'Ajouter un traitement',
                          (value) => _addItemToList(_currentTreatments, value),
                        ),
                        SizedBox(height: 8),
                        _buildListItems(
                          _currentTreatments,
                          'Aucun traitement actuel enregistré',
                          (index) => _removeItemFromList(_currentTreatments, index),
                        ),
                      ],
                    ),
                  ),
                ),
                Step(
                  title: Text('Vaccinations', style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('Vos vaccins et rappels'),
                  isActive: _currentStep >= 4,
                  state: _currentStep > 4 ? StepState.complete : StepState.indexed,
                  content: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ajouter un vaccin ou rappel',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        _buildAddItemField(
                          'Vaccin (nom et date)',
                          (value) => _addItemToList(_vaccinations, value),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Vos vaccinations:',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        _buildListItems(
                          _vaccinations,
                          'Aucune vaccination enregistrée',
                          (index) => _removeItemFromList(_vaccinations, index),
                        ),
                      ],
                    ),
                  ),
                ),
                Step(
                  title: Text('Consultations & Examens', style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('Vos consultations et examens récents'),
                  isActive: _currentStep >= 5,
                  state: _currentStep > 5 ? StepState.complete : StepState.indexed,
                  content: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Consultations Récentes',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        _buildAddItemField(
                          'Ajouter une consultation',
                          (value) => _addItemToList(_recentConsultations, value),
                        ),
                        SizedBox(height: 8),
                        _buildListItems(
                          _recentConsultations,
                          'Aucune consultation récente enregistrée',
                          (index) => _removeItemFromList(_recentConsultations, index),
                        ),
                        
                        SizedBox(height: 24),
                        
                        Text(
                          'Examens Médicaux',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        _buildAddItemField(
                          'Ajouter un examen',
                          (value) => _addItemToList(_exams, value),
                        ),
                        SizedBox(height: 8),
                        _buildListItems(
                          _exams,
                          'Aucun examen médical enregistré',
                          (index) => _removeItemFromList(_exams, index),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}