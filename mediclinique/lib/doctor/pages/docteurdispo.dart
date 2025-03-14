import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Pour la gestion de la date

void main() {
  runApp(MaterialApp(
    home: AvailabilityCalendar(),
  ));
}
class DocteurDispoPage extends StatefulWidget {
  const DocteurDispoPage({super.key});

  @override
  State<DocteurDispoPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<DocteurDispoPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

// Classe représentant les disponibilités d'un docteur
class DoctorAvailability {
  final DateTime date;
  final List<String> availableTimes;

  DoctorAvailability({required this.date, required this.availableTimes});

  // Ajouter ou modifier la disponibilité pour une date
  void addAvailability(String time) {
    if (!availableTimes.contains(time)) {
      availableTimes.add(time);
    }
  }

  // Supprimer une disponibilité
  void removeAvailability(String time) {
    availableTimes.remove(time);
  }

  // Vérifier si une certaine heure est disponible
  bool isAvailableAt(String time) {
    return availableTimes.contains(time);
  }
}

// Classe principale pour afficher le calendrier
class AvailabilityCalendar extends StatefulWidget {
  @override
  _AvailabilityCalendarState createState() => _AvailabilityCalendarState();
}

class _AvailabilityCalendarState extends State<AvailabilityCalendar> {
  List<DoctorAvailability> doctorAvailabilities = [
    DoctorAvailability(
      date: DateTime(2025, 3, 15),
      availableTimes: ['09:00 AM', '11:00 AM', '02:00 PM'],
    ),
    DoctorAvailability(
      date: DateTime(2025, 3, 16),
      availableTimes: ['10:00 AM', '12:00 PM'],
    ),
    DoctorAvailability(
      date: DateTime(2025, 3, 17),
      availableTimes: ['10:00 AM', '11:00 AM', '02:00 PM'],
    ),DoctorAvailability(
      date: DateTime(2025, 3, 20),
      availableTimes: ['09:00 AM', '11:00 AM', '02:00 PM'],
    ),
    // Ajouter d'autres dates et disponibilités ici
  ];

  // Récupère les disponibilités pour une date donnée
  DoctorAvailability? getAvailability(DateTime date) {
    return doctorAvailabilities.firstWhere(
      (availability) => availability.date.year == date.year &&
                        availability.date.month == date.month &&
                        availability.date.day == date.day,
      orElse: () =>  DoctorAvailability(date: date, availableTimes: []),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendrier de Disponibilité du Docteur'),
      ),
      body: Column(
        children: [
          CalendarDatePicker(
            initialDate: DateTime.now(),
            firstDate: DateTime(2025, 1, 1),
            lastDate: DateTime(2025, 12, 31),
            onDateChanged: (date) {
              setState(() {});
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: doctorAvailabilities.length,
              itemBuilder: (context, index) {
                final availability = doctorAvailabilities[index];
                return Card(
                  child: ListTile(
                    title: Text(DateFormat.yMMMd().format(availability.date)),
                    subtitle: Text(availability.availableTimes.join(', ')),
                    tileColor: Colors.lightBlueAccent,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}



