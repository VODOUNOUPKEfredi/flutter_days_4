import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PharmaciesScreen extends StatefulWidget {
  const PharmaciesScreen({super.key});

  @override
  State<PharmaciesScreen> createState() => _PharmaciesScreenState();
}

class _PharmaciesScreenState extends State<PharmaciesScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = true;
  List<Pharmacy> _nearbyPharmaciesList = [];
  List<Pharmacy> _filteredPharmaciesList = [];
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
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'L\'accès à la localisation est nécessaire pour afficher les pharmacies à proximité')),
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
        _loadNearbyPharmaciesList();
      });
    } catch (e) {
      print('Error getting location: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _loadNearbyPharmaciesList() async {
    setState(() {
      _isLoading = true;
    });

    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('pharmacies').get();

      _nearbyPharmaciesList = querySnapshot.docs.map((doc) {
        return Pharmacy.fromJson(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();

      if (_currentPosition != null) {
        for (var pharmacy in _nearbyPharmaciesList) {
          pharmacy.distance = Geolocator.distanceBetween(
                _currentPosition!.latitude,
                _currentPosition!.longitude,
                pharmacy.latitude,
                pharmacy.longitude,
              ) /
              1000;
        }

        _nearbyPharmaciesList.sort((a, b) => a.distance.compareTo(b.distance));
      }

      _filteredPharmaciesList = List.from(_nearbyPharmaciesList);
    } catch (e) {
      print('Error loading pharmacies: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Erreur lors du chargement des pharmacies: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _filterPharmacies(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredPharmaciesList = List.from(_nearbyPharmaciesList);
      } else {
        _filteredPharmaciesList = _nearbyPharmaciesList
            .where((pharmacy) =>
                pharmacy.name.toLowerCase().contains(query.toLowerCase()) ||
                pharmacy.services.any((service) =>
                    service.toLowerCase().contains(query.toLowerCase())))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pharmacies à proximité',
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
                hintText: 'Rechercher une pharmacie ou service',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
              onChanged: _filterPharmacies,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Pharmacies à proximité : ${_filteredPharmaciesList.length}',
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
                        _filteredPharmaciesList
                            .sort((a, b) => a.distance.compareTo(b.distance));
                      } else if (value == 'rating') {
                        _filteredPharmaciesList
                            .sort((a, b) => b.rating.compareTo(a.rating));
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
                : _filteredPharmaciesList.isEmpty
                    ? const Center(
                        child: Text('Aucune pharmacie trouvée'),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: _filteredPharmaciesList.length,
                        itemBuilder: (context, index) {
                          final pharmacy = _filteredPharmaciesList[index];
                          return PharmacyCard(pharmacy: pharmacy);
                        },
                      ),
          ),
        ],
      ),
    );
  }
}

class Pharmacy {
  final String id;
  final String name;
  final String address;
  final List<String> services;
  final double rating;
  final double latitude;
  final double longitude;
  final bool isOpen24h;
  final bool isOnDuty;
  double distance;

  Pharmacy({
    required this.id,
    required this.name,
    required this.address,
    required this.services,
    required this.rating,
    required this.latitude,
    required this.longitude,
    required this.isOpen24h,
    required this.isOnDuty,
    this.distance = 0.0,
  });

  factory Pharmacy.fromJson(Map<String, dynamic> json, String id) {
    return Pharmacy(
      id: id,
      name: json['nom'] ?? '',
      address: json['address'] ?? '',
      services: List<String>.from(json['services'] ?? []),
      rating: (json['rating'] ?? 0.0).toDouble(),
      latitude: (json['latitude'] ?? 0.0).toDouble(),
      longitude: (json['longitude'] ?? 0.0).toDouble(),
      isOpen24h: json['isOpen24h'] ?? false,
      isOnDuty: json['isOnDuty'] ?? false,
    );
  }
}

class PharmacyCard extends StatelessWidget {
  final Pharmacy pharmacy;

  const PharmacyCard({super.key, required this.pharmacy});

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
                    pharmacy.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        pharmacy.rating.toString(),
                        style: TextStyle(
                          color: Colors.green[800],
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
                    pharmacy.address,
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
                  '${pharmacy.distance.toStringAsFixed(1)} km',
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            if (pharmacy.isOpen24h || pharmacy.isOnDuty)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  children: [
                    if (pharmacy.isOpen24h)
                      Container(
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.blue[100],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.access_time, color: Colors.blue[800], size: 12),
                            const SizedBox(width: 4),
                            Text(
                              'Ouvert 24/7',
                              style: TextStyle(
                                color: Colors.blue[800],
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (pharmacy.isOnDuty)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.red[100],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.local_hospital, color: Colors.red[800], size: 12),
                            const SizedBox(width: 4),
                            Text(
                              'De garde',
                              style: TextStyle(
                                color: Colors.red[800],
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: pharmacy.services.map((service) {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    service,
                    style: TextStyle(
                      color: Colors.green[800],
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
                      // Navigate to pharmacy details
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
                    icon: const Icon(Icons.directions),
                    label: const Text('Itinéraire'),
                    onPressed: () {
                      // Navigate to directions
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green,
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