import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class MapViewportNotifier extends ChangeNotifier {
  bool _hasLocationPermission = false;
  bool get hasLocationPermission => _hasLocationPermission;

  /// Call this when the Map View initializes
  Future<void> initializePermissions() async {
    final status = await Permission.locationWhenInUse.status;

    if (status.isGranted) {
      _hasLocationPermission = true;
      notifyListeners();
    } else if (status.isDenied) {
      final result = await Permission.locationWhenInUse.request();
      _hasLocationPermission = result.isGranted;
      notifyListeners();
    } else if (status.isPermanentlyDenied) {
      // Guide user to OS settings if permanently denied
      await openAppSettings();
    }
  }
}
