import 'package:flutter/foundation.dart';

import '../../../helpers/location_helper.dart';
import '../../../helpers/permission_helper.dart';
import '../model/user_location_model.dart';

class LocationController extends ChangeNotifier {
  UserLocationModel? _location;
  bool _isLoading = false;
  String? _error;

  UserLocationModel? get location => _location;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchLocation() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    final hasPermission =
    await PermissionHelper.requestLocation();

    if (!hasPermission) {
      _error = "Location permission denied";
      _isLoading = false;
      notifyListeners();
      return;
    }

    try {
      _location = await LocationHelper.getCurrentLocation();
    } catch (e) {
      _error = "Failed to fetch location";
    }

    _isLoading = false;
    notifyListeners();
  }
}
