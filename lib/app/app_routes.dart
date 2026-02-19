import 'package:flutter/material.dart';

import '../features/splash/view/splash_screen.dart';
import '../features/onboarding/view/onboarding_screen.dart';
import '../features/location/view/location_screen.dart';
import '../features/location/view/location_intro_screen.dart';

class AppRoutes {
  static const splash = '/';
  static const onboarding = '/onboarding';
  static const locationIntro = '/locationIntro';
  static const location = '/location';

  static final Map<String, WidgetBuilder> routes = {
    splash: (_) => const SplashScreen(),
    onboarding: (_) => const OnboardingScreen(),
    locationIntro: (_) => const LocationIntroScreen(),
    location: (_) => const LocationScreen(),
  };
}
