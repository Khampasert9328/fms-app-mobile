// To parse this JSON data, do
//
//     final leaveFriendsModels = leaveFriendsModelsFromJson(jsonString);

import 'dart:convert';

LeaveFriendsModels leaveFriendsModelsFromJson(String str) => LeaveFriendsModels.fromJson(json.decode(str));

String leaveFriendsModelsToJson(LeaveFriendsModels data) => json.encode(data.toJson());

class LeaveFriendsModels {
    int? status;
    String? year;
    List<Datum>? data;

    LeaveFriendsModels({
        this.status,
        this.year,
        this.data,
    });

    factory LeaveFriendsModels.fromJson(Map<String, dynamic> json) => LeaveFriendsModels(
        status: json["status"],
        year: json["year"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "year": year,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    int? eLeaveId;
    DateTime? startDate;
    DateTime? endDate;
    String? details;
    int? approvedBy;
    String? remark;
    String? fullname;
    String? leaveTypeName;
    String? profileImgNew;
    int? lStatusId;
    String? lStatusName;
    String? fullnameSubstitute;
    int? statusApproved;
    String? fullnameApproved;
    int? statusUser;
    int? levelId;
    num? annualLeave;
    num? sickLeave;
    int? lakitLeave;
    num? khrpLeave;

    Datum({
        this.eLeaveId,
        this.startDate,
        this.endDate,
        this.details,
        this.approvedBy,
        this.remark,
        this.fullname,
        this.leaveTypeName,
        this.profileImgNew,
        this.lStatusId,
        this.lStatusName,
        this.fullnameSubstitute,
        this.statusApproved,
        this.fullnameApproved,
        this.statusUser,
        this.levelId,
        this.annualLeave,
        this.sickLeave,
        this.lakitLeave,
        this.khrpLeave,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        eLeaveId: json["e_leave_id"],
        startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
        endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        details: json["details"],
        approvedBy: json["approved_by"],
        remark: json["remark"],
        fullname: json["fullname"],
        leaveTypeName: json["leave_type_name"],
        profileImgNew: json["profile_img_new"],
        lStatusId: json["l_status_id"],
        lStatusName: json["l_status_name"],
        fullnameSubstitute: json["fullname_substitute"],
        statusApproved: json["status_approved"],
        fullnameApproved: json["fullname_approved"],
        statusUser: json["status_user"],
        levelId: json["level_id"],
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
        "l_status_id": lStatusId,
        "l_status_name": lStatusName,
        "fullname_substitute": fullnameSubstitute,
        "status_approved": statusApproved,
        "fullname_approved": fullnameApproved,
        "status_user": statusUser,
        "level_id": levelId,
        "annual_leave": annualLeave,
        "sick_leave": sickLeave,
        "lakit_leave": lakitLeave,
        "khrp_leave": khrpLeave,
    };
}
