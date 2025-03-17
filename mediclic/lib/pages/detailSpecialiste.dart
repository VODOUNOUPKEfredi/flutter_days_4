import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mediclic/pages/rendezvous.dart';
import 'package:mediclic/services/authentification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Detailspecialiste extends StatefulWidget {
  final DocumentSnapshot docteur;
  const Detailspecialiste({super.key, required this.docteur});
  @override
  State<StatefulWidget> createState() {
    return DetailspecialisteState();
  }
}

class DetailspecialisteState extends State<Detailspecialiste> {
  List<Map<String, dynamic>> _disponibilites = [];

  @override
  void initState() {
    super.initState();
    _getDisponibilites();
  }

  Future<void> _getDisponibilites() async {
    try {
      final docData = widget.docteur.data() as Map<String, dynamic>;
      if (docData.containsKey('disponibilité')) {
        setState(() {
          _disponibilites =
              List<Map<String, dynamic>>.from(docData['disponibilité']);
        });
      }
    } catch (e) {
      print("Erreur lors de la récupération des disponibilités : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    double largeurEcran = MediaQuery.of(context).size.width;
    double longueurEcran = MediaQuery.of(context).size.height;
    return Scaffold(
        /*floatingActionButton: 
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,*/
        body: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: longueurEcran * 0.4,
                width: largeurEcran,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 255, 255)),
                child: Image.asset(
                  fit: BoxFit.cover,
                  "images/docteur.png",
                  width: largeurEcran,
                ),
              ),
              Positioned(
                  top: 50,
                  left: 20,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(40)),
                        child: Center(
                          child: Icon(
                            Icons.arrow_back_rounded,
                            color: Colors.black,
                          ),
                        )),
                  )),
              Positioned(
                  top: longueurEcran * 0.35,
                  child: Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(20)),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    width: largeurEcran,
                    height: longueurEcran * 0.65,
                    child: Column(
                      //mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Dr. ",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(widget.docteur["name"],
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                            Text(
                              widget.docteur['speciality'],
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                            padding: EdgeInsets.all(8),
                            height: 85,
                            width: largeurEcran,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(27, 96, 125, 139),
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              spacing: 20,
                              children: [
                                Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 0, 255, 34),
                                    borderRadius: BorderRadius.circular(60),
                                  ),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      spacing: 5,
                                      children: [
                                        Text(
                                          "Clinique",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          "Divine Misericode",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          size: 15,
                                          color: Colors.amber,
                                        ),
                                        Icon(
                                          Icons.star,
                                          size: 15,
                                          color: Colors.amberAccent,
                                        ),
                                        Icon(
                                          Icons.star,
                                          size: 15,
                                          color: Colors.amberAccent,
                                        ),
                                        Icon(
                                          Icons.star,
                                          size: 15,
                                          color: Colors.white,
                                        ),
                                        Icon(
                                          Icons.star,
                                          size: 15,
                                          color: Colors.white,
                                        )
                                      ],
                                    ),
                                    GestureDetector(
                                      child: Row(
                                        children: [
                                          Icon(Icons.moving_sharp),
                                          Text(
                                            "Itinéraire",
                                            style:
                                                TextStyle(color: Colors.blue),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            )),
                        // Partie du container du calendrier
                        /*
                            Container(
                              height: longueurEcran * 0.30 > 300
                                  ? longueurEcran * 0.30
                                  : 300,
                              child: CalendarDatePicker(
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2030),
                                  onDateChanged: (DateTime) {}),
                            ),*/

                        /*Container(
                          width: largeurEcran,
                          height: 250,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Avis : ",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: const Color.fromARGB(
                                            255, 255, 255, 255),
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: const Color.fromARGB(
                                            255, 255, 255, 255),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              Container(
                                  padding: EdgeInsets.all(10),
                                  width: largeurEcran,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color.fromARGB(
                                            71, 158, 158, 158),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      //Icon(Icons.arrow_back_ios),
                                      Icon(
                                        Icons.keyboard_arrow_left_rounded,
                                        size: 50,
                                      ),
                                      Container(
                                        child: Column(
                                          children: [
                                            Row(
                                              spacing: 10,
                                              children: [
                                                Container(
                                                  height: 50,
                                                  width: 50,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              60),
                                                      color: Colors.blue),
                                                ),
                                                Text(
                                                  "Focas TCHANHOUI",
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                )
                                              ],
                                            ),
                                            Text(
                                                "Je vous recommande ce docteur")
                                          ],
                                        ),
                                      ),
                                      Icon(
                                        Icons.keyboard_arrow_right_outlined,
                                        size: 50,
                                      )
                                    ],
                                  ))
                            ],
                          ),
                        ),*/
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          children: [
                            Text(
                              "Prochains créneaux: ",
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.w500),
                            ),
                            if (_disponibilites.isNotEmpty)
                              for (var disponibilite in _disponibilites)
                                Row(
                                  spacing: 20,
                                  children: [
                                    Text(
                                        "Jour: ${disponibilite['Jour'] ?? 'N/A'}",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w300)),
                                    Row(
                                      children: [
                                        Text(
                                            "Horaire: ${disponibilite['Horaire'] ?? 'N/A'}",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w300)),
                                      ],
                                    ),
                                  ],
                                )
                            else
                              Text("Aucune disponibilité trouvée."),
                          ],
                        ),
                        ElevatedButton.icon(
                            icon: Icon(Icons.calendar_month),
                            onPressed: () =>
                                _showRendezvousDialog(context, _disponibilites),
                            label: Text("Prendre un Rendez-vous"))
                        /*GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                enableDrag: true,
                                showDragHandle: true,
                                //clipBehavior: Clip.antiAlias,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16),
                                  ),
                                ),
                                context: context,
                                builder: (context) {
                                  return SingleChildScrollView(
                                      child: Rendezvous());
                                },
                              );
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(5),
                                  height: 50,
                                  clipBehavior: Clip.hardEdge,
                                  width: largeurEcran * 0.55,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(60),
                                    color: Colors.blueAccent,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(
                                        Icons.calendar_month,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        "Prendre un rendez-vous",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 17,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )),*/
                        /*GestureDetector(
                          onTap: () {
                            showBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Container(
                                    height: longueurEcran,
                                    width: largeurEcran,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [Text("Data")],
                                      ),
                                    ),
                                  );
                                });
                            ;
                          },
                          child: Container(
                            width: largeurEcran * 0.6,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(50)),
                            padding: EdgeInsets.all(10),
                            child: Row(
                              spacing: 10,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.date_range,
                                  color: Colors.white,
                                ),
                                Text(
                                  "Prendre un Rendez-vous",
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),*/
                      ],
                    ),
                  )),
            ],
          ),
        ],
      ),
    ));
  }
}

Future<void> _showRendezvousDialog(
    BuildContext context, List<Map<String, dynamic>> disponibilites) async {
  String? selectedDay;
  String? selectedTime;

  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            title: Text("Prendre un rendez-vous"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  value: selectedDay,
                  items: disponibilites.map((disponibilite) {
                    return DropdownMenuItem<String>(
                      value: disponibilite['Jour'],
                      child: Text(disponibilite['Jour'] ?? 'N/A'),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedDay = value;
                    });
                  },
                  decoration: InputDecoration(labelText: "Jour"),
                ),
                SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: selectedTime,
                  items: disponibilites
                      .where((disponibilite) =>
                          disponibilite['Jour'] == selectedDay)
                      .map((disponibilite) {
                    return DropdownMenuItem<String>(
                      value: disponibilite['Horaire'],
                      child: Text(disponibilite['Horaire'] ?? 'N/A'),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedTime = value;
                    });
                  },
                  decoration: InputDecoration(labelText: "Horaire"),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Annuler"),
              ),
              ElevatedButton(
                onPressed: () {
                  if (selectedDay != null && selectedTime != null) {
                    // TODO: Enregistrer le rendez-vous avec le jour et l'heure choisis
                    print("Rendez-vous pris pour $selectedDay à $selectedTime");
                    Navigator.of(context).pop();
                  }
                },
                child: Text("Confirmer"),
              ),
            ],
          );
        },
      );
    },
  );
}
