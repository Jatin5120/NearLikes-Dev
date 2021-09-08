import 'dart:convert';

GetStry getStryFromJson(String str) => GetStry.fromJson(json.decode(str));

String getStryToJson(GetStry data) => json.encode(data.toJson());

class GetStry {
  GetStry({
    this.data,
    this.paging,
  });

  List<Datum> data;
  Paging paging;

  factory GetStry.fromJson(Map<String, dynamic> json) => GetStry(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    paging: Paging.fromJson(json["paging"]),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "paging": paging.toJson(),
  };
}

class Datum {
  Datum({
    this.mediaUrl,
    this.timestamp,
    this.caption,
    this.id,
  });

  String mediaUrl;
  String timestamp;
  String caption;
  String id;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    mediaUrl: json["media_url"],
    timestamp: json["timestamp"],
    caption: json["caption"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "media_url": mediaUrl,
    "timestamp": timestamp,
    "caption": caption,
    "id": id,
  };
}

class Paging {
  Paging({
    this.cursors,
  });

  Cursors cursors;

  factory Paging.fromJson(Map<String, dynamic> json) => Paging(
    cursors: Cursors.fromJson(json["cursors"]),
  );

  Map<String, dynamic> toJson() => {
    "cursors": cursors.toJson(),
  };
}

class Cursors {
  Cursors({
    this.before,
    this.after,
  });

  String before;
  String after;

  factory Cursors.fromJson(Map<String, dynamic> json) => Cursors(
    before: json["before"],
    after: json["after"],
  );

  Map<String, dynamic> toJson() => {
    "before": before,
    "after": after,
  };
}
