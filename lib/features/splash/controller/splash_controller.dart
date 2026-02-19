import 'package:flutter/material.dart';

class SplashController {
  static Future<void> navigate(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2));

    // later shared pref check hobe
    Navigator.pushReplacementNamed(context, '/onboarding');
  }
}
