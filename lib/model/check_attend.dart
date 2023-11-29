// To parse this JSON data, do
//
//     final checkAttend = checkAttendFromJson(jsonString);

import 'dart:convert';

CheckAttend? checkAttendFromJson(String str) => CheckAttend.fromJson(json.decode(str));

String checkAttendToJson(CheckAttend? data) => json.encode(data!.toJson());

class CheckAttend {
    CheckAttend({
        this.status,
        this.data,
    });

    int? status;
    Data? data;

    factory CheckAttend.fromJson(Map<String, dynamic> json) => CheckAttend(
        status: json["status"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data!.toJson(),
    };
}

class Data {
    Data({
        this.inWork,
        this.attendanceId,
        this.checkinTime,
        this.totalSeconds,
        this.date,
    });

    bool? inWork;
    int? attendanceId;
    DateTime? checkinTime;
    int? totalSeconds;
    DateTime? date;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        inWork: json["in_work"],
        attendanceId: json["attendance_id"],
        checkinTime: DateTime.parse(json["checkin_time"]),
        totalSeconds: json["total_seconds"],
        date: DateTime.parse(json["date"]),
    );

    Map<String, dynamic> toJson() => {
        "in_work": inWork,
        "attendance_id": attendanceId,
        "checkin_time": checkinTime?.toIso8601String(),
        "total_seconds": totalSeconds,
        "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    };
}
