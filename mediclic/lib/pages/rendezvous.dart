import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mediclic/services/authentification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Rendezvous extends StatefulWidget {
  const Rendezvous({super.key});
  @override
  State<StatefulWidget> createState() {
    return RendezvousState();
  }
}

class RendezvousState extends State<Rendezvous> {
  String? _username;
  String? _userSurname;

  @override
  Widget build(BuildContext context) {
    double largeurEcran = MediaQuery.of(context).size.width;
    double longueurEcran = MediaQuery.of(context).size.height;
    return Container(
      height: longueurEcran,
      width: largeurEcran,
      decoration: BoxDecoration(color: Colors.amber),
      child: Text(
        "Welcome",
        style: TextStyle(color: Colors.black12),
      ),
    );
  }
}
