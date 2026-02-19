import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../features/alarm/controller/alarm_controller.dart';
import '../features/onboarding/controller/onboarding_controller.dart';
import '../features/location/controller/location_controller.dart';

class AppProviders {
  static final List<SingleChildWidget> providers = [
    ChangeNotifierProvider<OnboardingController>(
      create: (_) => OnboardingController(),
    ),
    ChangeNotifierProvider<LocationController>(
      create: (_) => LocationController(),
    ),
    ChangeNotifierProvider(create: (_) => AlarmController()), // ✅
  ];
}
