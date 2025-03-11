import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mediclic/services/authentification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Profil extends StatefulWidget {
  const Profil({super.key});
  @override
  State<StatefulWidget> createState() {
    return ProfilState();
  }
}

class ProfilState extends State {
  String? _username;
  String? _userSurname;

  @override
  void initState() {
    super.initState();
    _fetchUsername();
    _fetchUserSurname();
  }

  Future<void> _fetchUsername() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    String? uid = user?.uid;

    if (uid != null) {
      String? username = await getUsername(uid);
      setState(() {
        _username = username;
      });
    }
  }

  Future<void> _fetchUserSurname() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    String? uid = user?.uid;

    if (uid != null) {
      String? userSurname = await getUserSurname(uid);
      setState(() {
        _userSurname = userSurname;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double largeurEcran = MediaQuery.of(context).size.width;
    double longueurEcran = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                children: [
                  Container(
                    height: 250,
                    width: largeurEcran,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(142, 112, 129, 143)),
                  ),
                ],
              ),
              Positioned(
                  top: 200,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                        width: largeurEcran,
                        child: Row(
                          spacing: 10,
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(180),
                                  color:
                                      const Color.fromARGB(255, 227, 227, 227)),
                              child: Icon(
                                Icons.person,
                                size: 160,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
              Positioned(
                  top: 300,
                  left: largeurEcran * 0.55,
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: const Color.fromARGB(255, 73, 73, 73)),
                    child: Icon(
                      Icons.camera_alt,
                      size: 25,
                      color: const Color.fromARGB(255, 255, 255, 255),
                    ),
                  ))
            ],
          ),
          Container(
            width: largeurEcran,
            margin: EdgeInsets.only(top: 120, left: 30, right: 30),
            child: Column(
              spacing: 10,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  spacing: 10,
                  children: [
                    Icon(
                      Icons.person_3_rounded,
                      size: 20,
                      color: const Color.fromARGB(255, 111, 128, 137),
                    ),
                    Text(
                      _username == null
                          ? ' Chargement ...'
                          : "$_username $_userSurname",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                    ),
                  ],
                ),
                Row(
                  spacing: 10,
                  children: [
                    Icon(
                      Icons.calendar_month,
                      size: 20,
                      color: const Color.fromARGB(255, 111, 128, 137),
                    ),
                    Text(
                      "Date de naissance",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                    ),
                  ],
                ),
                Row(
                  spacing: 10,
                  children: [
                    Icon(
                      Icons.mail,
                      size: 20,
                      color: const Color.fromARGB(255, 111, 128, 137),
                    ),
                    Text(
                      "${FirebaseAuth.instance.currentUser?.email}",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 60),
            child: ElevatedButton.icon(
                onPressed: () async {
                  CircularProgressIndicator();
                  await AuthServices().signout(context: context);
                },
                iconAlignment: IconAlignment.start,
                label: Text(
                  'Modifier ses informations',
                  style: TextStyle(
                      color: const Color.fromARGB(255, 255, 255, 255)),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 145, 170, 229),
                  fixedSize: Size(largeurEcran * 0.8, 40),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                )),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: ElevatedButton.icon(
                onPressed: () async {
                  CircularProgressIndicator();
                  await AuthServices().signout(context: context);
                },
                iconAlignment: IconAlignment.start,
                label: Text(
                  'Se deconnecter',
                  style: TextStyle(
                      color: const Color.fromARGB(255, 135, 135, 135)),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 255, 255, 255),
                  fixedSize: Size(largeurEcran * 0.8, 40),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                )),
          )
        ],
      ),
    );
  }
}

Future<String?> getUsername(String uid) async {
  try {
    DocumentSnapshot document =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    if (document.exists) {
      return document['nom'] as String?;
    } else {
      return null;
    }
  } catch (e) {
    print('Erreur: $e');
    return null;
  }
}

Future<String?> getUserSurname(String uid) async {
  try {
    DocumentSnapshot document =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    if (document.exists) {
      return document['prenom'] as String?;
    } else {
      return null;
    }
  } catch (e) {
    print('Ereur: $e');
    return null;
  }
}
