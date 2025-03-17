import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mediclic/pages/detailSpecialiste.dart';

class Specialiste extends StatefulWidget {
  const Specialiste({super.key});

  @override
  State<StatefulWidget> createState() {
    return SpecialisteState();
  }
}

class SpecialisteState extends State {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = '';
  List<DocumentSnapshot> _searchResults = [];

  Future<void> _searchSpecialists(String query) async {
    setState(() {
      _searchResults = [];
    });

    QuerySnapshot snapshot;
    /*if (query.isNotEmpty) {
      snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('role', isEqualTo: 'medecin')
          .where('specialite', isEqualTo: query)
          .get();
    } else if (_selectedCategory.isNotEmpty) {
      snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('role', isEqualTo: 'medecin')
          .where('specialite', isEqualTo: _selectedCategory)
          .get();
    } else {
      return;
    }
    */
    if (query.isNotEmpty) {
      snapshot = await FirebaseFirestore.instance
          .collection('doctors')
          .where('speciality', isEqualTo: query)
          .get();
    } else if (_selectedCategory.isNotEmpty) {
      snapshot = await FirebaseFirestore.instance
          .collection('doctors')
          .where('speciality', isEqualTo: _selectedCategory)
          .get();
    } else {
      return;
    }

    setState(() {
      _searchResults = snapshot.docs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rechercher un spécialiste"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Container(
              height: 50,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  const Icon(Icons.search, color: Colors.grey),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Rechercher un spécialiste',
                        hintStyle: TextStyle(color: Colors.grey[600]),
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(color: Colors.black87),
                      onChanged: (value) {
                        _searchSpecialists(value);
                      },
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.tune),
                    onPressed: () {},
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            const Text(
              "  Catégories",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 28, 28, 28),
              ),
            ),
            SizedBox(
              height: 200,
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 1,
                ),
                children: [
                  _categories("Generaliste", "images/generaliste.png"),
                  _categories("Ophtamologue", "images/ophtamologie.png"),
                  _categories("Cardiologue", "images/heart.png"),
                  _categories("Gynécologue", "images/genycologie.png"),
                  _categories("Pediatre", "images/generaliste.png"),
                  _categories("Dermatologue", "images/generaliste.png"),
                  _categories("Neurologue", "images/generaliste.png")
                ],
              ),
            ),
            if (_searchResults.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Résultats de la recherche :",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _searchResults.length,
                    itemBuilder: (context, index) {
                      final doc =
                          _searchResults[index].data() as Map<String, dynamic>;
                      return GestureDetector(
                        onTap: () {
                          if (doc.isNotEmpty) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Detailspecialiste(
                                    docteur: _searchResults[index]),
                              ),
                            );
                          }
                        },
                        child: Container(
                            padding: EdgeInsets.all(5),
                            height: 80,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(27, 96, 125, 139),
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              spacing: 20,
                              children: [
                                /*Container(
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 197, 184, 198),
                                    borderRadius: BorderRadius.circular(60),
                                  ),
                                ),*/
                                CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      "https://images.pexels.com/photos/31035109/pexels-photo-31035109.jpeg"),
                                  radius: 25,
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      spacing: 5,
                                      children: [
                                        Text(
                                          "Dr",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          doc['name'] ?? 'Nom inconnu',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      doc['speciality'] ??
                                          'Spécialité inconnue',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: const Color.fromARGB(
                                              113, 0, 0, 0)),
                                    ),
                                    Text(
                                      doc['cliniqueId'] ?? 'Clinique',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: const Color.fromARGB(
                                              113, 0, 0, 0)),
                                    ),
                                  ],
                                )
                              ],
                            )),
                      );
                    },
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _categories(String title, String imagePath) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = title;
          _searchController.clear();
        });
        _searchSpecialists(title);
      },
      child: Container(
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(71, 158, 158, 158),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              height: 60,
              width: 60,
              fit: BoxFit.contain,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
