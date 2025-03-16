import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart'; // Importation nécessaire
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorAvailability {
  final DateTime date;
  List<TimeSlot> timeSlots;

  DoctorAvailability({required this.date, required this.timeSlots});

  // Méthodes pour convertir en/depuis Firestore
  Map<String, dynamic> toMap() {
    return {
      'date': Timestamp.fromDate(date),
      'timeSlots': timeSlots.map((slot) => slot.toMap()).toList(),
    };
  }

  static DoctorAvailability fromMap(Map<String, dynamic> map) {
    return DoctorAvailability(
      date: (map['date'] as Timestamp).toDate(),
      timeSlots: List<TimeSlot>.from(
        (map['timeSlots'] as List).map((slot) => TimeSlot.fromMap(slot)),
      ),
    );
  }
}

class TimeSlot {
  final String time;
  bool isAvailable;

  TimeSlot({required this.time, this.isAvailable = false});

  Map<String, dynamic> toMap() {
    return {
      'time': time,
      'isAvailable': isAvailable,
    };
  }

  static TimeSlot fromMap(Map<String, dynamic> map) {
    return TimeSlot(
      time: map['time'],
      isAvailable: map['isAvailable'] ?? false,
    );
  }
}

class AvailabilityCalendar extends StatefulWidget {
  final String doctorId;
  
  const AvailabilityCalendar({Key? key, required this.doctorId}) : super(key: key);
  
  @override
  _AvailabilityCalendarState createState() => _AvailabilityCalendarState();
}

class _AvailabilityCalendarState extends State<AvailabilityCalendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  bool _isLoading = true;
  
  // Heures disponibles par défaut
  final List<String> _defaultTimeSlots = [
    '08:00', '09:00', '10:00', '11:00', '12:00',
    '14:00', '15:00', '16:00', '17:00', '18:00',
  ];
  
  // Map pour stocker toutes les disponibilités
  final Map<DateTime, List<TimeSlot>> _availabilityMap = {};
  
  @override
  void initState() {
    super.initState();
    // Initialiser les données de localisation avant de les utiliser
    initializeDateFormatting('fr_FR', null).then((_) {
      _loadAvailabilities();
    });
  }
  
  // Charge les disponibilités depuis la base de données
  Future<void> _loadAvailabilities() async {
    setState(() {
      _isLoading = true;
    });
    
    try {
      // Exemple avec Firebase Firestore
      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('doctors')
          .doc(widget.doctorId)
          .collection('availabilities')
          .get();
      
      for (var doc in snapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        final availability = DoctorAvailability.fromMap(data);
        
        // Formatez la date pour la clé du Map
        final dateKey = DateTime(
          availability.date.year,
          availability.date.month,
          availability.date.day,
        );
        
        _availabilityMap[dateKey] = availability.timeSlots;
      }
    } catch (e) {
      print('Erreur lors du chargement des disponibilités: $e');
      // Gérer l'erreur (afficher un message, etc.)
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
  
  // Enregistre les disponibilités dans la base de données
  Future<void> _saveAvailability(DateTime date, List<TimeSlot> timeSlots) async {
    try {
      final dateKey = DateTime(date.year, date.month, date.day);
      
      // Enregistrer dans la base de données
      await FirebaseFirestore.instance
          .collection('doctors')
          .doc(widget.doctorId)
          .collection('availabilities')
          .doc(DateFormat('yyyy-MM-dd').format(date))
          .set(DoctorAvailability(date: date, timeSlots: timeSlots).toMap());
      
      // Mettre à jour l'état local
      setState(() {
        _availabilityMap[dateKey] = timeSlots;
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Disponibilités enregistrées avec succès'))
      );
    } catch (e) {
      print('Erreur lors de l\'enregistrement des disponibilités: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors de l\'enregistrement des disponibilités'))
      );
    }
  }
  
  // Récupère les créneaux horaires pour une date donnée
  List<TimeSlot> _getTimeSlotsForDay(DateTime date) {
    final dateKey = DateTime(date.year, date.month, date.day);
    
    if (_availabilityMap.containsKey(dateKey)) {
      return _availabilityMap[dateKey]!;
    } else {
      // Créer des créneaux par défaut s'il n'y en a pas
      return _defaultTimeSlots.map((time) => 
        TimeSlot(time: time, isAvailable: false)
      ).toList();
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Disponibilités du Docteur', style: TextStyle(fontSize: 18)),
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              // Enregistrer les disponibilités du jour sélectionné
              _saveAvailability(_selectedDay, _getTimeSlotsForDay(_selectedDay));
            },
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                TableCalendar(
                  firstDay: DateTime.now().subtract(Duration(days: 1)),
                  lastDay: DateTime.now().add(Duration(days: 365)),
                  focusedDay: _focusedDay,
                  calendarFormat: _calendarFormat,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
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
                  calendarStyle: CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: Colors.purple.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: BoxDecoration(
                      color: Colors.purple,
                      shape: BoxShape.circle,
                    ),
                    weekendTextStyle: TextStyle(color: Colors.red),
                  ),
                  headerStyle: HeaderStyle(
                    formatButtonVisible: true,
                    titleCentered: true,
                  ),
                  calendarBuilders: CalendarBuilders(
                    markerBuilder: (context, date, events) {
                      final dateKey = DateTime(date.year, date.month, date.day);
                      final hasAvailability = _availabilityMap[dateKey]?.any((slot) => slot.isAvailable) ?? false;
                      
                      return hasAvailability
                          ? Positioned(
                              right: 1,
                              bottom: 1,
                              child: Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.green,
                                ),
                              ),
                            )
                          : Container();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Disponibilités du ${DateFormat('d MMMM yyyy', 'fr_FR').format(_selectedDay)}',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Inverser toutes les disponibilités du jour
                          setState(() {
                            final dateKey = DateTime(_selectedDay.year, _selectedDay.month, _selectedDay.day);
                            final slots = _getTimeSlotsForDay(_selectedDay);
                            final allAvailable = slots.every((slot) => slot.isAvailable);
                            
                            for (var slot in slots) {
                              slot.isAvailable = !allAvailable;
                            }
                            
                            _availabilityMap[dateKey] = slots;
                          });
                        },
                        child: Text(
                          'Tout ${_getTimeSlotsForDay(_selectedDay).every((slot) => slot.isAvailable) ? 'désélectionner' : 'sélectionner'}'
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: _buildAvailabilityList(),
                ),
              ],
            ),
    );
  }

  Widget _buildAvailabilityList() {
    final timeSlots = _getTimeSlotsForDay(_selectedDay);
    
    return ListView.builder(
      itemCount: timeSlots.length,
      itemBuilder: (context, index) {
        final slot = timeSlots[index];
        
        return Card(
          elevation: 2,
          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: CheckboxListTile(
            title: Text(slot.time, style: TextStyle(fontSize: 16)),
            value: slot.isAvailable,
            onChanged: (value) {
              setState(() {
                slot.isAvailable = value ?? false;
                
                // Mettre à jour la map
                final dateKey = DateTime(_selectedDay.year, _selectedDay.month, _selectedDay.day);
                _availabilityMap[dateKey] = timeSlots;
              });
            },
            activeColor: Colors.purple,
            checkColor: Colors.white,
            secondary: Icon(
              Icons.schedule,
              color: slot.isAvailable ? Colors.purple : Colors.grey,
            ),
          ),
        );
      },
    );
  }
}