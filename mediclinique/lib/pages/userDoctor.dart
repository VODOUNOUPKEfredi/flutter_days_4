import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorAvailability {
  final String doctorId;
  final DateTime date;
  final String startTime;
  final String endTime;

  DoctorAvailability({
    required this.doctorId,
    required this.date,
    required this.startTime,
    required this.endTime,
  });

  // Convert DoctorAvailability object to a Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'doctor_id': doctorId,
      'date': Timestamp.fromDate(date),
      'start_time': startTime,
      'end_time': endTime,
    };
  }

  // Convert a Map to DoctorAvailability object
  factory DoctorAvailability.fromMap(String id, Map<String, dynamic> map) {
    return DoctorAvailability(
      doctorId: map['doctor_id'] ?? '',
      date: (map['date'] as Timestamp).toDate(),
      startTime: map['start_time'] ?? '',
      endTime: map['end_time'] ?? '',
    );
  }
}
