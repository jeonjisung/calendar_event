import 'package:flutter/material.dart';
import 'package:calendar_event/model/ReservationRepository.dart';

class ReservationViewModel extends ChangeNotifier {
  final ReservationRepository _repository = ReservationRepository();
  Map<DateTime, List<Map<String, dynamic>>> reservations = {};
  bool isLoading = false;

  Future<void> fetchReservations() async {
    isLoading = true;
    notifyListeners();
    try {
      reservations = await _repository.fetchReservations();
    } catch (e) {
      print('Error fetching reservations: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> saveReservation(DateTime date, String type, String name, String time) async {
    await _repository.saveReservation(date, type, name, time);
    await fetchReservations(); // 저장 후 새로고침
  }
}