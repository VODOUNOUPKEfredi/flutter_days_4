import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:mediclic/pages/models.dart';

class CliniquesScreen extends StatefulWidget {
  const CliniquesScreen({super.key});

  @override
  State<CliniquesScreen> createState() => _CliniquesScreenState();
}

class _CliniquesScreenState extends State<CliniquesScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = true;
  List<Clinic> _nearbyClinicsList = [];
  List<Clinic> _filteredClinicsList = [];
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
  }

  Future<void> _requestLocationPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      _getCurrentLocation();
    } else {
      setState(() {
        _isLoading = false;
        // Load default clinics if location is not available
        _loadMockClinics();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('L\'accès à la localisation est nécessaire pour afficher les cliniques à proximité')),
      );
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _currentPosition = position;
        _loadNearbyClinicsList();
      });
    } catch (e) {
      print('Error getting location: $e');
      setState(() {
        _isLoading = false;
        _loadMockClinics();
      });
    }
  }

  void _loadNearbyClinicsList() {
    // In a real app, you would fetch clinics from an API based on location
    // For now, we'll use mock data
    _loadMockClinics();
    
    // Sort by distance if we have location
    if (_currentPosition != null) {
      _nearbyClinicsList.sort((a, b) {
        double distanceA = Geolocator.distanceBetween(
          _currentPosition!.latitude,
          _currentPosition!.longitude,
          a.latitude,
          a.longitude,
        );
        double distanceB = Geolocator.distanceBetween(
          _currentPosition!.latitude,
          _currentPosition!.longitude,
          b.latitude,
          b.longitude,
        );
        return distanceA.compareTo(distanceB);
      });
    }
    
    _filteredClinicsList = List.from(_nearbyClinicsList);
    setState(() {
      _isLoading = false;
    });
  }
  
  void _loadMockClinics() {
    _nearbyClinicsList = [
      Clinic(
        id: "1",
        name: "Clinique Médiale",
        address: "23 Avenue de la République, Paris",
        specialties: ["Cardiologie", "Pédiatrie", "Dermatologie"],
        rating: 4.7,
        latitude: 48.8566,
        longitude: 2.3522,
        distance: 1.2,
      ),
      Clinic(
        id: "2",
        name: "Centre Médical Saint-Paul",
        address: "8 Rue Saint-Paul, Paris",
        specialties: ["Orthopédie", "Radiologie", "Neurologie"],
        rating: 4.5,
        latitude: 48.8546,
        longitude: 2.3600,
        distance: 2.4,
      ),
      Clinic(
        id: "3",
        name: "Polyclinique des Alpes",
        address: "45 Boulevard de l'Hôpital, Paris",
        specialties: ["Gynécologie", "Ophtalmologie", "ORL"],
        rating: 4.2,
        latitude: 48.8396,
        longitude: 2.3622,
        distance: 3.5,
      ),
      Clinic(
        id: "4",
        name: "Clinique Lafayette",
        address: "10 Rue Lafayette, Paris",
        specialties: ["Médecine générale", "Psychiatrie", "Kinésithérapie"],
        rating: 4.8,
        latitude: 48.8737,
        longitude: 2.3414,
        distance: 1.8,
      ),
    ];
  }
  
  void _filterClinics(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredClinicsList = List.from(_nearbyClinicsList);
      } else {
        _filteredClinicsList = _nearbyClinicsList
            .where((clinic) =>
                clinic.name.toLowerCase().contains(query.toLowerCase()) ||
                clinic.specialties.any((specialty) =>
                    specialty.toLowerCase().contains(query.toLowerCase())))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cliniques à proximité', 
          style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Rechercher une clinique ou spécialité',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
              onChanged: _filterClinics,
            ),
          ),
          // Google Maps container removed to fix the error
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Cliniques à proximité (${_filteredClinicsList.length})',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                DropdownButton<String>(
                  hint: const Text('Trier par'),
                  items: const [
                    DropdownMenuItem(
                      value: 'distance',
                      child: Text('Distance'),
                    ),
                    DropdownMenuItem(
                      value: 'rating',
                      child: Text('Évaluation'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      if (value == 'distance') {
                        _filteredClinicsList.sort((a, b) => a.distance.compareTo(b.distance));
                      } else if (value == 'rating') {
                        _filteredClinicsList.sort((a, b) => b.rating.compareTo(a.rating));
                      }
                    });
                  },
                )
              ],
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredClinicsList.isEmpty
                    ? const Center(
                        child: Text('Aucune clinique trouvée'),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: _filteredClinicsList.length,
                        itemBuilder: (context, index) {
                          final clinic = _filteredClinicsList[index];
                          return ClinicCard(clinic: clinic);
                        },
                      ),
          ),
        ],
      ),
    );
  }
}

class ClinicCard extends StatelessWidget {
  final Clinic clinic;

  const ClinicCard({super.key, required this.clinic});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    clinic.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.purple[50],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        clinic.rating.toString(),
                        style: TextStyle(
                          color: Colors.purple[800],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.location_on, color: Colors.grey, size: 16),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    clinic.address,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.directions_walk, color: Colors.grey, size: 16),
                const SizedBox(width: 4),
                Text(
                  '${clinic.distance.toStringAsFixed(1)} km',
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: clinic.specialties.map((specialty) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    specialty,
                    style: TextStyle(
                      color: Colors.blue[800],
                      fontSize: 12,
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.info_outline),
                    label: const Text('Détails'),
                    onPressed: () {
                      // Navigate to clinic details
                    },
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.calendar_today),
                    label: const Text('Rendez-vous'),
                    onPressed: () {
                      // Navigate to appointment booking
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.purple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

