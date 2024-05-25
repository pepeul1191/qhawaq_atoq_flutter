import 'package:bson/bson.dart';

class Track {
  ObjectId id;
  double latitude;
  double longitude;
  double altitude;
  DateTime created;

  Track({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.altitude,
    required this.created,
  });

  // Serialización de Track a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id.toHexString(),
      'latitude': latitude,
      'longitude': longitude,
      'altitude': altitude,
      'created': created.toIso8601String(),
    };
  }

  // Deserialización de Map a Track
  factory Track.fromMap(Map<String, dynamic> map) {
    return Track(
      id: map['_id'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      altitude: map['altitude'],
      created: DateTime.parse(map['created']),
    );
  }

  @override
  String toString() {
    return 'Track{id: ${id.toHexString()}, latitude: $latitude, longitude: $longitude, altitude: $altitude, created: $created}';
  }
}
