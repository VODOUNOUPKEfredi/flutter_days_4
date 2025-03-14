class Clinic {
  final String id;
  final String name;
  final String address;
  final List<String> specialties;
  final double rating;
  final double latitude;
  final double longitude;
  double distance; // Ajoutez cette ligne pour la distance

  Clinic({
    required this.id,
    required this.name,
    required this.address,
    required this.specialties,
    required this.rating,
    required this.latitude,
    required this.longitude,
    this.distance = 0.0, // Initialisez la distance à 0
  });

  factory Clinic.fromJson(Map<String, dynamic> json, String id) {
    return Clinic(
      id: id,
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      specialties: List<String>.from(json['specialties'] ?? []),
      rating: (json['rating'] ?? 0.0).toDouble(),
      latitude: (json['latitude'] ?? 0.0).toDouble(),
      longitude: (json['longitude'] ?? 0.0).toDouble(),
    );
  }
}
