import 'package:bson/bson.dart';

class Picture {
  ObjectId id;
  String url;

  Picture({
    required this.id,
    required this.url,
  });

  // Serialización de Track a Map
  Map<String, dynamic> toMap() {
    // Verificar si algún campo es nulo y proporcionar un valor predeterminado en ese caso
    return {
      '_id': id?.toHexString() ?? '',
      'url': url ?? '',
    };
  }

  // Deserialización de Map a Track
  factory Picture.fromMap(Map<String, dynamic> map) {
    String? id = map['_id'];
    //print(map);
    if (id == null) {
      id = ObjectId().toHexString();
    }
    return Picture(
      id: ObjectId.fromHexString(id),
      url: map['url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id.toHexString(),
        "url": url,
      };

  @override
  String toString() {
    return 'Picture{id: ${id.toHexString()}, url: $url}';
  }
}
