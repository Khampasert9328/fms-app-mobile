// To parse this JSON data, do
//
//     final timeSheetRequest = timeSheetRequestFromJson(jsonString);

import 'dart:convert';

TimeSheetRequest timeSheetRequestFromJson(String str) => TimeSheetRequest.fromJson(json.decode(str));

String timeSheetRequestToJson(TimeSheetRequest data) => json.encode(data.toJson());

class TimeSheetRequest {
  DateTime? date;
  String? projectId;
  String? workType;
  String? workcode;
  String? workHour;
  String? remark;

  TimeSheetRequest({
    this.date,
    this.projectId,
    this.workType,
    this.workcode,
    this.workHour,
    this.remark,
  });

  factory TimeSheetRequest.fromJson(Map<String, dynamic> json) => TimeSheetRequest(
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    projectId: json["project_id"],
    workType: json["work_type"],
    workcode: json["workcode"],
    workHour: json["work_hour"],
    remark: json["remark"],
  );

  Map<String, dynamic> toJson() => {
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "project_id": projectId,
    "work_type": workType,
    "workcode": workcode,
    "work_hour": workHour,
    "remark": remark,
  };
}
