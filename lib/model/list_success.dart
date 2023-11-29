// To parse this JSON data, do
//
//     final listSuccess = listSuccessFromJson(jsonString);

import 'dart:convert';

ListSuccess listSuccessFromJson(String str) => ListSuccess.fromJson(json.decode(str));

String listSuccessToJson(ListSuccess data) => json.encode(data.toJson());

class ListSuccess {
    ListSuccess({
        this.status,
        this.data,
    });

    int? status;
    List<Datum>? data;

    factory ListSuccess.fromJson(Map<String, dynamic> json) => ListSuccess(
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
        this.eLeaveId,
        this.startDate,
        this.endDate,
        this.details,
        this.isApproved,
        this.remark,
        this.approvedBy,
        this.employeeSubstitute,
        this.profileImgSubstitute,
        this.employeeSubstituteId,
        this.createdAt,
        this.updatedAt,
    });

    int? eLeaveId;
    DateTime? startDate;
    DateTime? endDate;
    String? details;
    int? isApproved;
    dynamic remark;
    dynamic approvedBy;
    String? employeeSubstitute;
    String? profileImgSubstitute;
    int? employeeSubstituteId;
    DateTime? createdAt;
    DateTime? updatedAt;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        eLeaveId: json["e_leave_id"],
        startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
        endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        details: json["details"],
        isApproved: json["is_approved"],
        remark: json["remark"],
        approvedBy: json["approved_by"],
        employeeSubstitute: json["employee_substitute"],
        profileImgSubstitute: json["profile_img_substitute"],
        employeeSubstituteId: json["employee_substitute_id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "e_leave_id": eLeaveId,
        "start_date": "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "end_date": "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        "details": details,
        "is_approved": isApproved,
        "remark": remark,
        "approved_by": approvedBy,
        "employee_substitute": employeeSubstitute,
        "profile_img_substitute": profileImgSubstitute,
        "employee_substitute_id": employeeSubstituteId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
