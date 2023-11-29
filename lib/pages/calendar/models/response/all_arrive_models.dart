// To parse this JSON data, do
//
//     final allArrivedModels = allArrivedModelsFromJson(jsonString);

import 'dart:convert';

AllArrivedModels allArrivedModelsFromJson(String str) => AllArrivedModels.fromJson(json.decode(str));

String allArrivedModelsToJson(AllArrivedModels data) => json.encode(data.toJson());

class AllArrivedModels {
  int? status;
  List<Datum>? data;

  AllArrivedModels({
    this.status,
    this.data,
  });

  factory AllArrivedModels.fromJson(Map<String, dynamic> json) => AllArrivedModels(
    status: json["status"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  int? attendanceId;
  DateTime? checkinTime;
  DateTime? checkoutTime;
  DateTime? date;
  DateTime? dateOld;
  int? totalSeconds;

  Datum({
    this.attendanceId,
    this.checkinTime,
    this.checkoutTime,
    this.date,
    this.dateOld,
    this.totalSeconds,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    attendanceId: json["attendance_id"],
    checkinTime: json["checkin_time"] == null ? null : DateTime.parse(json["checkin_time"]),
    checkoutTime: json["checkout_time"] == null ? null : DateTime.parse(json["checkout_time"]),
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    dateOld: json["dateOld"] == null ? null : DateTime.parse(json["dateOld"]),
    totalSeconds: json["total_seconds"],
  );

  Map<String, dynamic> toJson() => {
    "attendance_id": attendanceId,
    "checkin_time": checkinTime?.toIso8601String(),
    "checkout_time": checkoutTime?.toIso8601String(),
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "dateOld": dateOld?.toIso8601String(),
    "total_seconds": totalSeconds,
  };
}
