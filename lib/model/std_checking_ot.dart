// To parse this JSON data, do
//
//     final stdCheckingOt = stdCheckingOtFromJson(jsonString);

import 'dart:convert';

StdCheckingOt stdCheckingOtFromJson(String str) => StdCheckingOt.fromJson(json.decode(str));

String stdCheckingOtToJson(StdCheckingOt data) => json.encode(data.toJson());

class StdCheckingOt {
    StdCheckingOt({
        this.status,
        this.data,
    });

    int? status;
    List<Datum>? data;

    factory StdCheckingOt.fromJson(Map<String, dynamic> json) => StdCheckingOt(
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
    });

    int? eOvertimeId;
    String? startTime;
    String? endTime;
    DateTime? date;
    int? employeeId;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        eOvertimeId: json["e_overtime_id"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        employeeId: json["employee_id"],
    );

    Map<String, dynamic> toJson() => {
        "e_overtime_id": eOvertimeId,
        "start_time": startTime,
        "end_time": endTime,
        "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "employee_id": employeeId,
    };
}
