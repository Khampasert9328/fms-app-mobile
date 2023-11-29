// To parse this JSON data, do
//
//     final drAwaitModels = drAwaitModelsFromJson(jsonString);

import 'dart:convert';

DrAwaitModels drAwaitModelsFromJson(String str) => DrAwaitModels.fromJson(json.decode(str));

String drAwaitModelsToJson(DrAwaitModels data) => json.encode(data.toJson());

class DrAwaitModels {
    int? status;
    List<Datum>? data;

    DrAwaitModels({
        this.status,
        this.data,
    });

    factory DrAwaitModels.fromJson(Map<String, dynamic> json) => DrAwaitModels(
        status: json["status"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    int? eOvertimeId;
    int? employeeId;
    int? projectId;
    String? projectName;
    int? isApproved;
    String? detail;
    dynamic remark;
    String? approveBy;
    String? lastUpdate;
    String? hours;
    String? fullname;
    String? profileImgNew;
    DateTime? date;
    String? startTime;
    String? endTime;
    String? workTypesName;
    String? overtimeTypeName;
    String? oStatusName;
    int? workType;
    int? oStatusId;
    int? overtimeTypeId;
    int? statusApproved;

    Datum({
        this.eOvertimeId,
        this.employeeId,
        this.projectId,
        this.projectName,
        this.isApproved,
        this.detail,
        this.remark,
        this.approveBy,
        this.lastUpdate,
        this.hours,
        this.fullname,
        this.profileImgNew,
        this.date,
        this.startTime,
        this.endTime,
        this.workTypesName,
        this.overtimeTypeName,
        this.oStatusName,
        this.workType,
        this.oStatusId,
        this.overtimeTypeId,
        this.statusApproved,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        eOvertimeId: json["e_overtime_id"],
        employeeId: json["employee_id"],
        projectId: json["project_id"],
        projectName: json["project_name"],
        isApproved: json["is_approved"],
        detail: json["detail"],
        remark: json["remark"],
        approveBy: json["approve_by"],
        lastUpdate: json["last_update"],
        hours: json["hours"],
        fullname: json["fullname"],
        profileImgNew: json["profile_img_new"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        startTime: json["start_time"],
        endTime: json["end_time"],
        workTypesName: json["work_types_name"],
        overtimeTypeName: json["overtime_type_name"],
        oStatusName: json["o_status_name"],
        workType: json["work_type"],
        oStatusId: json["o_status_id"],
        overtimeTypeId: json["overtime_type_id"],
        statusApproved: json["status_approved"],
    );

    Map<String, dynamic> toJson() => {
        "e_overtime_id": eOvertimeId,
        "employee_id": employeeId,
        "project_id": projectId,
        "project_name": projectName,
        "is_approved": isApproved,
        "detail": detail,
        "remark": remark,
        "approve_by": approveBy,
        "last_update": lastUpdate,
        "hours": hours,
        "fullname": fullname,
        "profile_img_new": profileImgNew,
        "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "start_time": startTime,
        "end_time": endTime,
        "work_types_name": workTypesName,
        "overtime_type_name": overtimeTypeName,
        "o_status_name": oStatusName,
        "work_type": workType,
        "o_status_id": oStatusId,
        "overtime_type_id": overtimeTypeId,
        "status_approved": statusApproved,
    };
}
