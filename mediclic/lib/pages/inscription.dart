import 'package:flutter/material.dart';
import 'package:mediclic/services/authentification.dart';
import 'package:mediclic/pages/connexion.dart';
import 'package:intl/intl.dart';

class Inscription extends StatefulWidget {
  const Inscription({super.key});

  @override
  State<Inscription> createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController controleur_email = TextEditingController();
  TextEditingController controleur_nom = TextEditingController();
  TextEditingController controleur_prenom = TextEditingController();
  TextEditingController controleur_date = TextEditingController();
  DateTime? selectedDate;
  TextEditingController controleur_groupe_sanguin = TextEditingController();
  TextEditingController controleur_allergies = TextEditingController();
  TextEditingController controleur_password = TextEditingController();
  TextEditingController controleur_confirm_password = TextEditingController();
  bool _obscureTextPassword = true;
  bool _obscureTextConfirm = true;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 18)),
      firstDate: DateTime(1940, 1),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: const Color(0xFF144DDE),
            colorScheme: const ColorScheme.light(primary: Color(0xFF144DDE)),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        controleur_date.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {}
  }

  @override
  Widget build(BuildContext context) {
    double largeurEcran = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Créer un compte",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInputLabel("Nom"),
              TextFormField(
                controller: controleur_nom,
                decoration: _buildInputDecoration("Nom"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer votre nom';
                  }
                  if (!RegExp(r'^[a-zA-ZÀ-ÿ\s]+$').hasMatch(value)) {
                    return 'Le nom ne doit contenir que des lettres';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildInputLabel("Prénoms"),
              TextFormField(
                controller: controleur_prenom,
                decoration: _buildInputDecoration("Prénoms"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer votre prénom';
                  }
                  if (!RegExp(r'^[a-zA-ZÀ-ÿ\s]+$').hasMatch(value)) {
                    return 'Le prénom ne doit contenir que des lettres';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildInputLabel("Date de naissance"),
              TextFormField(
                controller: controleur_date,
                readOnly: true,
                onTap: () => _selectDate(context),
                decoration: _buildInputDecoration("Date de naissance"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez sélectionner votre date de naissance';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildInputLabel("Email"),
              TextFormField(
                controller: controleur_email,
                keyboardType: TextInputType.emailAddress,
                decoration: _buildInputDecoration("Email"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer votre email';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                      .hasMatch(value)) {
                    return 'Veuillez entrer un email valide';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildInputLabel("Mot de passe"),
              TextFormField(
                controller: controleur_password,
                obscureText: _obscureTextPassword,
                decoration: InputDecoration(
                  hintText: "Mot de passe",
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureTextPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureTextPassword = !_obscureTextPassword;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer un mot de passe';
                  }
                  if (value.length < 6) {
                    return 'Le mot de passe doit contenir au moins 6 caractères';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildInputLabel("Confirmer mot de passe"),
              TextFormField(
                controller: controleur_confirm_password,
                obscureText: _obscureTextConfirm,
                decoration: InputDecoration(
                  hintText: "Confirmer mot de passe",
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureTextConfirm
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureTextConfirm = !_obscureTextConfirm;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez confirmer votre mot de passe';
                  }
                  if (value != controleur_password.text) {
                    return 'Les mots de passe ne correspondent pas';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildInputLabel("Groupe sanguin (Optionnel)"),
              TextFormField(
                controller: controleur_groupe_sanguin,
                decoration: _buildInputDecoration("Groupe sanguin"),
                validator: (value) {
                  if (value!.isNotEmpty) {
                    List<String> validBloodGroups = [
                      'A+',
                      'A-',
                      'B+',
                      'B-',
                      'AB+',
                      'AB-',
                      'O+',
                      'O-'
                    ];
                    if (!validBloodGroups.contains(value.toUpperCase())) {
                      return 'Groupe sanguin invalide (A+, A-, B+, B-, AB+, AB-, O+, O-)';
                    }
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildInputLabel("Allergies (Optionnel)"),
              TextFormField(
                controller: controleur_allergies,
                maxLines: 2,
                decoration: _buildInputDecoration("Vos allergies"),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF144DDE),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 2,
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await AuthServices().signup(
                        email: controleur_email.text,
                        password: controleur_password.text,
                        nom: controleur_nom.text,
                        prenom: controleur_prenom.text,
                        date: selectedDate.toString(),
                        groupeSanguin: controleur_groupe_sanguin.text,
                        allergies: controleur_allergies.text,
                        context: context,
                      );
                    }
                  },
                  child: const Text(
                    "S'inscrire",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Déjà inscrit ? ",
                    style: TextStyle(color: Colors.black54),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Connexion(),
                        ),
                      );
                    },
                    child: const Text(
                      "Se connecter",
                      style: TextStyle(
                        color: Color(0xFF144DDE),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.black54,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(16),
      ),
      filled: true,
      fillColor: Colors.grey[100],
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
    );
  }
}
