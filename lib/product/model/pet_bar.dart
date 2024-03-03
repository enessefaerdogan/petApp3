// To parse this JSON data, do
//
//     final petBar = petBarFromJson(jsonString);

import 'dart:convert';

PetBar petBarFromJson(String str) => PetBar.fromJson(json.decode(str));

String petBarToJson(PetBar data) => json.encode(data.toJson());

class PetBar {
    int data;
    String id;
    String petId;

    PetBar({
        required this.data,
        required this.id,
        required this.petId,
    });

    factory PetBar.fromJson(Map<String, dynamic> json) => PetBar(
        data: json["data"],
        id: json["id"],
        petId: json["pet_id"],
    );

    Map<String, dynamic> toJson() => {
        "data": data,
        "id": id,
        "pet_id": petId,
    };
}
