// To parse this JSON data, do
//
//     final memberRegisterPortReq = memberRegisterPortReqFromJson(jsonString);

import 'dart:convert';

MemberRegisterPortReq memberRegisterPortReqFromJson(String str) => MemberRegisterPortReq.fromJson(json.decode(str));

String memberRegisterPortReqToJson(MemberRegisterPortReq data) => json.encode(data.toJson());

class MemberRegisterPortReq {
    String name;
    String phone;
    String password;
    String image;
    String email;
    int walletBalance;
    String Type;

    MemberRegisterPortReq({
        required this.name,
        required this.phone,
        required this.password,
        required this.image,
        required this.email,
        required this.walletBalance,
        required this.Type,
    });

    factory MemberRegisterPortReq.fromJson(Map<String, dynamic> json) => MemberRegisterPortReq(
        name: json["name"],
        phone: json["Phone"],
        password: json["Password"],
        image: json["Image"],
        email: json["Email"],
        walletBalance: json["wallet_balance"],
        Type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "Phone": phone,
        "Password": password,
        "Image": image,
        "Email": email,
        "wallet_balance": walletBalance,
        "Type": Type,
    };
}
