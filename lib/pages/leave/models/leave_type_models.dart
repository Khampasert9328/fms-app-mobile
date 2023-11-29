// To parse this JSON data, do
//
//     final leaveTypeModels = leaveTypeModelsFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/src/material/dropdown.dart';

LeaveTypeModels leaveTypeModelsFromJson(String str) => LeaveTypeModels.fromJson(json.decode(str));

String leaveTypeModelsToJson(LeaveTypeModels data) => json.encode(data.toJson());

class LeaveTypeModels {
    int status;
    List<LeaveType> data;

    LeaveTypeModels({
        required this.status,
        required this.data,
    });

    factory LeaveTypeModels.fromJson(Map<String, dynamic> json) => LeaveTypeModels(
        status: json["status"],
        data: List<LeaveType>.from(json["data"].map((x) => LeaveType.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };

  map(DropdownMenuItem<String> Function(LeaveType item) param0) {}
}

class LeaveType {
    int leaveTypeId;
    String leaveTypeName;

    LeaveType({
        required this.leaveTypeId,
        required this.leaveTypeName,
    });

    factory LeaveType.fromJson(Map<String, dynamic> json) => LeaveType(
        leaveTypeId: json["leave_type_id"],
        leaveTypeName: json["leave_type_name"],
    );

    Map<String, dynamic> toJson() => {
        "leave_type_id": leaveTypeId,
        "leave_type_name": leaveTypeName,
    };
}
