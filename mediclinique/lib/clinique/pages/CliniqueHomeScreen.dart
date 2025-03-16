
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mediclic/services/auth_service.dart';

class RegisterClinicWidget extends StatefulWidget {
  @override
  _RegisterClinicWidgetState createState() => _RegisterClinicWidgetState();
}

class _RegisterClinicWidgetState extends State<RegisterClinicWidget> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late GoogleMapController mapController;
  LatLng _selectedLocation = LatLng(6.3640, 2.4234); // Cotonou par défaut

  bool isLoading = false;
  String errorMessage = '';
  String successMessage = '';

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Ajouter une nouvelle clinique',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),

              _buildTextField(_nameController, 'Nom de la clinique', 'Veuillez entrer le nom'),
              _buildTextField(_addressController, 'Adresse', 'Veuillez entrer l\'adresse'),
              _buildTextField(_emailController, 'Email', 'Veuillez entrer l\'email'),
              _buildTextField(_passwordController, 'Mot de passe', 'Veuillez entrer un mot de passe', obscureText: true),

              // Google Map Widget
              SizedBox(
                height: 300,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: _selectedLocation,
                    zoom: 12,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    mapController = controller;
                  },
                  onTap: (LatLng location) {
                    setState(() {
                      _selectedLocation = location;
                    });
                  },
                  markers: {
                    Marker(
                      markerId: MarkerId('clinic_location'),
                      position: _selectedLocation,
                      infoWindow: InfoWindow(title: 'Clinique', snippet: 'Lieu de la clinique'),
                    ),
                  },
                ),
              ),

              const SizedBox(height: 10),

              if (errorMessage.isNotEmpty)
                Text(errorMessage, style: const TextStyle(color: Colors.red), textAlign: TextAlign.center),
              if (successMessage.isNotEmpty)
                Text(successMessage, style: const TextStyle(color: Colors.green), textAlign: TextAlign.center),

              const SizedBox(height: 10),

              ElevatedButton(
                onPressed: isLoading ? null : _registerClinic,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Ajouter la clinique'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, String errorText, {bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: (value) => value == null || value.isEmpty ? errorText : null,
      ),
    );
  }

  void _registerClinic() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
      errorMessage = '';
      successMessage = '';
    });

    try {
      String? result = await _authService.registerClinic(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        nomClinique: _nameController.text.trim(),
        latitude: _selectedLocation.latitude,
        longitude: _selectedLocation.longitude,
      );

      if (result == null) {
        _formKey.currentState!.reset();
        _nameController.clear();
        _addressController.clear();
        _emailController.clear();
        _passwordController.clear();

        setState(() => successMessage = 'La clinique a été ajoutée avec succès');
      } else {
        setState(() => errorMessage = result);
      }
    } catch (e) {
      setState(() => errorMessage = "Erreur : ${e.toString()}");
    } finally {
      setState(() => isLoading = false);
    }
  }
}
