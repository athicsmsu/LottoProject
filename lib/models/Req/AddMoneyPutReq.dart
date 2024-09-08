// To parse this JSON data, do
//
//     final addMoneyPutReq = addMoneyPutReqFromJson(jsonString);

import 'dart:convert';

AddMoneyPutReq addMoneyPutReqFromJson(String str) => AddMoneyPutReq.fromJson(json.decode(str));

String addMoneyPutReqToJson(AddMoneyPutReq data) => json.encode(data.toJson());

class AddMoneyPutReq {
    String phone;
    int amount;

    AddMoneyPutReq({
        required this.phone,
        required this.amount,
    });

    factory AddMoneyPutReq.fromJson(Map<String, dynamic> json) => AddMoneyPutReq(
        phone: json["Phone"],
        amount: json["amount"],
    );

    Map<String, dynamic> toJson() => {
        "Phone": phone,
        "amount": amount,
    };
}
