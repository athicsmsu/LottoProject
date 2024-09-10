// To parse this JSON data, do
//
//     final memberEditPutReq = memberEditPutReqFromJson(jsonString);

import 'dart:convert';

List<MemberEditPutReq> memberEditPutReqFromJson(String str) =>
    List<MemberEditPutReq>.from(
        json.decode(str).map((x) => MemberEditPutReq.fromJson(x)));

String memberEditPutReqToJson(List<MemberEditPutReq> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MemberEditPutReq {
  int memberId;
  String name;
  String phone;
  String password;
  String image;
  String email;
  int walletBalance;
  String type;

  MemberEditPutReq({
    required this.memberId,
    required this.name,
    required this.phone,
    required this.password,
    required this.image,
    required this.email,
    required this.walletBalance,
    required this.type,
  });

  factory MemberEditPutReq.fromJson(Map<String, dynamic> json) =>
      MemberEditPutReq(
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
