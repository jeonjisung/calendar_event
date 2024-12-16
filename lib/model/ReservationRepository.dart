import 'package:cloud_firestore/cloud_firestore.dart';

class ReservationRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<DateTime, List<Map<String, dynamic>>>> fetchReservations() async {
    final snapshot = await _firestore.collection('reservations').get();
    Map<DateTime, List<Map<String, dynamic>>> reservations = {};
    for (var doc in snapshot.docs) {
      DateTime date = DateTime.parse(doc.id);
      reservations[date] = [
        {'type': doc['type'], 'name': doc['name'], 'time': doc['time']}
      ];
    }
    return reservations;
  }

  Future<void> saveReservation(DateTime date, String type, String name, String time) async {
    await _firestore.collection('reservations').doc('${date.year}-${date.month}-${date.day}').set({
      'type': type,
      'name': name,
      'time': time,
    });
  }
}