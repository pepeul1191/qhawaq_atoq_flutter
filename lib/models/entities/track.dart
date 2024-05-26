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
    Map<String, dynamic> trackMap = {
      '_id': id?.toHexString() ?? '', // Usar una cadena vacía si id es nulo
      'latitude': latitude ?? 0.0, // Usar 0.0 si latitude es nulo
      'longitude': longitude ?? 0.0, // Usar 0.0 si longitude es nulo
      'altitude': altitude ?? 0.0, // Usar 0.0 si altitude es nulo
      'created': created.toIso8601String()
    };
    return trackMap;
  }

  // Deserialización de Map a Track
  factory Track.fromMap(Map<String, dynamic> map) {
    String id = map['_id'];
    return Track(
      id: ObjectId.fromHexString(id),
      latitude: map['latitude'],
      longitude: map['longitude'],
      altitude: map['altitude'],
      created: DateTime.parse(map['created']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id.toHexString(),
      "latitude": latitude,
      "longitude": longitude,
      "altitude": altitude,
      "created": created.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'Track{id: ${id.toHexString()}, latitude: $latitude, longitude: $longitude, altitude: $altitude, created: ${created.toIso8601String()}}';
  }
}
