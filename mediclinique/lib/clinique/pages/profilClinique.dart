import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mediclic/services/auth_service.dart';

class ClinicProfileScreen extends StatefulWidget {
  @override
  _ClinicProfileScreenState createState() => _ClinicProfileScreenState();
}

class _ClinicProfileScreenState extends State<ClinicProfileScreen> {
  String? email;
  String? clinicName;

  @override
  void initState() {
    super.initState();
    _fetchProfile();
  }

  Future<void> _fetchProfile() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String? role = await AuthService().getUserRole();
      setState(() {
        email = user.email;
        clinicName = role == "clinique" ? "Clinique " + user.displayName! : user.displayName;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profil Clinique")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(radius: 40, child: Icon(Icons.local_hospital, size: 40)),
            SizedBox(height: 20),
            Text("Nom: $clinicName", style: TextStyle(fontSize: 18)),
            Text("Email: $email", style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pop(context);
              },
              child: Text("Se déconnecter"),
            ),
          ],
        ),
      ),
    );
  }
}