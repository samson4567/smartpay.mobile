

// To parse this JSON data, do
//
//     final loginInModel = loginInModelFromJson(jsonString);

import 'dart:convert';

LoginInModel loginInModelFromJson(String str) => LoginInModel.fromJson(json.decode(str));

String loginInModelToJson(LoginInModel data) => json.encode(data.toJson());

class LoginInModel {
    LoginInModel({
        this.user,
        this.token,
    });

    User? user;
    String? token;

    factory LoginInModel.fromJson(Map<String, dynamic> json) => LoginInModel(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "token": token,
    };
}

class User {
    User({
        this.id,
        this.fullName,
        this.username,
        this.email,
        this.phone,
        this.phoneCountry,
        this.country,
        this.avatar,
    });

    String? id;
    String? fullName;
    String? username;
    String? email;
    dynamic phone;
    dynamic phoneCountry;
    String? country;
    dynamic avatar;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        fullName: json["full_name"],
        username: json["username"],
        email: json["email"],
        phone: json["phone"],
        phoneCountry: json["phone_country"],
        country: json["country"],
        avatar: json["avatar"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "username": username,
        "email": email,
        "phone": phone,
        "phone_country": phoneCountry,
        "country": country,
        "avatar": avatar,
    };
}
