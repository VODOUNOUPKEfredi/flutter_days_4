import 'package:flutter/material.dart';

class ClinicProfileScreen extends StatefulWidget {
  @override
  _ClinicProfileScreenState createState() => _ClinicProfileScreenState();
}

class _ClinicProfileScreenState extends State<ClinicProfileScreen> {
  bool _isEditing = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _hoursController = TextEditingController();
  
  String clinicName = "Clinique Santé";
  String clinicAddress = "123 Rue des Soins, Cotonou";
  String clinicPhone = "+229 123 456 789";
  String clinicEmail = "contact@cliniquesante.com";
  String clinicHours = "Lun-Ven: 8h-18h, Sam: 9h-14h";

  @override
  void initState() {
    super.initState();
    _initControllers();
  }

  void _initControllers() {
    _nameController.text = clinicName;
    _addressController.text = clinicAddress;
    _phoneController.text = clinicPhone;
    _emailController.text = clinicEmail;
    _hoursController.text = clinicHours;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _hoursController.dispose();
    super.dispose();
  }

  void _toggleEdit() {
    setState(() {
      if (_isEditing) {
        // Save data
        clinicName = _nameController.text;
        clinicAddress = _addressController.text;
        clinicPhone = _phoneController.text;
        clinicEmail = _emailController.text;
        clinicHours = _hoursController.text;
      } else {
        // Initialize controllers with current data
        _initControllers();
      }
      _isEditing = !_isEditing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.teal,
        title: Text(
          "Profil de la Clinique",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        actions: [
          AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            child: IconButton(
              key: ValueKey<bool>(_isEditing),
              icon: Icon(
                _isEditing ? Icons.check : Icons.edit,
                color: Colors.white,
              ),
              onPressed: _toggleEdit,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: _isEditing ? _buildEditForm() : _buildInfoDisplay(),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _isEditing 
          ? FloatingActionButton(
              backgroundColor: Colors.teal,
              child: Icon(Icons.save),
              onPressed: _toggleEdit,
            )
          : null,
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: 20, bottom: 24),
      decoration: BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Icon(
                Icons.local_hospital,
                color: Colors.teal,
                size: 50,
              ),
            ),
          ),
          SizedBox(height: 16),
          Text(
            clinicName,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoDisplay() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoItem(Icons.place, "Adresse", clinicAddress),
        Divider(),
        _buildInfoItem(Icons.phone, "Téléphone", clinicPhone),
        Divider(),
        _buildInfoItem(Icons.email, "Email", clinicEmail),
        Divider(),
        _buildInfoItem(Icons.access_time, "Heures d'ouverture", clinicHours),
      ],
    );
  }

  Widget _buildInfoItem(IconData icon, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.teal.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: Colors.teal,
              size: 24,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditForm() {
    return Column(
      children: [
        _buildTextField("Nom de la Clinique", _nameController, Icons.business),
        SizedBox(height: 16),
        _buildTextField("Adresse", _addressController, Icons.place),
        SizedBox(height: 16),
        _buildTextField("Téléphone", _phoneController, Icons.phone),
        SizedBox(height: 16),
        _buildTextField("Email", _emailController, Icons.email),
        SizedBox(height: 16),
        _buildTextField("Heures d'ouverture", _hoursController, Icons.access_time),
      ],
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, IconData icon) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.teal),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.teal),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.teal, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}