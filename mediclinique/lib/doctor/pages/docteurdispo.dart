import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class DoctorAvailability {
  final DateTime date;
  final List<String> availableTimes;

  DoctorAvailability({required this.date, required this.availableTimes});
}

class AvailabilityCalendar extends StatefulWidget {
  @override
  _AvailabilityCalendarState createState() => _AvailabilityCalendarState();
}

class _AvailabilityCalendarState extends State<AvailabilityCalendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  
  List<DoctorAvailability> doctorAvailabilities = [
    DoctorAvailability(date: DateTime(2025, 3, 15), availableTimes: ['09:00 AM', '11:00 AM', '02:00 PM']),
    DoctorAvailability(date: DateTime(2025, 3, 16), availableTimes: ['10:00 AM', '12:00 PM']),
    DoctorAvailability(date: DateTime(2025, 3, 17), availableTimes: ['10:00 AM', '11:00 AM', '02:00 PM']),
    DoctorAvailability(date: DateTime(2025, 3, 20), availableTimes: ['09:00 AM', '11:00 AM', '02:00 PM']),
  ];

  DoctorAvailability getAvailability(DateTime date) {
    return doctorAvailabilities.firstWhere(
      (availability) => isSameDay(availability.date, date),
      orElse: () => DoctorAvailability(date: date, availableTimes: []),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Disponibilités du Docteur', style: TextStyle(fontSize: 18)),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime(2025, 1, 1),
            lastDay: DateTime(2025, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.blueAccent.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.blueAccent,
                shape: BoxShape.circle,
              ),
              weekendTextStyle: TextStyle(color: Colors.red),
            ),
            headerStyle: HeaderStyle(formatButtonVisible: false),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildAvailabilityList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvailabilityList() {
    DoctorAvailability availability = getAvailability(_selectedDay);
    
    if (availability.availableTimes.isEmpty) {
      return Center(
        child: Text('Aucune disponibilité',
            style: TextStyle(fontSize: 18, color: Colors.grey)),
      );
    }

    return ListView.builder(
      itemCount: availability.availableTimes.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            leading: Icon(Icons.schedule, color: Colors.blueAccent),
            title: Text(availability.availableTimes[index],
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            tileColor: Colors.blue.shade50,
          ),
        );
      },
    );
  }
}
