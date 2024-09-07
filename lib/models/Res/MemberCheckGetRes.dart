// To parse this JSON data, do
//
//     final memberChackGetRes = memberChackGetResFromJson(jsonString);

import 'dart:convert';

List<MemberCheckGetRes> memberCheckGetResFromJson(String str) => List<MemberCheckGetRes>.from(json.decode(str).map((x) => MemberCheckGetRes.fromJson(x)));

String memberCheckGetResToJson(List<MemberCheckGetRes> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MemberCheckGetRes {
    int memberId;
    String name;
    String phone;
    String password;
    String image;
    String email;
    var walletBalance;
    String type;

    MemberCheckGetRes({
        required this.memberId,
        required this.name,
        required this.phone,
        required this.password,
        required this.image,
        required this.email,
        required this.walletBalance,
        required this.type,
    });

    factory MemberCheckGetRes.fromJson(Map<String, dynamic> json) => MemberCheckGetRes(
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
