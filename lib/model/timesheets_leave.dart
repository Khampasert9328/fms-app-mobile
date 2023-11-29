// To parse this JSON data, do
//
//     final timesheetsLeave = timesheetsLeaveFromJson(jsonString);

import 'dart:convert';

List<TimesheetsLeave> timesheetsLeaveFromJson(String str) => List<TimesheetsLeave>.from(json.decode(str).map((x) => TimesheetsLeave.fromJson(x)));

String timesheetsLeaveToJson(List<TimesheetsLeave> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TimesheetsLeave {
    TimesheetsLeave({
        this.date,
        this.employeeId,
        this.details,
    });

    String? date;
    int? employeeId;
    String? details;

    factory TimesheetsLeave.fromJson(Map<String, dynamic> json) => TimesheetsLeave(
        date : json['date'],
        employeeId: json["employee_id"],
        details: json['details'],
    );

    Map<String, dynamic> toJson() => {
        "date": date,
        "employee_id": employeeId,
        "details": details,
    };
}


