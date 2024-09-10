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
  String image;
  String email;

  MemberEditPutReq({
    required this.memberId,
    required this.name,
    required this.phone,
    required this.image,
    required this.email,
  });

  factory MemberEditPutReq.fromJson(Map<String, dynamic> json) =>
      MemberEditPutReq(
        memberId: json["member_id"],
        name: json["name"],
        phone: json["Phone"],
        image: json["Image"],
        email: json["Email"],
      );

  Map<String, dynamic> toJson() => {
        "member_id": memberId,
        "name": name,
        "Phone": phone,
        "Image": image,
        "Email": email,
      };
}
