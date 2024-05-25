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
    // Verificar si algún campo es nulo y proporcionar un valor predeterminado en ese caso
    return {
      '_id': id?.toHexString() ?? '', // Usar una cadena vacía si id es nulo
      'latitude': latitude ?? 0.0, // Usar 0.0 si latitude es nulo
      'longitude': longitude ?? 0.0, // Usar 0.0 si longitude es nulo
      'altitude': altitude ?? 0.0, // Usar 0.0 si altitude es nulo
      'created': created?.toIso8601String() ??
          '', // Usar una cadena vacía si created es nulo
    };
  }

  // Deserialización de Map a Track
  factory Track.fromMap(Map<String, dynamic> map) {
    String? id = map['_id'];
    //print(map);
    if (id == null) {
      throw ArgumentError('El campo _id no puede ser null');
    }
    return Track(
      id: ObjectId.fromHexString(id),
      latitude: map['latitude'] ??
          0.0, // Utilizar un valor predeterminado si latitude es null
      longitude: map['longitude'] ??
          0.0, // Utilizar un valor predeterminado si longitude es null
      altitude: map['altitude'] ??
          0.0, // Utilizar un valor predeterminado si altitude es null
      created: DateTime.parse(
          map['created'] ?? ''), // Utilizar una cadena vacía si created es null
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id.toHexString(),
        "latitude": latitude,
        "longitude": longitude,
        "altitude": altitude,
        "created": created,
      };

  @override
  String toString() {
    return 'Track{id: ${id.toHexString()}, latitude: $latitude, longitude: $longitude, altitude: $altitude, created: $created}';
  }
}
