// To parse this JSON data, do
//
//     final leaveModels = leaveModelsFromJson(jsonString);

import 'dart:convert';

LeaveModels leaveModelsFromJson(String str) => LeaveModels.fromJson(json.decode(str));

String leaveModelsToJson(LeaveModels data) => json.encode(data.toJson());

class LeaveModels {
    int? status;
    Data? data;

    LeaveModels({
        this.status,
        this.data,
    });

    factory LeaveModels.fromJson(Map<String, dynamic> json) => LeaveModels(
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
    List<Leaf>? leaves;

    Data({
        this.year,
        this.leaves,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        year: json["year"],
        leaves: json["leaves"] == null ? [] : List<Leaf>.from(json["leaves"]!.map((x) => Leaf.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "year": year,
        "leaves": leaves == null ? [] : List<dynamic>.from(leaves!.map((x) => x.toJson())),
    };
}

class Leaf {
    int? eLeaveId;
    DateTime? startDate;
    DateTime? endDate;
    String? details;
    dynamic approvedBy;
    dynamic remark;
    String? fullname;
    String? leaveTypeName;
    String? profileImgNew;
    String? profileImgNewSubstitute;
    int? lStatusId;
    String? lStatusName;
    String? fullnameSubstitute;
    dynamic fullnameApproved;
    String? profileImgNewApproved;
    int? annualLeave;
    int? sickLeave;
    int? lakitLeave;
    int? khrpLeave;

    Leaf({
        this.eLeaveId,
        this.startDate,
        this.endDate,
        this.details,
        this.approvedBy,
        this.remark,
        this.fullname,
        this.leaveTypeName,
        this.profileImgNew,
        this.profileImgNewSubstitute,
        this.lStatusId,
        this.lStatusName,
        this.fullnameSubstitute,
        this.fullnameApproved,
        this.profileImgNewApproved,
        this.annualLeave,
        this.sickLeave,
        this.lakitLeave,
        this.khrpLeave,
    });

    factory Leaf.fromJson(Map<String, dynamic> json) => Leaf(
        eLeaveId: json["e_leave_id"],
        startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
        endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        details: json["details"],
        approvedBy: json["approved_by"],
        remark: json["remark"],
        fullname: json["fullname"],
        leaveTypeName: json["leave_type_name"],
        profileImgNew: json["profile_img_new"],
        profileImgNewSubstitute: json["profile_img_new_substitute"],
        lStatusId: json["l_status_id"],
        lStatusName: json["l_status_name"],
        fullnameSubstitute: json["fullname_substitute"],
        fullnameApproved: json["fullname_approved"],
        profileImgNewApproved: json["profile_img_new_approved"],
        annualLeave: json["annual_leave"],
        sickLeave: json["sick_leave"],
        lakitLeave: json["lakit_leave"],
        khrpLeave: json["khrp_leave"],
    );

    Map<String, dynamic> toJson() => {
        "e_leave_id": eLeaveId,
        "start_date": "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "end_date": "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        "details": details,
        "approved_by": approvedBy,
        "remark": remark,
        "fullname": fullname,
        "leave_type_name": leaveTypeName,
        "profile_img_new": profileImgNew,
        "profile_img_new_substitute": profileImgNewSubstitute,
        "l_status_id": lStatusId,
        "l_status_name": lStatusName,
        "fullname_substitute": fullnameSubstitute,
        "fullname_approved": fullnameApproved,
        "profile_img_new_approved": profileImgNewApproved,
        "annual_leave": annualLeave,
        "sick_leave": sickLeave,
        "lakit_leave": lakitLeave,
        "khrp_leave": khrpLeave,
    };
}
