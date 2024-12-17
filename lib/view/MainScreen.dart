import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:calendar_event/viewmodel/ReservationViewModel.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ReservationViewModel()..fetchReservations(),
      child: Scaffold(
        appBar: AppBar(title: Text('연습실 예약')),
        body: Consumer<ReservationViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading) {
              return Center(child: CircularProgressIndicator());
            }
            return TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: DateTime.now(),
              calendarFormat: CalendarFormat.month,
              selectedDayPredicate: (day) {
                final selectedDate = viewModel.reservations.keys.firstWhere(
                  (d) => isSameDay(d, day),
                  orElse: () => DateTime.now(), // null이 반환될 수 있는 경우 처리
                );
                return isSameDay(selectedDate, day);
              },
              onDaySelected: (selectedDay, _) {
                _showReservationDialog(context, selectedDay, viewModel);
              },
              eventLoader: (day) => viewModel.reservations[day] ?? [],
            );
          },
        ),
      ),
    );
  }

  void _showReservationDialog(BuildContext context, DateTime selectedDay,
      ReservationViewModel viewModel) {
    TextEditingController nameController = TextEditingController();
    TextEditingController timeController = TextEditingController();
    String roomType = 'practice';

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
            '${selectedDay.year}-${selectedDay.month}-${selectedDay.day} 예약'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButton<String>(
              value: roomType,
              items: [
                DropdownMenuItem(value: 'practice', child: Text('연습실')),
                DropdownMenuItem(value: 'recording', child: Text('녹음실')),
              ],
              onChanged: (value) {
                roomType = value!;
              },
            ),
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: '이름'),
            ),
            TextField(
              controller: timeController,
              decoration: InputDecoration(labelText: '시간'),
            ),
          ],
        ),
        actions: [
          TextButton(
            child: Text('취소'),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: Text('저장'),
            onPressed: () async {
              await viewModel.saveReservation(
                selectedDay,
                roomType,
                nameController.text,
                timeController.text,
              );
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
