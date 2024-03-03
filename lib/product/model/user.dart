// To parse this JSON data, do
//
//     final users = usersFromJson(jsonString);

import 'dart:convert';

Users usersFromJson(String str) => Users.fromJson(json.decode(str));

String usersToJson(Users data) => json.encode(data.toJson());

class Users {
    String id;
    String tel;
    String userEmail;
    String userName;
    String userPassword;
    String userPhoto;
    String userSurname;

    Users({
        required this.id,
        required this.tel,
        required this.userEmail,
        required this.userName,
        required this.userPassword,
        required this.userPhoto,
        required this.userSurname,
    });

    factory Users.fromJson(Map<String, dynamic> json) => Users(
        id: json["id"],
        tel: json["tel"],
        userEmail: json["user_email"],
        userName: json["user_name"],
        userPassword: json["user_password"],
        userPhoto: json["user_photo"],
        userSurname: json["user_surname"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "tel": tel,
        "user_email": userEmail,
        "user_name": userName,
        "user_password": userPassword,
        "user_photo": userPhoto,
        "user_surname": userSurname,
    };
}
