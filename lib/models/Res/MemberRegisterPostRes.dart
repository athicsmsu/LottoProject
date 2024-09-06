// To parse this JSON data, do
//
//     final memberRegisterPostRes = memberRegisterPostResFromJson(jsonString);

import 'dart:convert';

MemberRegisterPostRes memberRegisterPostResFromJson(String str) => MemberRegisterPostRes.fromJson(json.decode(str));

String memberRegisterPostResToJson(MemberRegisterPostRes data) => json.encode(data.toJson());

class MemberRegisterPostRes {
    int affectedRow;
    int lastIdx;

    MemberRegisterPostRes({
        required this.affectedRow,
        required this.lastIdx,
    });

    factory MemberRegisterPostRes.fromJson(Map<String, dynamic> json) => MemberRegisterPostRes(
        affectedRow: json["affected_row"],
        lastIdx: json["last_idx"],
    );

    Map<String, dynamic> toJson() => {
        "affected_row": affectedRow,
        "last_idx": lastIdx,
    };
}
