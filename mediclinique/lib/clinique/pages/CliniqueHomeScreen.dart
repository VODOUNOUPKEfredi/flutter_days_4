import 'package:flutter/material.dart';
import 'package:mediclic/services/roles.dart';

class RegisterDoctorWidget extends StatefulWidget {
  @override
  _RegisterDoctorWidgetState createState() => _RegisterDoctorWidgetState();
}

class _RegisterDoctorWidgetState extends State<RegisterDoctorWidget> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  
  String email = '';
  String password = '';
  String confirmPassword = '';
  String nom = '';
  String prenom = '';
  String specialite = '';
  int age = 0;
  
  bool isLoading = false;
  String errorMessage = '';
  String successMessage = '';

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Ajouter un nouveau médecin',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              
              // Nom
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Nom',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? 'Veuillez entrer le nom' : null,
                onChanged: (value) => nom = value,
              ),
              SizedBox(height: 10),
              
              // Prénom
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Prénom',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? 'Veuillez entrer le prénom' : null,
                onChanged: (value) => prenom = value,
              ),
              SizedBox(height: 10),
              
              // Âge
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Âge',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer l\'âge';
                  }
                  int? ageValue = int.tryParse(value);
                  if (ageValue == null || ageValue <= 0) {
                    return 'Veuillez entrer un âge valide';
                  }
                  return null;
                },
                onChanged: (value) {
                  age = int.tryParse(value) ?? 0;
                },
              ),
              SizedBox(height: 10),
              
              // Spécialité
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Spécialité',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? 'Veuillez entrer la spécialité' : null,
                onChanged: (value) => specialite = value,
              ),
              SizedBox(height: 10),
              
              // Email
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer un email';
                  }
                  if (!value.contains('@')) {
                    return 'Veuillez entrer un email valide';
                  }
                  return null;
                },
                onChanged: (value) => email = value,
              ),
              SizedBox(height: 10),
              
              // Mot de passe
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Mot de passe',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer un mot de passe';
                  }
                  if (value.length < 6) {
                    return 'Le mot de passe doit contenir au moins 6 caractères';
                  }
                  return null;
                },
                onChanged: (value) => password = value,
              ),
              SizedBox(height: 10),
              
              // Confirmation mot de passe
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Confirmer le mot de passe',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value != password) {
                    return 'Les mots de passe ne correspondent pas';
                  }
                  return null;
                },
                onChanged: (value) => confirmPassword = value,
              ),
              
              SizedBox(height: 15),
              
              // Messages
              if (errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    errorMessage,
                    style: TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ),
                
              if (successMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    successMessage,
                    style: TextStyle(color: Colors.green),
                    textAlign: TextAlign.center,
                  ),
                ),
              
              // Bouton d'inscription
              ElevatedButton(
                onPressed: isLoading ? null : _registerDoctor,
                child: isLoading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text('Ajouter le médecin'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _registerDoctor() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
        errorMessage = '';
        successMessage = '';
      });
      
      try {
        // Récupérer l'ID de la clinique connectée
        String? cliniqueId = _authService.getCurrentUserId();
        
        if (cliniqueId == null) {
          throw Exception('Aucune clinique connectée');
        }
        
        await _authService.registerDoctor(
          email: email,
          password: password,
          nom: nom,
          prenom: prenom,
          specialite: specialite,
          age: age,
          cliniqueId: cliniqueId,
        );
        
        // Réinitialiser le formulaire
        _formKey.currentState!.reset();
        
        setState(() {
          successMessage = 'Le médecin a été ajouté avec succès';
          // Réinitialiser les variables
          email = '';
          password = '';
          confirmPassword = '';
          nom = '';
          prenom = '';
          specialite = '';
          age = 0;
        });
      } catch (e) {
        setState(() {
          errorMessage = e.toString();
        });
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }
  
}
