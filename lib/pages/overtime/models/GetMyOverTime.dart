// To parse this JSON data, do
//
//     final getMyOverTimeModels = getMyOverTimeModelsFromJson(jsonString);

import 'dart:convert';

GetMyOverTimeModels getMyOverTimeModelsFromJson(String str) => GetMyOverTimeModels.fromJson(json.decode(str));

String getMyOverTimeModelsToJson(GetMyOverTimeModels data) => json.encode(data.toJson());

class GetMyOverTimeModels {
    int? status;
    Data? data;

    GetMyOverTimeModels({
        this.status,
        this.data,
    });

    factory GetMyOverTimeModels.fromJson(Map<String, dynamic> json) => GetMyOverTimeModels(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
    };
}

class Data {
    String? year;
    List<Overtime>? overtimes;

    Data({
        this.year,
        this.overtimes,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        year: json["year"],
        overtimes: json["overtimes"] == null ? [] : List<Overtime>.from(json["overtimes"]!.map((x) => Overtime.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "year": year,
        "overtimes": overtimes == null ? [] : List<dynamic>.from(overtimes!.map((x) => x.toJson())),
    };
}

class Overtime {
    int? eOvertimeId;
    int? employeeId;
    int? projectId;
    String? projectName;
    int? isApproved;
    dynamic detail;
    dynamic approveBy;
    String? lastUpdate;
    dynamic hours;
    DateTime? date;
    String? startTime;
    dynamic endTime;
    String? workTypesName;
    String? overtimeTypeName;
    String? oStatusName;
    int? workType;
    int? oStatusId;
    int? overtimeTypeId;

    Overtime({
        this.eOvertimeId,
        this.employeeId,
        this.projectId,
        this.projectName,
        this.isApproved,
        this.detail,
        this.approveBy,
        this.lastUpdate,
        this.hours,
        this.date,
        this.startTime,
        this.endTime,
        this.workTypesName,
        this.overtimeTypeName,
        this.oStatusName,
        this.workType,
        this.oStatusId,
        this.overtimeTypeId,
    });

    factory Overtime.fromJson(Map<String, dynamic> json) => Overtime(
        eOvertimeId: json["e_overtime_id"],
        employeeId: json["employee_id"],
        projectId: json["project_id"],
        projectName: json["project_name"],
        isApproved: json["is_approved"],
        detail: json["detail"],
        approveBy: json["approve_by"],
        lastUpdate: json["last_update"],
        hours: json["hours"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        startTime: json["start_time"],
        endTime: json["end_time"],
        workTypesName: json["work_types_name"],
        overtimeTypeName: json["overtime_type_name"],
        oStatusName: json["o_status_name"],
        workType: json["work_type"],
        oStatusId: json["o_status_id"],
        overtimeTypeId: json["overtime_type_id"],
    );

    Map<String, dynamic> toJson() => {
        "e_overtime_id": eOvertimeId,
        "employee_id": employeeId,
        "project_id": projectId,
        "project_name": projectName,
        "is_approved": isApproved,
        "detail": detail,
        "approve_by": approveBy,
        "last_update": lastUpdate,
        "hours": hours,
        "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "start_time": startTime,
        "end_time": endTime,
        "work_types_name": workTypesName,
        "overtime_type_name": overtimeTypeName,
        "o_status_name": oStatusName,
        "work_type": workType,
        "o_status_id": oStatusId,
        "overtime_type_id": overtimeTypeId,
    };
}
