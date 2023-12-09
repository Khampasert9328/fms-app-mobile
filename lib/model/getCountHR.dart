// To parse this JSON data, do
//
//     final getCountOverTimeHrApproveModels = getCountOverTimeHrApproveModelsFromJson(jsonString);

import 'dart:convert';

GetCountOverTimeHrApproveModels getCountOverTimeHrApproveModelsFromJson(String str) => GetCountOverTimeHrApproveModels.fromJson(json.decode(str));

String getCountOverTimeHrApproveModelsToJson(GetCountOverTimeHrApproveModels data) => json.encode(data.toJson());

class GetCountOverTimeHrApproveModels {
    int? status;
    int? code;
    String? msg;
    Data? data;

    GetCountOverTimeHrApproveModels({
        this.status,
        this.code,
        this.msg,
        this.data,
    });

    factory GetCountOverTimeHrApproveModels.fromJson(Map<String, dynamic> json) => GetCountOverTimeHrApproveModels(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data?.toJson(),
    };
}

class Data {
    int? overtimeApprove;

    Data({
        this.overtimeApprove,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        overtimeApprove: json["overtime_approve"],
    );

    Map<String, dynamic> toJson() => {
        "overtime_approve": overtimeApprove,
    };
}
