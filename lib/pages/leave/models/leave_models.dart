// To parse this JSON data, do
//
//     final leaveModels = leaveModelsFromJson(jsonString);

import 'dart:convert';

LeaveModels leaveModelsFromJson(String str) => LeaveModels.fromJson(json.decode(str));

String leaveModelsToJson(LeaveModels data) => json.encode(data.toJson());

class LeaveModels {
    int status;
    Data data;

    LeaveModels({
        required this.status,
        required this.data,
    });

    factory LeaveModels.fromJson(Map<String, dynamic> json) => LeaveModels(
        status: json["status"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
    };
}

class Data {
    String year;
    List<Leaf> leaves;

    Data({
        required this.year,
        required this.leaves,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        year: json["year"],
        leaves: List<Leaf>.from(json["leaves"].map((x) => Leaf.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "year": year,
        "leaves": List<dynamic>.from(leaves.map((x) => x.toJson())),
    };
}

class Leaf {
    int eLeaveId;
    DateTime startDate;
    DateTime endDate;
    String details;
    int isApproved;
    dynamic remark;
    int lStatusId;
    String lStatusName;
    String fullnameSubstitute;

    Leaf({
        required this.eLeaveId,
        required this.startDate,
        required this.endDate,
        required this.details,
        required this.isApproved,
        required this.remark,
        required this.lStatusId,
        required this.lStatusName,
        required this.fullnameSubstitute,
    });

    factory Leaf.fromJson(Map<String, dynamic> json) => Leaf(
        eLeaveId: json["e_leave_id"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        details: json["details"],
        isApproved: json["is_approved"],
        remark: json["remark"],
        lStatusId: json["l_status_id"],
        lStatusName: json["l_status_name"],
        fullnameSubstitute: json["fullname_substitute"],
    );

    Map<String, dynamic> toJson() => {
        "e_leave_id": eLeaveId,
        "start_date": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "end_date": "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "details": details,
        "is_approved": isApproved,
        "remark": remark,
        "l_status_id": lStatusId,
        "l_status_name": lStatusName,
        "fullname_substitute": fullnameSubstitute,
    };
}
