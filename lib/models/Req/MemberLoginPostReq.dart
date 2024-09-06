// To parse this JSON data, do
//
//     final memberLoginPostReq = memberLoginPostReqFromJson(jsonString);

import 'dart:convert';

MemberLoginPostReq memberLoginPostReqFromJson(String str) =>
    MemberLoginPostReq.fromJson(json.decode(str));

String memberLoginPostReqToJson(MemberLoginPostReq data) =>
    json.encode(data.toJson());

class MemberLoginPostReq {
  String phone;
  String password;

  MemberLoginPostReq({
    required this.phone,
    required this.password,
  });

  factory MemberLoginPostReq.fromJson(Map<String, dynamic> json) =>
      MemberLoginPostReq(
        phone: json["Phone"],
        password: json["Password"],
      );

  Map<String, dynamic> toJson() => {
        "Phone": phone,
        "Password": password,
      };
}
