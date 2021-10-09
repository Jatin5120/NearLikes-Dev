// // To parse this JSON data, do
// //
// //     final getCampaigns = getCampaignsFromJson(jsonString);
//
// import 'dart:convert';
//
// GetCampaigns getCampaignsFromJson(String str) => GetCampaigns.fromJson(json.decode(str));
//
// String getCampaignsToJson(GetCampaigns data) => json.encode(data.toJson());
//
// class GetCampaigns {
//   GetCampaigns({
//     this.campaigns,
//   });
//
//   List<Campaign> campaigns;
//
//   factory GetCampaigns.fromJson(Map<String, dynamic> json) => GetCampaigns(
//     campaigns: List<Campaign>.from(json["campaigns"].map((x) => Campaign.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "campaigns": List<dynamic>.from(campaigns.map((x) => x.toJson())),
//   };
// }
//
// class Campaign {
//   Campaign({
//     this.createdAt,
//     this.id,
//     this.ownerId,
//     this.followers,
//     this.location,
//     this.age,
//     this.status,
//     this.start,
//     this.end,
//     this.brand,
//     this.text,
//     this.v,
//   });
//
//   int createdAt;
//   String id;
//   String ownerId;
//   int followers;
//   String location;
//   int age;
//   String status;
//   int start;
//   int end;
//   String brand;
//   String text;
//   int v;
//
//   factory Campaign.fromJson(Map<String, dynamic> json) => Campaign(
//     createdAt: json["createdAt"],
//     id: json["_id"],
//     ownerId: json["ownerId"],
//     followers: json["followers"],
//     location: json["location"],
//     age: json["age"],
//     status: json["status"],
//     start: json["start"],
//     end: json["end"],
//     brand: json["brand"],
//     text: json["text"],
//     v: json["__v"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "createdAt": createdAt,
//     "_id": id,
//     "ownerId": ownerId,
//     "followers": followers,
//     "location": location,
//     "age": age,
//     "status": status,
//     "start": start,
//     "end": end,
//     "brand": brand,
//     "text": text,
//     "__v": v,
//   };
// }
import 'dart:convert';

GetCampaigns getCampaignsFromJson(String str) =>
    GetCampaigns.fromJson(json.decode(str));

String getCampaignsToJson(GetCampaigns data) => json.encode(data.toJson());

class GetCampaigns {
  GetCampaigns({
    this.campaigns,
  });

  List<Campaign>? campaigns;

  factory GetCampaigns.fromJson(Map<String, dynamic> json) => GetCampaigns(
        campaigns: List<Campaign>.from(
            json["campaigns"].map((x) => Campaign.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "campaigns": List<dynamic>.from(campaigns!.map((x) => x.toJson())),
      };
}

class Campaign {
  Campaign({
    this.id,
    this.createdAt,
    this.ownerId,
    this.followers,
    this.location,
    this.age,
    this.logo,
    this.status,
    this.start,
    this.end,
    this.brand,
    this.text,
    this.v,
    this.username,
  });

  String? id;
  int? createdAt;
  String? ownerId;
  int? followers;
  String? location;
  int? age;
  String? logo;
  String? status;
  int? start;
  int? end;
  String? brand;
  String? text;
  int? v;
  String? username;

  factory Campaign.fromJson(Map<String, dynamic> json) => Campaign(
        id: json["_id"],
        createdAt: json["createdAt"],
        ownerId: json["ownerId"],
        followers: json["followers"],
        location: json["location"],
        age: json["age"],
        logo: json["logo"],
        status: json["status"],
        start: json["start"],
        end: json["end"],
        brand: json["brand"],
        text: json["text"],
        v: json["__v"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "createdAt": createdAt,
        "ownerId": ownerId,
        "followers": followers,
        "location": location,
        "age": age,
        "logo": logo,
        "status": status,
        "start": start,
        "end": end,
        "brand": brand,
        "text": text,
        "__v": v,
        "username": username,
      };
}
