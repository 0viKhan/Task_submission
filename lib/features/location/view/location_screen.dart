import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../alarm/controller/alarm_controller.dart';
import '../../alarm/view/alarm_list_item.dart';
import '../../alarm/view/add_alarm_bottom_sheet.dart';
import '../controller/location_controller.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locationController = context.watch<LocationController>();
    final alarmController = context.watch<AlarmController>();

    return Scaffold(
      backgroundColor: const Color(0xFF0A2667),

      // ➕ ADD ALARM BUTTON
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF7B2FF7),
        child: const Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            backgroundColor: const Color(0xFF0A2667),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(30),
              ),
            ),
            builder: (_) => const AddAlarmBottomSheet(),
          );
        },
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Selected Location",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 20),

              // LOCATION BOX
              GestureDetector(
                onTap: locationController.fetchLocation,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.location_on,
                          color: Colors.white70),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          locationController.location == null
                              ? "Add your location"
                              : "Lat: ${locationController.location!.latitude.toStringAsFixed(4)}, "
                              "Lng: ${locationController.location!.longitude.toStringAsFixed(4)}",
                          style: const TextStyle(
                              color: Colors.white70),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 40),

              const Text(
                "Alarms",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 20),

              // 🔥 ALARM LIST
              Expanded(
                child: alarmController.alarms.isEmpty
                    ? const Center(
                  child: Text(
                    "No alarms added yet",
                    style:
                    TextStyle(color: Colors.white70),
                  ),
                )
                    : ListView.builder(
                  itemCount:
                  alarmController.alarms.length,
                  itemBuilder: (_, i) {
                    final alarm =
                    alarmController.alarms[i];

                    return AlarmListItem(
                      alarm: alarm,
                      onToggle: () =>
                          alarmController
                              .toggleAlarm(alarm.id),
                      onDelete: () =>
                          alarmController
                              .deleteAlarm(alarm.id),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
