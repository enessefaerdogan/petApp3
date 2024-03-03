// To parse this JSON data, do
//
//     final trip = tripFromJson(jsonString);

import 'dart:convert';

Trip tripFromJson(String str) => Trip.fromJson(json.decode(str));

String tripToJson(Trip data) => json.encode(data.toJson());

class Trip {
    String id;
    String tripPhoto;

    Trip({
        required this.id,
        required this.tripPhoto,
    });

    factory Trip.fromJson(Map<String, dynamic> json) => Trip(
        id: json["id"],
        tripPhoto: json["trip_photo"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "trip_photo": tripPhoto,
    };
}
