import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mediclic/services/authentification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Rendezvous extends StatefulWidget {
  Rendezvous({super.key});
  @override
  State<StatefulWidget> createState() {
    return RendezvousState();
  }
}

class RendezvousState extends State {
  @override
  Widget build(BuildContext context) {
    double largeurEcran = MediaQuery.of(context).size.width;
    double longueurEcran = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Rendez-vous"),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
