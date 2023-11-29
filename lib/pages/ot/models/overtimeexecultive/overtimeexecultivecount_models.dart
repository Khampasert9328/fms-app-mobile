// To parse this JSON data, do
//
//     final getOvertimeExecutiveCountModels = getOvertimeExecutiveCountModelsFromJson(jsonString);

import 'dart:convert';

GetOvertimeExecutiveCountModels getOvertimeExecutiveCountModelsFromJson(String str) => GetOvertimeExecutiveCountModels.fromJson(json.decode(str));

String getOvertimeExecutiveCountModelsToJson(GetOvertimeExecutiveCountModels data) => json.encode(data.toJson());

class GetOvertimeExecutiveCountModels {
    int status;
    int code;
    String msg;
    Data data;

    GetOvertimeExecutiveCountModels({
        required this.status,
        required this.code,
        required this.msg,
        required this.data,
    });

    factory GetOvertimeExecutiveCountModels.fromJson(Map<String, dynamic> json) => GetOvertimeExecutiveCountModels(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data.toJson(),
    };
}

class Data {
    int overtimeApprove;

    Data({
        required this.overtimeApprove,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        overtimeApprove: json["overtime_approve"],
    );

    Map<String, dynamic> toJson() => {
        "overtime_approve": overtimeApprove,
    };
}
