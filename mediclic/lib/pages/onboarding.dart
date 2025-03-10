import 'package:flutter/material.dart';
import 'package:mediclic/pages/inscription.dart';
import 'package:mediclic/pages/connexion.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});
  @override
  State<StatefulWidget> createState() {
    return OnboardingState();
  }
}

class OnboardingState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "MediCare",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
            ),
            Text("Votre santé en un clic"),
            ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const Inscription()));
              },
              child: Text(
                'Inscription',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => const Connexion()));
              },
              child: Text(
                'Se connecter',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
