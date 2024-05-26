import 'package:bson/bson.dart';
import 'picture.dart';

class Track {
  ObjectId id;
  double latitude;
  double longitude;
  double altitude;
  DateTime created;
  Picture? picture;

  Track({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.altitude,
    required this.created,
    this.picture,
  });

  // Serialización de Track a Map
  Map<String, dynamic> toMap() {
    // Verificar si algún campo es nulo y proporcionar un valor predeterminado en ese caso
    print('toMAP');
    /*Map<String, dynamic> trackMap = {
      '_id': id?.toHexString() ?? '', // Usar una cadena vacía si id es nulo
      'latitude': latitude ?? 0.0, // Usar 0.0 si latitude es nulo
      'longitude': longitude ?? 0.0, // Usar 0.0 si longitude es nulo
      'altitude': altitude ?? 0.0, // Usar 0.0 si altitude es nulo
      'created': created.toIso8601String(),
      'picture': picture?.toMap(),
    };*/
    print(this);

    Map<String, dynamic> trackMap = {
      '_id': id?.toHexString() ?? '', // Usar una cadena vacía si id es nulo
      'latitude': latitude ?? 0.0, // Usar 0.0 si latitude es nulo
      'longitude': longitude ?? 0.0, // Usar 0.0 si longitude es nulo
      'altitude': altitude ?? 0.0, // Usar 0.0 si altitude es nulo
      'created': created.toIso8601String()
    };
    print(picture);
    if (picture != null) {
      print('IFFFFFFFFFFFFFFFFFFFFFFFFFFFfff');
      trackMap['picture'] = picture!
          .toMap(); // Utilizar ! para acceder a picture ya que sabemos que no es null
    }
    return trackMap;
  }

  // Deserialización de Map a Track
  factory Track.fromMap(Map<String, dynamic> map) {
    String id = map['_id'];
    Picture? picture;
    if (map.containsKey('picture') && map['picture'] != null) {
      picture = Picture.fromMap(map['picture']);
    }
    return Track(
      id: ObjectId.fromHexString(id),
      latitude: map['latitude'],
      longitude: map['longitude'],
      altitude: map['altitude'],
      created: DateTime.parse(map['created']),
      picture: picture,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id.toHexString(),
      "latitude": latitude,
      "longitude": longitude,
      "altitude": altitude,
      "created": created.toIso8601String(),
      "picture": picture != null
          ? picture!.toJson()
          : null, // Convertir el campo picture a Map o null si es null
    };
  }

  @override
  String toString() {
    return 'Track{id: ${id.toHexString()}, latitude: $latitude, longitude: $longitude, altitude: $altitude, created: ${created.toIso8601String()}, picture: ${picture != null ? picture!.toMap() : 'null'}}';
  }
}
