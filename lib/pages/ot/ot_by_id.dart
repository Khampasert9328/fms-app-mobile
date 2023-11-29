// To parse this JSON data, do
//
//     final otById = otByIdFromJson(jsonString);

import 'dart:convert';

OtById otByIdFromJson(String str) => OtById.fromJson(json.decode(str));

String otByIdToJson(OtById data) => json.encode(data.toJson());

class OtById {
    OtById({
        this.status,
        this.data,
    });

    int? status;
    List<Datum>? data;

    factory OtById.fromJson(Map<String, dynamic> json) => OtById(
        status: json["status"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        this.eOvertimeId,
        this.date,
        this.startTime,
        this.endTime,
        this.detail,
        this.isApproved,
        this.remark,
        this.checkinTime,
        this.checkoutTime,
        this.hoursDiff,
        this.minutesDiff,
        this.approvedBy,
        this.projectName,
        this.workcode,
    });

    int? eOvertimeId;
    DateTime? date;
    DateTime? startTime;
    DateTime? endTime;
    String? detail;
    int? isApproved;
    dynamic remark;
    DateTime? checkinTime;
    DateTime? checkoutTime;
    int? hoursDiff;
    int? minutesDiff;
    dynamic approvedBy;
    String? projectName;
    String? workcode;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        eOvertimeId: json["e_overtime_id"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        startTime: json["start_time"] == null ? null : DateTime.parse(json["start_time"]),
        endTime: json["end_time"] == null ? null : DateTime.parse(json["end_time"]),
        detail: json["detail"],
        isApproved: json["is_approved"],
        remark: json["remark"],
        checkinTime: json["checkin_time"] == null ? null : DateTime.parse(json["checkin_time"]),
        checkoutTime: json["checkout_time"] == null ? null : DateTime.parse(json["checkout_time"]),
        hoursDiff: json["hours_diff"],
        minutesDiff: json["minutes_diff"],
        approvedBy: json["approved_by"],
        projectName: json["project_name"],
        workcode: json["workcode"],
    );

    Map<String, dynamic> toJson() => {
        "e_overtime_id": eOvertimeId,
        "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "start_time": startTime?.toIso8601String(),
        "end_time": endTime?.toIso8601String(),
        "detail": detail,
        "is_approved": isApproved,
        "remark": remark,
        "checkin_time": checkinTime?.toIso8601String(),
        "checkout_time": checkoutTime?.toIso8601String(),
        "hours_diff": hoursDiff,
        "minutes_diff": minutesDiff,
        "approved_by": approvedBy,
        "project_name": projectName,
        "workcode": workcode,
    };
}
