// To parse this JSON data, do
//
//     final lottoAllGetRes = lottoAllGetResFromJson(jsonString);

import 'dart:convert';

List<LottoAllGetRes> lottoAllGetResFromJson(String str) =>
    List<LottoAllGetRes>.from(
        json.decode(str).map((x) => LottoAllGetRes.fromJson(x)));

String lottoAllGetResToJson(List<LottoAllGetRes> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LottoAllGetRes {
  int lotteryId;
  int lotteryNumber;

  LottoAllGetRes({
    required this.lotteryId,
    required this.lotteryNumber,
  });

  factory LottoAllGetRes.fromJson(Map<String, dynamic> json) => LottoAllGetRes(
        lotteryId: json["lottery_id"],
        lotteryNumber: json["lottery_number"],
      );

  Map<String, dynamic> toJson() => {
        "lottery_id": lotteryId,
        "lottery_number": lotteryNumber,
      };
}
