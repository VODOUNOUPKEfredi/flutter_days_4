import 'package:flutter/material.dart';

class Historiquemedical extends StatefulWidget {
  const Historiquemedical({super.key});
  @override
  State<StatefulWidget> createState() {
    return HistoriquemedicalState();
  }
}

class HistoriquemedicalState extends State {
  @override
  Widget build(BuildContext context) {
    double largeurEcran = MediaQuery.of(context).size.width;
    double longueurEcran = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("Historique"),
          /*actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.download_rounded))
          ],*/
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              GestureDetector(
                child: Container(
                  padding: EdgeInsets.all(10),
                  height: 100,
                  width: largeurEcran,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromARGB(16, 119, 119, 119),
                    border: Border.all(
                        width: 2, color: const Color.fromARGB(47, 68, 68, 68)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            spacing: 10,
                            children: [
                              Text(
                                "Dr Focas .",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    color: const Color.fromARGB(
                                        255, 28, 111, 255)),
                              ),
                              Text("Spécialité"),
                            ],
                          ),
                          GestureDetector(
                            child: Text(
                              "Détails",
                              style: TextStyle(
                                  color: Colors.blueAccent, fontSize: 15),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Hopital Saint Luc . Salle 203",
                            style: TextStyle(color: Colors.blueGrey),
                          ),
                          Text(
                            "10/05/2024",
                            style: TextStyle(color: Colors.blueGrey),
                          ),
                        ],
                      ),
                      Text(
                        "Motif: ",
                        style: TextStyle(overflow: TextOverflow.ellipsis),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
