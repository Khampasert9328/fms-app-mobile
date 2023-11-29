// To parse this JSON data, do
//
//     final timesheetDateDetial = timesheetDateDetialFromJson(jsonString);

import 'dart:convert';

AdminTimesheetDateDetial timesheetDateDetialFromJson(String str) => AdminTimesheetDateDetial.fromJson(json.decode(str));

String timesheetDateDetialToJson(AdminTimesheetDateDetial data) => json.encode(data.toJson());

class AdminTimesheetDateDetial {
    AdminTimesheetDateDetial({
        this.status,
        this.data,
    });

    int? status;
    List<Datum>? data;

    factory AdminTimesheetDateDetial.fromJson(Map<String, dynamic> json) => AdminTimesheetDateDetial(
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
        this.eTimesheetId,
        this.projectCode,
        this.workType,
        this.workcode,
        this.workcodeId,
        this.workHour,
        this.remark,
        this.filename,
    });

    int? eTimesheetId;
    String? projectCode;
    String? workType;
    String? workcode;
    int? workcodeId;
    String? workHour;
    String? remark;
    dynamic filename;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        eTimesheetId: json["e_timesheet_id"],
        projectCode: json["project_code"],
        workType: json["work_type"],
        workcode: json["workcode"],
        workcodeId: json["workcode_id"],
        workHour: json["work_hour"].toString(),
        remark: json["remark"],
        filename: json["filename"],
    );

    Map<String, dynamic> toJson() => {
        "e_timesheet_id": eTimesheetId,
        "project_code": projectCode,
        "work_type": workType,
        "workcode": workcode,
        "workcode_id": workcodeId,
        "work_hour": workHour,
        "remark": remark,
        "filename": filename,
    };
}
