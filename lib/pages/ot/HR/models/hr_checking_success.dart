// To parse this JSON data, do
//
//     final hrCheckingSuccessModels = hrCheckingSuccessModelsFromJson(jsonString);

import 'dart:convert';

HrCheckingSuccessModels hrCheckingSuccessModelsFromJson(String str) => HrCheckingSuccessModels.fromJson(json.decode(str));

String hrCheckingSuccessModelsToJson(HrCheckingSuccessModels data) => json.encode(data.toJson());

class HrCheckingSuccessModels {
    int? status;
    String? msg;
    List<CheckingSuccess>? data;

    HrCheckingSuccessModels({
        this.status,
        this.msg,
        this.data,
    });

    factory HrCheckingSuccessModels.fromJson(Map<String, dynamic> json) => HrCheckingSuccessModels(
        status: json["status"],
        msg: json["msg"],
        data: json["data"] == null ? [] : List<CheckingSuccess>.from(json["data"]!.map((x) => CheckingSuccess.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class CheckingSuccess {
    int? eOvertimeId;
    int? employeeId;
    int? projectId;
    String? projectName;
    int? isApproved;
    String? detail;
    dynamic remark;
    String? approveBy;
    String? lastUpdate;
    dynamic hours;
    String? fullname;
    String? profileImgNew;
    DateTime? date;
    String? startTime;
    dynamic endTime;
    String? workTypesName;
    String? overtimeTypeName;
    String? oStatusName;
    int? workType;
    int? oStatusId;
    int? overtimeTypeId;
    int? statusApproved;

    CheckingSuccess({
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

    factory CheckingSuccess.fromJson(Map<String, dynamic> json) => CheckingSuccess(
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
