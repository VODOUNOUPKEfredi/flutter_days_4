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
    double largeurEcran = MediaQuery.of(context).size.width;
    double longueurEcran = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Mon dossier médical"),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.download_rounded))
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          spacing: 5,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Informations personnelles",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            Container(
              padding: EdgeInsets.all(10),
              width: largeurEcran,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    width: 2, color: Colors.grey, style: BorderStyle.solid),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 5,
                children: [
                  Text("Nom: "),
                  Text("Prénom: "),
                  Text("Date de naissance: "),
                  Text("Groupe sanguin:: "),
                  Text("Allergies: "),
                  Text("Maladies chroniques: "),
                  Text("Contacts d'urgence: ")
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Antécédents médicaux et chirugicaux",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                Text(
                  "Plus",
                  style: TextStyle(color: Colors.blue),
                )
              ],
            ),
            Container(
                padding: EdgeInsets.all(10),
                width: largeurEcran,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      width: 2, color: Colors.grey, style: BorderStyle.solid),
                ),
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Consultation",
                        style: TextStyle(fontSize: 15),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "10 Décembre 2024",
                            style: TextStyle(fontSize: 10, color: Colors.blue),
                          ),
                          Text("18h44",
                              style:
                                  TextStyle(fontSize: 10, color: Colors.blue))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [Text("Dr Focas "), Text("Chirugien")],
                      )
                    ],
                  ),
                )),
            SizedBox(
              height: 10,
            ),
            Text(
              "Historique médical",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            Container(
                padding: EdgeInsets.all(10),
                width: largeurEcran,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      width: 2, color: Colors.grey, style: BorderStyle.solid),
                ),
                child: Center(
                  child: Text(
                    "Rien à afficher",
                    style: TextStyle(fontSize: 25, color: Colors.grey),
                  ),
                )),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Documents médicaux et légaux",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                Text(
                  "Voir plus",
                  style: TextStyle(color: Colors.blue),
                ),
              ],
            ),
            Container(
                padding: EdgeInsets.all(10),
                width: largeurEcran,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      width: 2, color: Colors.grey, style: BorderStyle.solid),
                ),
                child: Center(
                  child: Text(
                    "Rien à afficher",
                    style: TextStyle(fontSize: 25, color: Colors.grey),
                  ),
                )),
            GestureDetector(
                onTap: () {},
                child: Container(
                    height: 60,
                    decoration: BoxDecoration(color: Colors.blue),
                    child: Center(
                      child: Text(
                        "Voir l'historique des accès",
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ))),
          ],
        ),
      ),
    );
  }
}
