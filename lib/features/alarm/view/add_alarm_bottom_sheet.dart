import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/alarm_controller.dart';

class AddAlarmBottomSheet extends StatelessWidget {
  const AddAlarmBottomSheet({super.key});

  Future<DateTime?> _pickTime(BuildContext context) async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time == null) return null;

    final now = DateTime.now();

    DateTime scheduled = DateTime(
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );

    // 🔥 Ensure future time
    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }

    return scheduled;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: ElevatedButton(
            onPressed: () async {
              final TimeOfDay? pickedTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );

              if (pickedTime == null) return;

              final now = DateTime.now();

              DateTime scheduled = DateTime(
                now.year,
                now.month,
                now.day,
                pickedTime.hour,
                pickedTime.minute,
              );

              if (scheduled.isBefore(now)) {
                scheduled = scheduled.add(const Duration(days: 1));
              }

              context.read<AlarmController>().addAlarm(scheduled);
            },
          child: const Text("Pick Time"),
        ),
      ),
    );
  }
}