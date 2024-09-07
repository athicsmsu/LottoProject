// To parse this JSON data, do
//
//     final memberLoginPostRes = memberLoginPostResFromJson(jsonString);

import 'dart:convert';

MemberLoginPostRes memberLoginPostResFromJson(String str) => MemberLoginPostRes.fromJson(json.decode(str));

String memberLoginPostResToJson(MemberLoginPostRes data) => json.encode(data.toJson());

class MemberLoginPostRes {
    String message;
    int id;
    String name;
    String phone;
    String image;
    String email;
    var walletBalance;
    String type;

    MemberLoginPostRes({
        required this.message,
        required this.id,
        required this.name,
        required this.phone,
        required this.image,
        required this.email,
        required this.walletBalance,
        required this.type,
    });

    factory MemberLoginPostRes.fromJson(Map<String, dynamic> json) => MemberLoginPostRes(
        message: json["message"],
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        image: json["image"],
        email: json["email"],
        walletBalance: json["wallet_balance"]?.toDouble(),
        type: json["Type"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "id": id,
        "name": name,
        "phone": phone,
        "image": image,
        "email": email,
        "wallet_balance": walletBalance,
        "Type": type,
    };
}
