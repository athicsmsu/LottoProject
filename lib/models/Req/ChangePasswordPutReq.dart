// To parse this JSON data, do
//
//     final changePasswordPutReq = changePasswordPutReqFromJson(jsonString);

import 'dart:convert';

List<ChangePasswordPutReq> changePasswordPutReqFromJson(String str) =>
    List<ChangePasswordPutReq>.from(
        json.decode(str).map((x) => ChangePasswordPutReq.fromJson(x)));

String changePasswordPutReqToJson(List<ChangePasswordPutReq> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChangePasswordPutReq {
  int memberId;
  String password;

  ChangePasswordPutReq({
    required this.memberId,
    required this.password,
  });

  factory ChangePasswordPutReq.fromJson(Map<String, dynamic> json) =>
      ChangePasswordPutReq(
        memberId: json["member_id"],
        password: json["Password"],
      );

  Map<String, dynamic> toJson() => {
        "member_id": memberId,
        "Password": password,
      };
}
