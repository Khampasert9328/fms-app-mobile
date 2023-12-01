// To parse this JSON data, do
//
//     final checkOtModel = checkOtModelFromJson(jsonString);

import 'dart:convert';

CheckOtModel checkOtModelFromJson(String str) => CheckOtModel.fromJson(json.decode(str));

String checkOtModelToJson(CheckOtModel data) => json.encode(data.toJson());

class CheckOtModel {
  int? status;
  String? msg;
  bool? code;
  Data? data;

  CheckOtModel({
    this.status,
    this.msg,
    this.code,
    this.data,
  });

  factory CheckOtModel.fromJson(Map<String, dynamic> json) => CheckOtModel(
    status: json["status"],
    msg: json["msg"],
    code: json["code"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "code": code,
    "data": data?.toJson(),
  };
}

class Data {
  int? eOvertimeId;
  String? startTime;
  dynamic endTime;
  DateTime? date;
  int? employeeId;
  DateTime? checkinTime;
  dynamic checkoutTime;
  int? totalSeconds;

  Data({
    this.eOvertimeId,
    this.startTime,
    this.endTime,
    this.date,
    this.employeeId,
    this.checkinTime,
    this.checkoutTime,
    this.totalSeconds,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    eOvertimeId: json["e_overtime_id"],
    startTime: json["start_time"],
    endTime: json["end_time"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    employeeId: json["employee_id"],
    checkinTime: json["checkin_time"] == null ? null : DateTime.parse(json["checkin_time"]),
    checkoutTime: json["checkout_time"],
    totalSeconds: json["total_seconds"],
  );

  Map<String, dynamic> toJson() => {
    "e_overtime_id": eOvertimeId,
    "start_time": startTime,
    "end_time": endTime,
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "employee_id": employeeId,
    "checkin_time": checkinTime?.toIso8601String(),
    "checkout_time": checkoutTime,
    "total_seconds": totalSeconds,
  };
}
