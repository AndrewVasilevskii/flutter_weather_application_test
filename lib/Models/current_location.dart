
class CurrentLocation {
  final double latitude;
  final double longitude;

  CurrentLocation({this.latitude, this.longitude});

  @override
  String toString() {
    return 'Latitude: $latitude, Longitude: $longitude.';
  }
}