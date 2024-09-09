// To parse this JSON data, do
//
//     final claimPrizePutReq = claimPrizePutReqFromJson(jsonString);

import 'dart:convert';

ClaimPrizePutReq claimPrizePutReqFromJson(String str) => ClaimPrizePutReq.fromJson(json.decode(str));

String claimPrizePutReqToJson(ClaimPrizePutReq data) => json.encode(data.toJson());

class ClaimPrizePutReq {
    int drawId;
    int memberId;

    ClaimPrizePutReq({
        required this.drawId,
        required this.memberId,
    });

    factory ClaimPrizePutReq.fromJson(Map<String, dynamic> json) => ClaimPrizePutReq(
        drawId: json["draw_id"],
        memberId: json["member_id"],
    );

    Map<String, dynamic> toJson() => {
        "draw_id": drawId,
        "member_id": memberId,
    };
}
