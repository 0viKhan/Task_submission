import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/alarm_model.dart';

class AlarmListItem extends StatelessWidget {
  final AlarmModel alarm;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  const AlarmListItem({
    super.key,
    required this.alarm,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final time = DateFormat('h:mm a').format(alarm.dateTime);
    final date = DateFormat('EEE, d MMM yyyy')
        .format(alarm.dateTime);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          _TimeSection(time: time, date: date),

          const Spacer(),

          Switch(
            value: alarm.isEnabled,
            onChanged: (_) => onToggle(),
          ),

          IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.redAccent,
            ),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}

class _TimeSection extends StatelessWidget {
  final String time;
  final String date;

  const _TimeSection({
    required this.time,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          time,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        Text(
          date,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }
}