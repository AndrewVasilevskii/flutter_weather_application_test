
class CurrentLocation {
  final double latitude;
  final double longitude;
  final String city;
  final String countryCode;

  CurrentLocation({this.latitude, this.longitude, this.city, this.countryCode});

  @override
  String toString() {
    return 'Latitude: $latitude, Longitude: $longitude. $city, $countryCode';
  }
}