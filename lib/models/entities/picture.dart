import 'package:bson/bson.dart';

class Picture {
  ObjectId id;
  String url;
  double latitude;
  double longitude;
  double altitude;
  DateTime created;

  Picture({
    required this.id,
    required this.url,
    required this.latitude,
    required this.longitude,
    required this.altitude,
    required this.created,
  });

  // Serialización de Picture a Map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> pictureMap = {
      '_id': id?.toHexString() ?? '', // Usar una cadena vacía si id es nulo
      'url': url ?? '',
      'latitude': latitude ?? 0.0, // Usar 0.0 si latitude es nulo
      'longitude': longitude ?? 0.0, // Usar 0.0 si longitude es nulo
      'altitude': altitude ?? 0.0, // Usar 0.0 si altitude es nulo
      'created': created.toIso8601String()
    };
    return pictureMap;
  }

  // Deserialización de Map a Picture
  factory Picture.fromMap(Map<String, dynamic> map) {
    String id = map['_id'];
    return Picture(
      id: ObjectId.fromHexString(id),
      url: map['url'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      altitude: map['altitude'],
      created: DateTime.parse(map['created']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id.toHexString(),
      "url": url,
      "latitude": latitude,
      "longitude": longitude,
      "altitude": altitude,
      "created": created.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'Picture{id: ${id.toHexString()}, url: $url, latitude: $latitude, longitude: $longitude, altitude: $altitude, created: ${created.toIso8601String()}}';
  }
}
