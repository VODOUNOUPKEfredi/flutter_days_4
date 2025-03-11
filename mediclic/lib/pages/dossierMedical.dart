import 'package:flutter/material.dart';

class Dossiermedical extends StatefulWidget {
  const Dossiermedical({super.key});
  @override
  State<StatefulWidget> createState() {
    return DossiermedicalState();
  }
}

class DossiermedicalState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mon dossier médical"),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.download_rounded))
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          children: [
            Text(
              "Informations personnelles",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}
