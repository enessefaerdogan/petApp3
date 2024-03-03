// To parse this JSON data, do
//
//     final familyMatch = familyMatchFromJson(jsonString);

import 'dart:convert';

FamilyMatch familyMatchFromJson(String str) => FamilyMatch.fromJson(json.decode(str));

String familyMatchToJson(FamilyMatch data) => json.encode(data.toJson());

class FamilyMatch {
    String id;
    String petId;
    String petName;
    String userEmail;
    String message;

    FamilyMatch({
        required this.id,
        required this.petId,
        required this.petName,
        required this.userEmail,
        required this.message,
    });

    factory FamilyMatch.fromJson(Map<String, dynamic> json) => FamilyMatch(
        id: json["id"],
        petId: json["pet_id"],
        petName: json["pet_name"],
        userEmail: json["user_email"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "pet_id": petId,
        "pet_name": petName,
        "user_email": userEmail,
        "message": message,
    };
}
