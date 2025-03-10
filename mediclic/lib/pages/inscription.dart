import 'package:flutter/material.dart';
import 'package:mediclic/services/authentification.dart';

class Inscription extends StatefulWidget {
  const Inscription({super.key});

  @override
  State<Inscription> createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {
  @override
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController controleur_email = TextEditingController();
  TextEditingController controleur_nom = TextEditingController();
  TextEditingController controleur_prenom = TextEditingController();
  TextEditingController controleur_date = TextEditingController();
  DateTime? controleur_date_naissance;
  TextEditingController controleur_groupe_sanguin = TextEditingController();
  TextEditingController controleur_allergies = TextEditingController();

  TextEditingController controleur_password = TextEditingController();

  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1990, 1),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  final String _name = '';
  String _email = '';
  void _submitForm() {
    if (_formKey.currentState!.validate()) {}
  }

  @override
  Widget build(BuildContext context) {
    double largeurEcran = MediaQuery.of(context).size.width;
    double longueurEcran = MediaQuery.of(context).size.height;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Text(
              "Inscription",
              style: TextStyle(color: Colors.black, fontSize: 40),
            ),
            Padding(padding: EdgeInsets.only(bottom: 10)),
            TextFormField(
              controller: controleur_nom,
              decoration: InputDecoration(
                hintText: "Nom",
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10)),
                filled: true,
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Entrez votre nom';
                }
                return null;
              },
            ),
            TextFormField(
              controller: controleur_prenom,
              decoration: InputDecoration(
                hintText: "Prénom",
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10)),
                filled: true,
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Entrez votre prénom.';
                }
                return null;
              },
            ),
            TextFormField(
              readOnly: true,
              controller: controleur_date,
              onTap: () => _selectDate(context),
              decoration: InputDecoration(
                hintText: selectedDate != null
                    ? selectedDate.toString()
                    : "Date de naissance",
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10)),
                filled: true,
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Entrez votre date de naissance';
                }
                return null;
              },
            ),
            TextFormField(
              controller: controleur_email,
              decoration: InputDecoration(
                hintText: "Email",
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10)),
                filled: true,
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Entrez votre email';
                }
                return null;
              },
            ),
            TextFormField(
              controller: controleur_groupe_sanguin,
              keyboardType: TextInputType.numberWithOptions(),
              decoration: InputDecoration(
                hintText: "Entrez votre groupe sanguin(Optionnel)",
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10)),
                filled: true,
              ),
            ),
            TextFormField(
              controller: controleur_allergies,
              keyboardType: TextInputType.numberWithOptions(),
              decoration: InputDecoration(
                hintText: "Entrez vos allergies(Optionnel)",
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10)),
                filled: true,
              ),
            ),
            TextFormField(
              controller: controleur_password,
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Mot de passe",
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10)),
                filled: true,
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Entrez un mot de passe';
                }
                return null;
              },
            ),
            SizedBox(height: 10.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
                backgroundColor: Colors.blue,
                fixedSize: Size(largeurEcran * 0.8, 50),
              ),
              onPressed: () async {
                _submitForm;

                await AuthServices().signup(
                    email: controleur_email.text,
                    password: controleur_password.text,
                    nom: controleur_nom.text,
                    prenom: controleur_prenom.text,
                    date: selectedDate.toString(),
                    groupeSanguin: controleur_groupe_sanguin.text,
                    allergies: controleur_allergies.text,
                    context: context);
              },
              child: Text(
                'Inscription',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ));
  }
}
