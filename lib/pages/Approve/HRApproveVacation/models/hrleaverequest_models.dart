// To parse this JSON data, do
//
//     final hrLeaveRequestModels = hrLeaveRequestModelsFromJson(jsonString);

import 'dart:convert';

HrLeaveRequestModels hrLeaveRequestModelsFromJson(String str) => HrLeaveRequestModels.fromJson(json.decode(str));

String hrLeaveRequestModelsToJson(HrLeaveRequestModels data) => json.encode(data.toJson());

class HrLeaveRequestModels {
    int? status;
    int? code;
    List<Datum>? data;

    HrLeaveRequestModels({
        this.status,
        this.code,
        this.data,
    });

    factory HrLeaveRequestModels.fromJson(Map<String, dynamic> json) => HrLeaveRequestModels(
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
    int? eLeaveId;
    int? employeeId;
    String? leaveTypeName;
    DateTime? startDate;
    DateTime? endDate;
    String? details;
    int? approvedBy;
    String? remark;
    int? lStatusId;
    String? lStatusName;
    String? fullnameSubstitute;
    int? statusApproved;
    String? profile;
    String? profileApproved;
    String? profileSubstitute;
    String? fullnameApproved;
    num? annualLeave;
    int? sickLeave;
    int? lakitLeave;
    num? khrpLeave;

    Datum({
        this.eLeaveId,
        this.employeeId,
        this.leaveTypeName,
        this.startDate,
        this.endDate,
        this.details,
        this.approvedBy,
        this.remark,
        this.lStatusId,
        this.lStatusName,
        this.fullnameSubstitute,
        this.statusApproved,
        this.profile,
        this.profileApproved,
        this.profileSubstitute,
        this.fullnameApproved,
        this.annualLeave,
        this.sickLeave,
        this.lakitLeave,
        this.khrpLeave,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        eLeaveId: json["e_leave_id"],
        employeeId: json["employee_id"],
        leaveTypeName: json["leave_type_name"],
        startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
        endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        details: json["details"],
        approvedBy: json["approved_by"],
        remark: json["remark"],
        lStatusId: json["l_status_id"],
        lStatusName: json["l_status_name"],
        fullnameSubstitute: json["fullname_substitute"],
        statusApproved: json["status_approved"],
        profile: json["profile"],
        profileApproved: json["profile_approved"],
        profileSubstitute: json["profile_substitute"],
        fullnameApproved: json["fullname_approved"],
        annualLeave: json["annual_leave"]?.toDouble(),
        sickLeave: json["sick_leave"],
        lakitLeave: json["lakit_leave"],
        khrpLeave: json["khrp_leave"],
    );

    Map<String, dynamic> toJson() => {
        "e_leave_id": eLeaveId,
        "employee_id": employeeId,
        "leave_type_name": leaveTypeName,
        "start_date": "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "end_date": "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        "details": details,
        "approved_by": approvedBy,
        "remark": remark,
        "l_status_id": lStatusId,
        "l_status_name": lStatusName,
        "fullname_substitute": fullnameSubstitute,
        "status_approved": statusApproved,
        "profile": profile,
        "profile_approved": profileApproved,
        "profile_substitute": profileSubstitute,
        "fullname_approved": fullnameApproved,
        "annual_leave": annualLeave,
        "sick_leave": sickLeave,
        "lakit_leave": lakitLeave,
        "khrp_leave": khrpLeave,
    };
}
