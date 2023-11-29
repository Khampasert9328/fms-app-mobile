// To parse this JSON data, do
//
//     final hrApprovedModels = hrApprovedModelsFromJson(jsonString);

import 'dart:convert';

HrApprovedModels hrApprovedModelsFromJson(String str) => HrApprovedModels.fromJson(json.decode(str));

String hrApprovedModelsToJson(HrApprovedModels data) => json.encode(data.toJson());

class HrApprovedModels {
    int? status;
    List<HRModels>? data;

    HrApprovedModels({
        this.status,
        this.data,
    });

    factory HrApprovedModels.fromJson(Map<String, dynamic> json) => HrApprovedModels(
        status: json["status"],
        data: json["data"] == null ? [] : List<HRModels>.from(json["data"]!.map((x) => HRModels.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class HRModels {
    int? eOvertimeId;
    int? employeeId;
    int? projectId;
    String? projectName;
    int? isApproved;
    String? detail;
    String? remark;
    ApproveBy? approveBy;
    String? lastUpdate;
    String? hours;
    String? fullname;
    String? profileImgNew;
    DateTime? date;
    String? startTime;
    EndTime? endTime;
    String? workTypesName;
    String? overtimeTypeName;
    String? oStatusName;
    int? workType;
    int? oStatusId;
    int? overtimeTypeId;
    int? statusApproved;

    HRModels({
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

    factory HRModels.fromJson(Map<String, dynamic> json) => HRModels(
        eOvertimeId: json["e_overtime_id"],
        employeeId: json["employee_id"],
        projectId: json["project_id"],
        projectName: json["project_name"],
        isApproved: json["is_approved"],
        detail: json["detail"],
        remark: json["remark"],
        approveBy: approveByValues.map[json["approve_by"]],
        lastUpdate: json["last_update"],
        hours: json["hours"],
        fullname: json["fullname"],
        profileImgNew: json["profile_img_new"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        startTime: json["start_time"],
        endTime: endTimeValues.map[json["end_time"]],
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
        "approve_by": approveByValues.reverse[approveBy],
        "last_update": lastUpdate,
        "hours": hours,
        "fullname": fullname,
        "profile_img_new": profileImgNew,
        "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "start_time": startTime,
        "end_time": endTimeValues.reverse[endTime],
        "work_types_name": workTypesNameValues.reverse[workTypesName],
        "overtime_type_name": overtimeTypeNameValues.reverse[overtimeTypeName],
        "o_status_name": oStatusNameValues.reverse[oStatusName],
        "work_type": workType,
        "o_status_id": oStatusId,
        "overtime_type_id": overtimeTypeId,
        "status_approved": statusApproved,
    };
}

enum ApproveBy {
    APHISIT_INTHONGXAY,
    KHAMPASERT_KEOSESOMPHAN,
    TAITHONG_SISAYKEO
}

final approveByValues = EnumValues({
    "Aphisit INTHONGXAY": ApproveBy.APHISIT_INTHONGXAY,
    "Khampasert Keosesomphan": ApproveBy.KHAMPASERT_KEOSESOMPHAN,
    "Taithong SISAYKEO": ApproveBy.TAITHONG_SISAYKEO
});

enum EndTime {
    THE_1758,
    THE_1958
}

final endTimeValues = EnumValues({
    "17:58": EndTime.THE_1758,
    "19:58": EndTime.THE_1958
});

enum OStatusName {
    EMPTY,
    OT,
    O_STATUS_NAME
}

final oStatusNameValues = EnumValues({
    "ລໍຖ້າຫົວໜ້າໂປເຈັກອານຸມັດ": OStatusName.EMPTY,
    "ຂໍ OT ສຳເລັດ": OStatusName.OT,
    "ບໍ່ອະນຸມັດ": OStatusName.O_STATUS_NAME
});

enum OvertimeTypeName {
    OT1,
    OT3
}

final overtimeTypeNameValues = EnumValues({
    "OT1": OvertimeTypeName.OT1,
    "OT3": OvertimeTypeName.OT3
});

enum WorkTypesName {
    BILLABLE_HOUR,
    NON_BILLABLE_HOUR
}

final workTypesNameValues = EnumValues({
    "Billable Hour": WorkTypesName.BILLABLE_HOUR,
    "Non-Billable Hour": WorkTypesName.NON_BILLABLE_HOUR
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
