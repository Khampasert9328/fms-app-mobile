// To parse this JSON data, do
//
//     final getAllForApproveTimeSheetModels = getAllForApproveTimeSheetModelsFromJson(jsonString);

import 'dart:convert';

GetAllForApproveTimeSheetModels getAllForApproveTimeSheetModelsFromJson(String str) => GetAllForApproveTimeSheetModels.fromJson(json.decode(str));

String getAllForApproveTimeSheetModelsToJson(GetAllForApproveTimeSheetModels data) => json.encode(data.toJson());

class GetAllForApproveTimeSheetModels {
    int? status;
    int? code;
    List<Datum>? data;

    GetAllForApproveTimeSheetModels({
        this.status,
        this.code,
        this.data,
    });

    factory GetAllForApproveTimeSheetModels.fromJson(Map<String, dynamic> json) => GetAllForApproveTimeSheetModels(
        status: json["status"],
        code: json["code"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    int? employeeId;
    int? levelId;
    String? fullname;
    String? profileImgNew;
    String? level;
    int? timesheetApproveal;
    String? divisionName;
    String? departmentName;
    int? myLevelId;

    Datum({
        this.employeeId,
        this.levelId,
        this.fullname,
        this.profileImgNew,
        this.level,
        this.timesheetApproveal,
        this.divisionName,
        this.departmentName,
        this.myLevelId,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        employeeId: json["employee_id"],
        levelId: json["level_id"],
        fullname: json["fullname"],
        profileImgNew: json["profile_img_new"],
        level: json["level"],
        timesheetApproveal: json["timesheet_approveal"],
        divisionName: json["division_name"],
        departmentName: json["department_name"],
        myLevelId: json["my_level_id"],
    );

    Map<String, dynamic> toJson() => {
        "employee_id": employeeId,
        "level_id": levelId,
        "fullname": fullname,
        "profile_img_new": profileImgNew,
        "level": level,
        "timesheet_approveal": timesheetApproveal,
        "division_name": divisionName,
        "department_name": departmentName,
        "my_level_id": myLevelId,
    };
}
