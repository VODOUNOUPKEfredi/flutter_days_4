
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MedicalSchedulerApp());
}

class MedicalSchedulerApp extends StatelessWidget {
  const MedicalSchedulerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Disponibilité des Médecins',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const DoctorSchedulePage(),
    );
  }
}

class Doctor {
  final String id;
  final String name;
  final String specialty;
  final Color color;

  Doctor({
    required this.id, 
    required this.name, 
    required this.specialty, 
    required this.color
  });
}

class Availability {
  final String id;
  final String doctorId;
  final DateTime start;
  final DateTime end;
  final String note;

  Availability({
    required this.id, 
    required this.doctorId, 
    required this.start, 
    required this.end, 
    this.note = ''
  });
}

class DoctorSchedulePage extends StatefulWidget {
  const DoctorSchedulePage({Key? key}) : super(key: key);

  @override
  _DoctorSchedulePageState createState() => _DoctorSchedulePageState();
}

class _DoctorSchedulePageState extends State<DoctorSchedulePage> {
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<String, Doctor> doctors = {};
  Map<DateTime, List<Availability>> availabilities = {};

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    
    // Initialisation avec des médecins d'exemple
    doctors = {
      'doc1': Doctor(id: 'doc1', name: 'Dr. Martin', specialty: 'Cardiologie', color: Colors.red.shade300),
      'doc2': Doctor(id: 'doc2', name: 'Dr. Dupont', specialty: 'Pédiatrie', color: Colors.blue.shade300),
      'doc3': Doctor(id: 'doc3', name: 'Dr. Dubois', specialty: 'Dermatologie', color: Colors.green.shade300),
      'doc4': Doctor(id: 'doc4', name: 'Dr. Bernard', specialty: 'Neurologie', color: Colors.purple.shade300),
    };
    
    // Initialisation avec des disponibilités d'exemple
    final today = DateTime.now();
    final tomorrow = today.add(const Duration(days: 1));
    
    availabilities = {
      DateTime(today.year, today.month, today.day): [
        Availability(
          id: 'avail1', 
          doctorId: 'doc1', 
          start: DateTime(today.year, today.month, today.day, 9, 0),
          end: DateTime(today.year, today.month, today.day, 12, 0),
        ),
        Availability(
          id: 'avail2', 
          doctorId: 'doc2', 
          start: DateTime(today.year, today.month, today.day, 14, 0),
          end: DateTime(today.year, today.month, today.day, 17, 0),
        ),
      ],
      DateTime(tomorrow.year, tomorrow.month, tomorrow.day): [
        Availability(
          id: 'avail3', 
          doctorId: 'doc3', 
          start: DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 10, 0),
          end: DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 15, 0),
        ),
        Availability(
          id: 'avail4', 
          doctorId: 'doc1', 
          start: DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 16, 0),
          end: DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 18, 0),
        ),
      ],
    };
  }

  List<Availability> _getAvailabilitiesForDay(DateTime day) {
    final normalizedDay = DateTime(day.year, day.month, day.day);
    return availabilities[normalizedDay] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Disponibilité des Médecins'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add),
            onPressed: () => _showAddDoctorDialog(),
          ),
        ],
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2023, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            eventLoader: (day) {
              return _getAvailabilitiesForDay(day);
            },
            calendarStyle: const CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.deepPurple,
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: _buildAvailabilityList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          if (_selectedDay != null) {
            _showAddAvailabilityDialog(_selectedDay!);
          }
        },
      ),
    );
  }

  Widget _buildAvailabilityList() {
    if (_selectedDay == null) {
      return const Center(child: Text('Sélectionnez une date'));
    }

    final availabilitiesForDay = _getAvailabilitiesForDay(_selectedDay!);

    if (availabilitiesForDay.isEmpty) {
      return const Center(child: Text('Aucune disponibilité pour cette date'));
    }

    return ListView.builder(
      itemCount: availabilitiesForDay.length,
      itemBuilder: (context, index) {
        final availability = availabilitiesForDay[index];
        final doctor = doctors[availability.doctorId];
        
        if (doctor == null) return const SizedBox();
        
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: doctor.color,
              child: Text(doctor.name.substring(0, 1)),
            ),
            title: Text(doctor.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(doctor.specialty),
                Text(
                  '${DateFormat('HH:mm').format(availability.start)} - ${DateFormat('HH:mm').format(availability.end)}',
                ),
                if (availability.note.isNotEmpty) Text('Note: ${availability.note}'),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: () => _showEditAvailabilityDialog(availability),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _deleteAvailability(availability),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showAddDoctorDialog() {
    final nameController = TextEditingController();
    final specialtyController = TextEditingController();
    Color selectedColor = Colors.blue;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ajouter un médecin'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Nom'),
              ),
              TextField(
                controller: specialtyController,
                decoration: const InputDecoration(labelText: 'Spécialité'),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                children: [
                  Colors.red,
                  Colors.pink,
                  Colors.purple,
                  Colors.deepPurple,
                  Colors.indigo,
                  Colors.blue,
                  Colors.lightBlue,
                  Colors.cyan,
                  Colors.teal,
                  Colors.green,
                  Colors.lightGreen,
                  Colors.lime,
                  Colors.yellow,
                  Colors.amber,
                  Colors.orange,
                  Colors.deepOrange,
                ].map((color) {
                  return GestureDetector(
                    onTap: () {
                      selectedColor = color;
                      Navigator.pop(context);
                      _showAddDoctorDialog();
                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: selectedColor == color
                              ? Colors.black
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              if (nameController.text.isNotEmpty && specialtyController.text.isNotEmpty) {
                setState(() {
                  final newId = 'doc${doctors.length + 1}';
                  doctors[newId] = Doctor(
                    id: newId,
                    name: nameController.text,
                    specialty: specialtyController.text,
                    color: selectedColor,
                  );
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Ajouter'),
          ),
        ],
      ),
    );
  }

  void _showAddAvailabilityDialog(DateTime day) {
    if (doctors.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez d\'abord ajouter un médecin')),
      );
      return;
    }

    String selectedDoctorId = doctors.values.first.id;
    final startTime = TimeOfDay(hour: 9, minute: 0);
    final endTime = TimeOfDay(hour: 17, minute: 0);
    final noteController = TextEditingController();

    _showAvailabilityDialog(
      title: 'Ajouter une disponibilité',
      doctorId: selectedDoctorId,
      start: startTime,
      end: endTime,
      noteController: noteController,
      onSave: (doctorId, start, end, note) {
        final startDateTime = DateTime(
          day.year, day.month, day.day, start.hour, start.minute,
        );
        final endDateTime = DateTime(
          day.year, day.month, day.day, end.hour, end.minute,
        );

        setState(() {
          final normalizedDay = DateTime(day.year, day.month, day.day);
          final newAvailability = Availability(
            id: 'avail${DateTime.now().millisecondsSinceEpoch}',
            doctorId: doctorId,
            start: startDateTime,
            end: endDateTime,
            note: note,
          );

          if (availabilities.containsKey(normalizedDay)) {
            availabilities[normalizedDay]!.add(newAvailability);
          } else {
            availabilities[normalizedDay] = [newAvailability];
          }
        });
      },
    );
  }

  void _showEditAvailabilityDialog(Availability availability) {
    final startTime = TimeOfDay(hour: availability.start.hour, minute: availability.start.minute);
    final endTime = TimeOfDay(hour: availability.end.hour, minute: availability.end.minute);
    final noteController = TextEditingController(text: availability.note);

    _showAvailabilityDialog(
      title: 'Modifier la disponibilité',
      doctorId: availability.doctorId,
      start: startTime,
      end: endTime,
      noteController: noteController,
      onSave: (doctorId, start, end, note) {
        final startDateTime = DateTime(
          availability.start.year,
          availability.start.month,
          availability.start.day,
          start.hour,
          start.minute,
        );
        final endDateTime = DateTime(
          availability.end.year,
          availability.end.month,
          availability.end.day,
          end.hour,
          end.minute,
        );

        setState(() {
          final normalizedDay = DateTime(
            availability.start.year,
            availability.start.month,
            availability.start.day,
          );
          
          final index = availabilities[normalizedDay]!.indexWhere((a) => a.id == availability.id);
          
          if (index != -1) {
            availabilities[normalizedDay]![index] = Availability(
              id: availability.id,
              doctorId: doctorId,
              start: startDateTime,
              end: endDateTime,
              note: note,
            );
          }
        });
      },
    );
  }

  void _showAvailabilityDialog({
    required String title,
    required String doctorId,
    required TimeOfDay start,
    required TimeOfDay end,
    required TextEditingController noteController,
    required Function(String, TimeOfDay, TimeOfDay, String) onSave,
  }) {
    String selectedDoctorId = doctorId;
    TimeOfDay startTime = start;
    TimeOfDay endTime = end;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButton<String>(
                    isExpanded: true,
                    value: selectedDoctorId,
                    items: doctors.values.map((doctor) {
                      return DropdownMenuItem<String>(
                        value: doctor.id,
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: doctor.color,
                              radius: 12,
                              child: Text(doctor.name.substring(0, 1), style: const TextStyle(fontSize: 10, color: Colors.white)),
                            ),
                            const SizedBox(width: 8),
                            Text(doctor.name),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          selectedDoctorId = value;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          title: const Text('Début'),
                          subtitle: Text('${startTime.hour}:${startTime.minute.toString().padLeft(2, '0')}'),
                          onTap: () async {
                            final time = await showTimePicker(
                              context: context,
                              initialTime: startTime,
                            );
                            if (time != null) {
                              setState(() {
                                startTime = time;
                              });
                            }
                          },
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          title: const Text('Fin'),
                          subtitle: Text('${endTime.hour}:${endTime.minute.toString().padLeft(2, '0')}'),
                          onTap: () async {
                            final time = await showTimePicker(
                              context: context,
                              initialTime: endTime,
                            );
                            if (time != null) {
                              setState(() {
                                endTime = time;
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  TextField(
                    controller: noteController,
                    decoration: const InputDecoration(labelText: 'Note (optionnelle)'),
                    maxLines: 2,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Annuler'),
              ),
              TextButton(
                onPressed: () {
                  // Vérification que l'heure de fin est après l'heure de début
                  final startMinutes = startTime.hour * 60 + startTime.minute;
                  final endMinutes = endTime.hour * 60 + endTime.minute;
                  
                  if (endMinutes <= startMinutes) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('L\'heure de fin doit être après l\'heure de début')),
                    );
                    return;
                  }
                  
                  onSave(selectedDoctorId, startTime, endTime, noteController.text);
                  Navigator.pop(context);
                },
                child: const Text('Enregistrer'),
              ),
            ],
          );
        },
      ),
    );
  }

  void _deleteAvailability(Availability availability) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Supprimer la disponibilité'),
        content: const Text('Êtes-vous sûr de vouloir supprimer cette disponibilité ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                final normalizedDay = DateTime(
                  availability.start.year,
                  availability.start.month,
                  availability.start.day,
                );
                
                availabilities[normalizedDay]!.removeWhere((a) => a.id == availability.id);
                
                // Si la liste est vide, on supprime la clé
                if (availabilities[normalizedDay]!.isEmpty) {
                  availabilities.remove(normalizedDay);
                }
              });
              Navigator.pop(context);
            },
            child: const Text('Supprimer'),
          ),
        ],
      ),
    );
  }
}