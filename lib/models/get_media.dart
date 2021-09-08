// To parse this JSON data, do
//
//     final getMedia = getMediaFromJson(jsonString);

import 'dart:convert';

GetMedia getMediaFromJson(String str) => GetMedia.fromJson(json.decode(str));

String getMediaToJson(GetMedia data) => json.encode(data.toJson());

class GetMedia {
  GetMedia({
    this.media,
  });

  List<Media> media;

  factory GetMedia.fromJson(Map<String, dynamic> json) => GetMedia(
    media: List<Media>.from(json["media"].map((x) => Media.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "media": List<dynamic>.from(media.map((x) => x.toJson())),
  };
}

class Media {
  Media({
    this.id,
    this.src,
    this.pre,
    this.type,
  });

  String id;
  String src;
  String pre;
  String type;

  factory Media.fromJson(Map<String, dynamic> json) => Media(
    id: json["_id"],
    src: json["src"],
    pre: json["pre"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "src": src,
    "pre": pre,
    "type": type,
  };
}



// // To parse this JSON data, do
// //
// //     final getMedia = getMediaFromJson(jsonString);
//
// import 'dart:convert';
//
// GetMedia getMediaFromJson(String str) => GetMedia.fromJson(json.decode(str));
//
// String getMediaToJson(GetMedia data) => json.encode(data.toJson());
//
// class GetMedia {
//   GetMedia({
//     this.media,
//   });
//
//   List<Media> media;
//
//   factory GetMedia.fromJson(Map<String, dynamic> json) => GetMedia(
//     media: List<Media>.from(json["media"].map((x) => Media.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "media": List<dynamic>.from(media.map((x) => x.toJson())),
//   };
// }
//
// class Media {
//   Media({
//     this.id,
//     this.src,
//     this.pre,
//   });
//
//   String id;
//   String src;
//   String pre;
//
//   factory Media.fromJson(Map<String, dynamic> json) => Media(
//     id: json["_id"],
//     src: json["src"],
//     pre: json["pre"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "_id": id,
//     "src": src,
//     "pre": pre,
//   };
// }
