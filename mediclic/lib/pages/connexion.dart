import 'package:flutter/material.dart';
import 'package:mediclic/pages/inscription.dart';
import 'package:mediclic/pages/connexion.dart';
import 'package:mediclic/services/authentification.dart';

class Connexion extends StatefulWidget {
  const Connexion({super.key});
  @override
  State<StatefulWidget> createState() {
    return ConnexionState();
  }
}

class ConnexionState extends State {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController controleur_email = TextEditingController();
  TextEditingController controleur_password = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {}
  }

  @override
  Widget build(BuildContext context) {
    double largeurEcran = MediaQuery.of(context).size.width;
    double longueurEcran = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(padding: EdgeInsets.only(bottom: 10)),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color.fromARGB(206, 255, 255, 255),
            ),
            width: largeurEcran * 0.8,
            child: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  spacing: 10,
                  children: <Widget>[
                    Text(
                      "Se connecter",
                      style: TextStyle(color: Colors.black, fontSize: 40),
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 10)),
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
                          return 'Entrez un email.';
                        }

                        return null;
                      },
                    ),
                    TextFormField(
                      obscureText: true,
                      controller: controleur_password,
                      decoration: InputDecoration(
                        hintText: "Mot de passe",
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10)),
                        filled: true,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Entrez le mot de passe.';
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
                        await AuthServices().signin(
                            email: controleur_email.text,
                            password: controleur_password.text,
                            context: context);
                      },
                      child: Text(
                        'Se connecter',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
