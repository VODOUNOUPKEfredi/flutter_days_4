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
                                size: 80,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ))
            ],
          ),
          Container(
            width: largeurEcran,
            margin: EdgeInsets.only(top: 120, left: 10, right: 10),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _username == null ? 'Nom: Chargement ...' : "Nom: $_username",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                ),
                Text(
                  _userSurname == null
                      ? "Prénom: Chargement"
                      : "Prénom: $_userSurname",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                ),
                Text(
                  "Email: ${FirebaseAuth.instance.currentUser?.email}",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
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
                icon: Icon(
                  Icons.output,
                  size: 40,
                  color: Colors.white,
                ),
                iconAlignment: IconAlignment.start,
                label: Text(
                  'Se deconnecter',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 0, 89, 255),
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
