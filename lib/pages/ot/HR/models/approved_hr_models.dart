// To parse this JSON data, do
//
//     final approvedHrModels = approvedHrModelsFromJson(jsonString);

import 'dart:convert';

ApprovedHrModels approvedHrModelsFromJson(String str) => ApprovedHrModels.fromJson(json.decode(str));

String approvedHrModelsToJson(ApprovedHrModels data) => json.encode(data.toJson());

class ApprovedHrModels {
    List<String>? eOvertimeId;
    String? isApproved;
    String? remark;

    ApprovedHrModels({
        this.eOvertimeId,
        this.isApproved,
        this.remark,
    });

    factory ApprovedHrModels.fromJson(Map<String, dynamic> json) => ApprovedHrModels(
        eOvertimeId: json["e_overtime_id"] == null ? [] : List<String>.from(json["e_overtime_id"]!.map((x) => x)),
        isApproved: json["is_approved"],
        remark: json["remark"],
    );

    Map<String, dynamic> toJson() => {
        "e_overtime_id": eOvertimeId == null ? [] : List<dynamic>.from(eOvertimeId!.map((x) => x)),
        "is_approved": isApproved,
        "remark": remark,
    };
}
