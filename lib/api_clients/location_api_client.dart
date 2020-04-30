import 'package:location/location.dart';

import 'package:flutterweatherapplication/Models/current_location.dart';

class LocationApiClient {
  static Location locator = Location();

  Future<CurrentLocation> getLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await locator.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await locator.requestService();
      if (!_serviceEnabled) {
        throw Exception("Service not enable.");
      }
    }

    _permissionGranted = await locator.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await locator.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        throw Exception("No permission to access location.");
      }
    }

    _locationData = await locator.getLocation();
    return CurrentLocation(latitude: _locationData.latitude, longitude: _locationData.longitude);
  }
}
