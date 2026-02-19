import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/app_routes.dart';
import '../controller/location_controller.dart';
import 'location_screen.dart';

class LocationIntroScreen extends StatelessWidget {
  const LocationIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.read<LocationController>();

    return Scaffold(
      backgroundColor: const Color(0xFF0A2667),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [

              const SizedBox(height: 40),

              const Text(
                "Welcome! Your Smart\nTravel Alarm",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 16),

              const Text(
                "Stay on schedule and enjoy every moment of your journey.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),

              const SizedBox(height: 40),

              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  "assets/images/travel.jpg", // তোমার image path দাও
                  height: 220,
                  fit: BoxFit.cover,
                ),
              ),

              const Spacer(),

              /// Use Current Location Button
              OutlinedButton(
                onPressed: () async {
                  await c.fetchLocation();
                  onPressed: () async {
                    await c.fetchLocation();
                    Navigator.pushNamed(
                      context,
                      AppRoutes.location,
                    );
                  };

                },
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 55),
                  side: const BorderSide(color: Colors.white38),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Use Current Location",
                  style: TextStyle(color: Colors.white),
                ),
              ),

              const SizedBox(height: 16),

              /// Home Button
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.location,
                  );
                },

                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 55),
                  backgroundColor: const Color(0xFF7B2FF7),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text("Home"),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
