// To parse this JSON data, do
//
//     final checkingStartOt = checkingStartOtFromJson(jsonString);

import 'dart:convert';

CheckingStartOt checkingStartOtFromJson(String str) => CheckingStartOt.fromJson(json.decode(str));

String checkingStartOtToJson(CheckingStartOt data) => json.encode(data.toJson());

class CheckingStartOt {
    CheckingStartOt({
        this.status,
        this.data,
    });

    int? status;
    List<Datum>? data;

    factory CheckingStartOt.fromJson(Map<String, dynamic> json) => CheckingStartOt(
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
        this.startTime,
        this.endTime,
        this.date,
        this.employeeId,
        this.checkinTime,
        this.checkoutTime,
        this.totalSeconds,
    });

    int? eOvertimeId;
    String? startTime;
    String? endTime;
    DateTime? date;
    int? employeeId;
    String? checkinTime;
    String? checkoutTime;
    int? totalSeconds;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        eOvertimeId: json["e_overtime_id"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        employeeId: json["employee_id"],
        checkinTime: json["checkin_time"],
        checkoutTime: json["checkout_time"],
        totalSeconds: json["total_seconds"],
    );

    Map<String, dynamic> toJson() => {
        "e_overtime_id": eOvertimeId,
        "start_time": startTime,
        "end_time": endTime,
        "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "employee_id": employeeId,
        "checkin_time": checkinTime,
        "checkout_time": checkoutTime,
        "total_seconds": totalSeconds,
    };
}
