// To parse this JSON data, do
//
//     final help = helpFromJson(jsonString);

import 'dart:convert';

Help helpFromJson(String str) => Help.fromJson(json.decode(str));

String helpToJson(Help data) => json.encode(data.toJson());

class Help {
    String helpText;
    String helpTitle;
    String id;
    String petId;
    String userEmail;
    String helpDetailTitle;

    Help({
        required this.helpText,
        required this.helpTitle,
        required this.id,
        required this.petId,
        required this.userEmail,
        required this.helpDetailTitle,
    });

    factory Help.fromJson(Map<String, dynamic> json) => Help(
        helpText: json["help_text"],
        helpTitle: json["help_title"],
        id: json["id"],
        petId: json["pet_id"],
        userEmail: json["user_email"],
        helpDetailTitle: json["help_detail_title"],
    );

    Map<String, dynamic> toJson() => {
        "help_text": helpText,
        "help_title": helpTitle,
        "id": id,
        "pet_id": petId,
        "user_email": userEmail,
        "help_detail_title": helpDetailTitle,
    };
}
