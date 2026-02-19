import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../services/notification_service.dart';
import '../model/alarm_model.dart';

class AlarmController extends ChangeNotifier {
  final List<AlarmModel> _alarms = [];
  List<AlarmModel> get alarms => List.unmodifiable(_alarms);

  final NotificationService _notificationService =
  NotificationService();

  static const _storageKey = 'alarms';

  AlarmController() {
    _loadAlarms();
  }

  // ================= LOAD =================

  Future<void> _loadAlarms() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList(_storageKey);

    if (data == null) return;

    _alarms.clear();

    for (var item in data) {
      final alarm =
      AlarmModel.fromJson(jsonDecode(item));

      _alarms.add(alarm);

      // 🔥 Reschedule only future enabled alarms
      if (alarm.isEnabled &&
          alarm.dateTime.isAfter(DateTime.now())) {
        await _notificationService.scheduleAlarm(
          id: alarm.id,
          dateTime: alarm.dateTime,
        );
      }
    }

    notifyListeners();
  }

  // ================= SAVE =================

  Future<void> _saveAlarms() async {
    final prefs = await SharedPreferences.getInstance();

    final data =
    _alarms.map((a) => jsonEncode(a.toJson())).toList();

    await prefs.setStringList(_storageKey, data);
  }

  // ================= ADD =================

  Future<void> addAlarm(DateTime dateTime) async {
    // 🔥 Ensure future time
    if (dateTime.isBefore(DateTime.now())) {
      dateTime =
          dateTime.add(const Duration(days: 1));
    }

    final alarm = AlarmModel(
      id: DateTime.now().millisecondsSinceEpoch,
      dateTime: dateTime,
      isEnabled: true,
    );

    _alarms.add(alarm);

    await _notificationService.scheduleAlarm(
      id: alarm.id,
      dateTime: alarm.dateTime,
    );

    await _saveAlarms();
    notifyListeners();
  }

  // ================= TOGGLE =================

  Future<void> toggleAlarm(int id) async {
    final index =
    _alarms.indexWhere((a) => a.id == id);

    if (index == -1) return;

    final alarm = _alarms[index];

    alarm.isEnabled = !alarm.isEnabled;

    if (alarm.isEnabled &&
        alarm.dateTime.isAfter(DateTime.now())) {
      await _notificationService.scheduleAlarm(
        id: alarm.id,
        dateTime: alarm.dateTime,
      );
    } else {
      await _notificationService.cancelAlarm(id);
    }

    await _saveAlarms();
    notifyListeners();
  }

  // ================= DELETE =================

  Future<void> deleteAlarm(int id) async {
    _alarms.removeWhere((a) => a.id == id);

    await _notificationService.cancelAlarm(id);
    await _saveAlarms();
    notifyListeners();
  }
}