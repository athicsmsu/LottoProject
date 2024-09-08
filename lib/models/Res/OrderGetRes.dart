// To parse this JSON data, do
//
//     final orderGetRes = orderGetResFromJson(jsonString);

import 'dart:convert';

List<OrderGetRes> orderGetResFromJson(String str) => List<OrderGetRes>.from(json.decode(str).map((x) => OrderGetRes.fromJson(x)));

String orderGetResToJson(List<OrderGetRes> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderGetRes {
    int orderId;
    int lotteryId;
    int memberId;

    OrderGetRes({
        required this.orderId,
        required this.lotteryId,
        required this.memberId,
    });

    factory OrderGetRes.fromJson(Map<String, dynamic> json) => OrderGetRes(
        orderId: json["order_id"],
        lotteryId: json["lottery_id"],
        memberId: json["member_id"],
    );

    Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "lottery_id": lotteryId,
        "member_id": memberId,
    };
}
