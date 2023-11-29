// To parse this JSON data, do
//
//     final getTimeSheetsAllMonthandYearModels = getTimeSheetsAllMonthandYearModelsFromJson(jsonString);

import 'dart:convert';

GetTimeSheetsAllMonthandYearModels getTimeSheetsAllMonthandYearModelsFromJson(String str) => GetTimeSheetsAllMonthandYearModels.fromJson(json.decode(str));

String getTimeSheetsAllMonthandYearModelsToJson(GetTimeSheetsAllMonthandYearModels data) => json.encode(data.toJson());

class GetTimeSheetsAllMonthandYearModels {
    int? status;
    int? total;
    List<Datum>? data;

    GetTimeSheetsAllMonthandYearModels({
        this.status,
        this.total,
        this.data,
    });

    factory GetTimeSheetsAllMonthandYearModels.fromJson(Map<String, dynamic> json) => GetTimeSheetsAllMonthandYearModels(
        status: json["status"],
        total: json["total"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "total": total,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    DateTime? date;
    String? statusName;
    int? status;
    List<TimesheetList>? timesheetList;

    Datum({
        this.date,
        this.statusName,
        this.status,
        this.timesheetList,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        statusName: json["status_name"],
        status: json["status"],
        timesheetList: json["timesheet_list"] == null ? [] : List<TimesheetList>.from(json["timesheet_list"]!.map((x) => TimesheetList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "status_name": statusName,
        "status": status,
        "timesheet_list": timesheetList == null ? [] : List<dynamic>.from(timesheetList!.map((x) => x.toJson())),
    };
}

class TimesheetList {
    int? eTimesheetId;
    DateTime? date;
    int? employeeId;
    String? projectCode;
    String? workType;
    String? workcode;
    int? workcodeId;
    double? workHour;
    String? remark;
    dynamic filename;

    TimesheetList({
        this.eTimesheetId,
        this.date,
        this.employeeId,
        this.projectCode,
        this.workType,
        this.workcode,
        this.workcodeId,
        this.workHour,
        this.remark,
        this.filename,
    });

    factory TimesheetList.fromJson(Map<String, dynamic> json) => TimesheetList(
        eTimesheetId: json["e_timesheet_id"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        employeeId: json["employee_id"],
        projectCode: json["project_code"],
        workType: json["work_type"],
        workcode: json["workcode"],
        workcodeId: json["workcode_id"],
        workHour: json["work_hour"]?.toDouble(),
        remark: json["remark"],
        filename: json["filename"],
    );

    Map<String, dynamic> toJson() => {
        "e_timesheet_id": eTimesheetId,
        "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "employee_id": employeeId,
        "project_code": projectCode,
        "work_type": workType,
        "workcode": workcode,
        "workcode_id": workcodeId,
        "work_hour": workHour,
        "remark": remark,
        "filename": filename,
    };
}
