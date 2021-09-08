// To parse this JSON data, do
//
//     final customer = customerFromJson(jsonString);

import 'dart:convert';

Customer customerFromJson(String str) => Customer.fromJson(json.decode(str));

String customerToJson(Customer data) => json.encode(data.toJson());

class Customer {
  Customer({
    this.customer,
  });

  CustomerClass customer;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    customer: CustomerClass.fromJson(json["customer"]),
  );

  Map<String, dynamic> toJson() => {
    "customer": customer.toJson(),
  };
}

class CustomerClass {
  CustomerClass({
    this.id,
    this.active,
    this.associations,
    this.tags,
    this.createdAt,
    this.coupons,
    this.cashback,
    this.name,
    this.age,
    this.insta,
    this.followers,
    this.location,
    this.upi,
    this.phone,
    this.eat,
    this.token,
    this.v,
    this.story,
  });

  String id;
  bool active;
  List<dynamic> associations;
  List<String> tags;
  int createdAt;
  List<Coupon> coupons;
  List<Cashback> cashback;
  String name;
  int age;
  String insta;
  int followers;
  String location;
  String upi;
  String phone;
  int eat;
  String token;
  int v;
  String story;

  factory CustomerClass.fromJson(Map<String, dynamic> json) => CustomerClass(
    id: json["_id"],
    active: json["active"],
    associations: List<dynamic>.from(json["associations"].map((x) => x)),
    tags: List<String>.from(json["tags"].map((x) => x)),
    createdAt: json["createdAt"],
    coupons: List<Coupon>.from(json["coupons"].map((x) => Coupon.fromJson(x))),
    cashback: List<Cashback>.from(json["cashback"].map((x) => Cashback.fromJson(x))),
    name: json["name"],
    age: json["age"],
    insta: json["insta"],
    followers: json["followers"],
    location: json["location"],
    upi: json["upi"],
    phone: json["phone"],
    eat: json["eat"],
    token: json["token"],
    v: json["__v"],
    story: json["story"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "active": active,
    "associations": List<dynamic>.from(associations.map((x) => x)),
    "tags": List<dynamic>.from(tags.map((x) => x)),
    "createdAt": createdAt,
    "coupons": List<dynamic>.from(coupons.map((x) => x.toJson())),
    "cashback": List<dynamic>.from(cashback.map((x) => x.toJson())),
    "name": name,
    "age": age,
    "insta": insta,
    "followers": followers,
    "location": location,
    "upi": upi,
    "phone": phone,
    "eat": eat,
    "token": token,
    "__v": v,
    "story": story,
  };
}

class Cashback {
  Cashback({
    this.used,
    this.id,
    this.amount,
  });

  bool used;
  String id;
  String amount;

  factory Cashback.fromJson(Map<String, dynamic> json) => Cashback(
    used: json["used"],
    id: json["_id"],
    amount: json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "used": used,
    "_id": id,
    "amount": amount,
  };
}

class Coupon {
  Coupon({
    this.used,
    this.id,
    this.code,
    this.brand,
    this.discount,
    this.expiry,
    this.link,
  });

  bool used;
  String id;
  String code;
  String brand;
  String discount;
  int expiry;
  String link;

  factory Coupon.fromJson(Map<String, dynamic> json) => Coupon(
    used: json["used"],
    id: json["_id"],
    code: json["code"],
    brand: json["brand"],
    discount: json["discount"],
    expiry: json["expiry"],
    link: json["link"],
  );

  Map<String, dynamic> toJson() => {
    "used": used,
    "_id": id,
    "code": code,
    "brand": brand,
    "discount": discount,
    "expiry": expiry,
    "link": link,
  };
}





// // To parse this JSON data, do
// //
// //     final customer = customerFromJson(jsonString);
//
// import 'dart:convert';
//
// Customer customerFromJson(String str) => Customer.fromJson(json.decode(str));
//
// String customerToJson(Customer data) => json.encode(data.toJson());
//
// class Customer {
//   Customer({
//     this.customer,
//   });
//
//   CustomerClass customer;
//
//   factory Customer.fromJson(Map<String, dynamic> json) => Customer(
//     customer: CustomerClass.fromJson(json["customer"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "customer": customer.toJson(),
//   };
// }
//
// class CustomerClass {
//   CustomerClass({
//     this.associations,
//     this.tags,
//     this.createdAt,
//     this.id,
//     this.cashback,
//     this.name,
//     this.insta,
//     this.followers,
//     this.location,
//     this.phone,
//     this.v,
//     this.email,
//     this.upi,
//     this.age,
//     this.eat,
//     this.story,
//     this.coupons,
//   });
//
//   List<String> associations;
//   List<dynamic> tags;
//   int createdAt;
//   String id;
//   List<Cashback> cashback;
//   String name;
//   String insta;
//   int followers;
//   String location;
//   String phone;
//   int v;
//   String email;
//   String upi;
//   int age;
//   int eat;
//   String story;
//   List<Coupon> coupons;
//
//   factory CustomerClass.fromJson(Map<String, dynamic> json) => CustomerClass(
//     associations: List<String>.from(json["associations"].map((x) => x)),
//     tags: List<dynamic>.from(json["tags"].map((x) => x)),
//     createdAt: json["createdAt"],
//     id: json["_id"],
//     cashback: List<Cashback>.from(json["cashback"].map((x) => Cashback.fromJson(x))),
//     name: json["name"],
//     insta: json["insta"],
//     followers: json["followers"],
//     location: json["location"],
//     phone: json["phone"],
//     v: json["__v"],
//     email: json["email"],
//     upi: json["upi"],
//     age: json["age"],
//     eat: json["eat"],
//     story: json["story"],
//     coupons: List<Coupon>.from(json["coupons"].map((x) => Coupon.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "associations": List<dynamic>.from(associations.map((x) => x)),
//     "tags": List<dynamic>.from(tags.map((x) => x)),
//     "createdAt": createdAt,
//     "_id": id,
//     "cashback": List<dynamic>.from(cashback.map((x) => x.toJson())),
//     "name": name,
//     "insta": insta,
//     "followers": followers,
//     "location": location,
//     "phone": phone,
//     "__v": v,
//     "email": email,
//     "upi": upi,
//     "age": age,
//     "eat": eat,
//     "story": story,
//     "coupons": List<dynamic>.from(coupons.map((x) => x.toJson())),
//   };
// }
//
// class Cashback {
//   Cashback({
//     this.used,
//     this.id,
//     this.amount,
//   });
//
//   bool used;
//   String id;
//   String amount;
//
//   factory Cashback.fromJson(Map<String, dynamic> json) => Cashback(
//     used: json["used"],
//     id: json["_id"],
//     amount: json["amount"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "used": used,
//     "_id": id,
//     "amount": amount,
//   };
// }
//
// class Coupon {
//   Coupon({
//     this.used,
//     this.id,
//     this.code,
//     this.brand,
//   });
//
//   bool used;
//   String id;
//   String code;
//   String brand;
//
//   factory Coupon.fromJson(Map<String, dynamic> json) => Coupon(
//     used: json["used"],
//     id: json["_id"],
//     code: json["code"],
//     brand: json["brand"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "used": used,
//     "_id": id,
//     "code": code,
//     "brand": brand,
//   };
// }
