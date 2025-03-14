import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  @override
  Widget build(BuildContext context) {
    double largeurEcran = MediaQuery.of(context).size.width;
    double longueurEcran = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: longueurEcran * 0.4,
                width: largeurEcran,
                decoration: BoxDecoration(color: Colors.amber),
                child: Image.asset(
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
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    width: largeurEcran,
                    height: longueurEcran * 0.75,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Dr. ",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(widget.docteur["nom"],
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                            Text(
                              widget.docteur['specialite'],
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey),
                            )
                          ],
                        ),
                        Container(
                            padding: EdgeInsets.all(8),
                            height: 100,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(27, 96, 125, 139),
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              spacing: 20,
                              children: [
                                Container(
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 197, 184, 198),
                                    borderRadius: BorderRadius.circular(60),
                                  ),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
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
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          "Divine Misericode",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: const Color.fromARGB(
                                              113, 0, 0, 0)),
                                    ),
                                    Text(
                                      "",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: const Color.fromARGB(
                                              113, 0, 0, 0)),
                                    ),
                                  ],
                                )
                              ],
                            )),
                      ],
                    ),
                  ))
            ],
          )
        ],
      ),
    ));
  }
}
