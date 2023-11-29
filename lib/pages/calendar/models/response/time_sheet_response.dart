// To parse this JSON data, do
//
//     final timeSheetResponse = timeSheetResponseFromJson(jsonString);

import 'dart:convert';

TimeSheetResponse timeSheetResponseFromJson(String str) => TimeSheetResponse.fromJson(json.decode(str));

String timeSheetResponseToJson(TimeSheetResponse data) => json.encode(data.toJson());

class TimeSheetResponse {
  int? status;
  List<Datum>? data;

  TimeSheetResponse({
    this.status,
    this.data,
  });

  factory TimeSheetResponse.fromJson(Map<String, dynamic> json) => TimeSheetResponse(
    status: json["status"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  DateTime? date;
  int? status;
  String? remark;
  DateTime? createdAt;

  Datum({
    this.date,
    this.status,
    this.remark,
    this.createdAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    status: json["status"],
    remark: json["remark"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "status": status,
    "remark": remark,
    "created_at": createdAt?.toIso8601String(),
  };
}
