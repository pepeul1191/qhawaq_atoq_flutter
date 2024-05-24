import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Member {
  @JsonKey(name: "_id")
  String id;
  @JsonKey(name: "names")
  String names;
  @JsonKey(name: "last_names")
  String lastNames;
  @JsonKey(name: "resume")
  String resume;
  @JsonKey(name: "image_url")
  String imageUrl;

  Member({
    required this.id,
    required this.names,
    required this.lastNames,
    required this.resume,
    required this.imageUrl,
  });

  factory Member.fromJson(Map<String, dynamic> json) => Member(
        id: json["_id"],
        names: json["names"],
        lastNames: json["last_names"],
        resume: json["resume"],
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "names": names,
        "last_names": lastNames,
        "image_url": imageUrl,
      };
}
