// To parse this JSON data, do
//
//     final memberLoginPostResponse = memberLoginPostResponseFromJson(jsonString);

import 'dart:convert';

MemberLoginPostResponse memberLoginPostResponseFromJson(String str) =>
    MemberLoginPostResponse.fromJson(json.decode(str));

String memberLoginPostResponseToJson(MemberLoginPostResponse data) =>
    json.encode(data.toJson());

class MemberLoginPostResponse {
  String message;
  int id;
  String type;

  MemberLoginPostResponse({
    required this.message,
    required this.id,
    required this.type,
  });

  factory MemberLoginPostResponse.fromJson(Map<String, dynamic> json) =>
      MemberLoginPostResponse(
        message: json["message"],
        id: json["id"],
        type: json["Type"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "id": id,
        "Type": type,
      };
}
