// To parse this JSON data, do
//
//     final addOrderPostRes = addOrderPostResFromJson(jsonString);

import 'dart:convert';

AddOrderPostRes addOrderPostResFromJson(String str) => AddOrderPostRes.fromJson(json.decode(str));

String addOrderPostResToJson(AddOrderPostRes data) => json.encode(data.toJson());

class AddOrderPostRes {
    String message;

    AddOrderPostRes({
        required this.message,
    });

    factory AddOrderPostRes.fromJson(Map<String, dynamic> json) => AddOrderPostRes(
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
    };
}
