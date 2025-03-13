class Clinic {
  final String id;
  final String name;
  final String address;
  final List<String> specialties;
  final double rating;
  final double latitude;
  final double longitude;
  final double distance;

  Clinic({
    required this.id,
    required this.name,
    required this.address,
    required this.specialties,
    required this.rating,
    required this.latitude,
    required this.longitude,
    required this.distance,
  });
}