// To parse this JSON data, do
//
//     final overTimeProjectModels = overTimeProjectModelsFromJson(jsonString);

import 'dart:convert';

OverTimeProjectModels overTimeProjectModelsFromJson(String str) => OverTimeProjectModels.fromJson(json.decode(str));

String overTimeProjectModelsToJson(OverTimeProjectModels data) => json.encode(data.toJson());

class OverTimeProjectModels {
    int status;
    List<Datum> data;

    OverTimeProjectModels({
        required this.status,
        required this.data,
    });

    factory OverTimeProjectModels.fromJson(Map<String, dynamic> json) => OverTimeProjectModels(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    int eOvertimeId;
    int employeeId;
    int projectId;
    String projectName;
    String detail;
    String? remark;
    String? approveBy;
    String lastUpdate;
    String? hours;
    String fullname;
    String profileImgNew;
    DateTime date;
    String startTime;
    String? endTime;
    String workTypesName;
    String overtimeTypeName;
    String oStatusName;
    int workType;
    int oStatusId;
    int overtimeTypeId;
    int statusApproved;

    Datum({
        required this.eOvertimeId,
        required this.employeeId,
        required this.projectId,
        required this.projectName,
        required this.detail,
        required this.remark,
        required this.approveBy,
        required this.lastUpdate,
        required this.hours,
        required this.fullname,
        required this.profileImgNew,
        required this.date,
        required this.startTime,
        required this.endTime,
        required this.workTypesName,
        required this.overtimeTypeName,
        required this.oStatusName,
        required this.workType,
        required this.oStatusId,
        required this.overtimeTypeId,
        required this.statusApproved,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        eOvertimeId: json["e_overtime_id"],
        employeeId: json["employee_id"],
        projectId: json["project_id"],
        projectName: json["project_name"],
        detail: json["detail"],
        remark: json["remark"],
        approveBy: json["approve_by"],
        lastUpdate: json["last_update"],
        hours: json["hours"],
        fullname: json["fullname"],
        profileImgNew: json["profile_img_new"],
        date: DateTime.parse(json["date"]),
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
        "detail": detail,
        "remark": remark,
        "approve_by": approveBy,
        "last_update": lastUpdate,
        "hours": hours,
        "fullname": fullname,
        "profile_img_new": profileImgNew,
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
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
