import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ClinicCreationForm extends StatefulWidget {
  @override
  _ClinicCreationFormState createState() => _ClinicCreationFormState();
}

class _ClinicCreationFormState extends State<ClinicCreationForm> {
  final TextEditingController _clinicNameController = TextEditingController();

  Future<void> _createClinic() async {
    try {
      await FirebaseFirestore.instance.collection('clinics').add({
        'name': _clinicNameController.text,
        'created_at': Timestamp.now(),
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Clinic created!')));
      Navigator.pop(context);
    } catch (e) {
      print('Error creating clinic: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Clinic')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _clinicNameController,
              decoration: InputDecoration(labelText: 'Clinic Name'),
            ),
            ElevatedButton(
              onPressed: _createClinic,
              child: Text('Create Clinic'),
            ),
          ],
        ),
      ),
    );
  }
}
