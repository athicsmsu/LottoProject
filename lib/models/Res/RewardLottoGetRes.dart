// To parse this JSON data, do
//
//     final rewardLottoGetRes = rewardLottoGetResFromJson(jsonString);

import 'dart:convert';

List<RewardLottoGetRes> rewardLottoGetResFromJson(String str) =>
    List<RewardLottoGetRes>.from(
        json.decode(str).map((x) => RewardLottoGetRes.fromJson(x)));

String rewardLottoGetResToJson(List<RewardLottoGetRes> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RewardLottoGetRes {
  int drawId;
  String drawDate;
  int lotteryId;
  int prizeStatus;
  int prizeAmount;
  String isReceived;

  RewardLottoGetRes({
    required this.drawId,
    required this.drawDate,
    required this.lotteryId,
    required this.prizeStatus,
    required this.prizeAmount,
    required this.isReceived,
  });

  factory RewardLottoGetRes.fromJson(Map<String, dynamic> json) =>
      RewardLottoGetRes(
        drawId: json["draw_id"],
        drawDate: json["draw_date"],
        lotteryId: json["lottery_id"],
        prizeStatus: json["prize_status"],
        prizeAmount: json["prize_amount"],
        isReceived: json["is_received"],
      );

  Map<String, dynamic> toJson() => {
        "draw_id": drawId,
        "draw_date": drawDate,
        "lottery_id": lotteryId,
        "prize_status": prizeStatus,
        "prize_amount": prizeAmount,
        "is_received": isReceived,
      };
}
