// To parse this JSON data, do
//
//     final addOrderPostReq = addOrderPostReqFromJson(jsonString);

import 'dart:convert';

AddOrderPostReq addOrderPostReqFromJson(String str) =>
    AddOrderPostReq.fromJson(json.decode(str));

String addOrderPostReqToJson(AddOrderPostReq data) =>
    json.encode(data.toJson());

class AddOrderPostReq {
  int lotteryId;
  int memberId;

  AddOrderPostReq({
    required this.lotteryId,
    required this.memberId,
  });

  factory AddOrderPostReq.fromJson(Map<String, dynamic> json) =>
      AddOrderPostReq(
        lotteryId: json["lottery_id"],
        memberId: json["member_id"],
      );

  Map<String, dynamic> toJson() => {
        "lottery_id": lotteryId,
        "member_id": memberId,
      };
}
