// To parse this JSON data, do
//
//     final myLottoWinGetRes = myLottoWinGetResFromJson(jsonString);

import 'dart:convert';

List<MyLottoWinGetRes> myLottoWinGetResFromJson(String str) =>
    List<MyLottoWinGetRes>.from(
        json.decode(str).map((x) => MyLottoWinGetRes.fromJson(x)));

String myLottoWinGetResToJson(List<MyLottoWinGetRes> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MyLottoWinGetRes {
  int drawId;
  String drawDate;
  int lotteryId;
  int prizeStatus;
  int prizeAmount;

  MyLottoWinGetRes({
    required this.drawId,
    required this.drawDate,
    required this.lotteryId,
    required this.prizeStatus,
    required this.prizeAmount,
  });

  factory MyLottoWinGetRes.fromJson(Map<String, dynamic> json) =>
      MyLottoWinGetRes(
        drawId: json["draw_id"],
        drawDate: json["draw_date"],
        lotteryId: json["lottery_id"],
        prizeStatus: json["prize_status"],
        prizeAmount: json["prize_amount"],
      );

  Map<String, dynamic> toJson() => {
        "draw_id": drawId,
        "draw_date": drawDate,
        "lottery_id": lotteryId,
        "prize_status": prizeStatus,
        "prize_amount": prizeAmount,
      };
}
