// To parse this JSON data, do
//
//     final memberChackGetRes = memberChackGetResFromJson(jsonString);

import 'dart:convert';

List<MemberChackGetRes> memberChackGetResFromJson(String str) => List<MemberChackGetRes>.from(json.decode(str).map((x) => MemberChackGetRes.fromJson(x)));

String memberChackGetResToJson(List<MemberChackGetRes> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MemberChackGetRes {
    int memberId;
    String name;
    String phone;
    String password;
    String image;
    String email;
    int walletBalance;
    String type;

    MemberChackGetRes({
        required this.memberId,
        required this.name,
        required this.phone,
        required this.password,
        required this.image,
        required this.email,
        required this.walletBalance,
        required this.type,
    });

    factory MemberChackGetRes.fromJson(Map<String, dynamic> json) => MemberChackGetRes(
        memberId: json["member_id"],
        name: json["name"],
        phone: json["Phone"],
        password: json["Password"],
        image: json["Image"],
        email: json["Email"],
        walletBalance: json["wallet_balance"],
        type: json["Type"],
    );

    Map<String, dynamic> toJson() => {
        "member_id": memberId,
        "name": name,
        "Phone": phone,
        "Password": password,
        "Image": image,
        "Email": email,
        "wallet_balance": walletBalance,
        "Type": type,
    };
}
