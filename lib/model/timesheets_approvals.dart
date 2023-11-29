// To parse this JSON data, do
//
//     final timesheetsApprovals = timesheetsApprovalsFromJson(jsonString);

import 'dart:convert';

List<TimesheetsApprovals> timesheetsApprovalsFromJson(String str) => List<TimesheetsApprovals>.from(json.decode(str).map((x) => TimesheetsApprovals.fromJson(x)));

String timesheetsApprovalsToJson(List<TimesheetsApprovals> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TimesheetsApprovals {
    TimesheetsApprovals({
        this.date,
        this.status,
        this.remark,
        this.createdAt,
    });

    String? date;
    int? status;
    String? remark;
    DateTime? createdAt;

    factory TimesheetsApprovals.fromJson(Map<String, dynamic> json) => TimesheetsApprovals(
        date : json['date'],
        status: json["status"],
        remark: json["remark"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "date": date,
        "status": status,
        "remark": remark,
        "created_at": createdAt?.toIso8601String(),
    };
}
