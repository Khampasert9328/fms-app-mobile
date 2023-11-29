// To parse this JSON data, do
//
//     final holidayModel = holidayModelFromJson(jsonString);

import 'dart:convert';

HolidayModel holidayModelFromJson(String str) => HolidayModel.fromJson(json.decode(str));

String holidayModelToJson(HolidayModel data) => json.encode(data.toJson());

class HolidayModel {
  int? status;
  List<Datum>? data;

  HolidayModel({
    this.status,
    this.data,
  });

  factory HolidayModel.fromJson(Map<String, dynamic> json) => HolidayModel(
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
  String? dateType;
  String? details;

  Datum({
    this.date,
    this.dateType,
    this.details,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    dateType: json["date_type"],
    details: json["details"],
  );

  Map<String, dynamic> toJson() => {
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "date_type": dateType,
    "details": details,
  };
}
