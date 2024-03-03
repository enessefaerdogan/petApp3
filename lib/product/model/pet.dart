// To parse this JSON data, do
//
//     final pet = petFromJson(jsonString);

import 'dart:convert';

Pet petFromJson(String str) => Pet.fromJson(json.decode(str));

String petToJson(Pet data) => json.encode(data.toJson());

class Pet {
    String id;
    String petName;
    String petPhoto;
    String petText;
    String petType;

    Pet({
        required this.id,
        required this.petName,
        required this.petPhoto,
        required this.petText,
        required this.petType,
    });

    factory Pet.fromJson(Map<String, dynamic> json) => Pet(
        id: json["id"],
        petName: json["pet_name"],
        petPhoto: json["pet_photo"],
        petText: json["pet_text"],
        petType: json["pet_type"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "pet_name": petName,
        "pet_photo": petPhoto,
        "pet_text": petText,
        "pet_type": petType,
    };
}
