
// To parse this JSON data, do
//
//     final distressCall = distressCallFromJson(jsonString);

import 'dart:convert';

DistressCall distressCallFromJson(String str) => DistressCall.fromJson(json.decode(str));

String distressCallToJson(DistressCall data) => json.encode(data.toJson());

class DistressCall {
  String description;
  double latitude;
  double longitude;
  String type;

  DistressCall({
    this.description,
    this.latitude,
    this.longitude,
    this.type,
  });

  factory DistressCall.fromJson(Map<String, dynamic> json) => DistressCall(
    description: json["description"],
    latitude: json["latitude"].toDouble(),
    longitude: json["longitude"].toDouble(),
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "description": description,
    "latitude": latitude,
    "longitude": longitude,
    "type": type,
  };
}
