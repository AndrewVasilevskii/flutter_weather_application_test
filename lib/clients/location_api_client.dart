import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:flutterweatherapplication/models/current_location.dart';

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
        throw Exception('Service not enable.');
      }
    }

    _permissionGranted = await locator.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await locator.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        throw Exception('No permission to access location.');
      }
    }

    _locationData = await locator.getLocation();
    final place  = await geo.Geolocator().placemarkFromCoordinates(
        _locationData.latitude,
        _locationData.longitude
    );

    return CurrentLocation(
        latitude: _locationData.latitude,
        longitude: _locationData.longitude,
        city: place[0].locality,
        countryCode: place[0].isoCountryCode
    );
  }
}
