// To parse this JSON data, do
//
//     final getCountOverTimePrApproveModels = getCountOverTimePrApproveModelsFromJson(jsonString);

import 'dart:convert';

GetCountOverTimePrApproveModels getCountOverTimePrApproveModelsFromJson(String str) => GetCountOverTimePrApproveModels.fromJson(json.decode(str));

String getCountOverTimePrApproveModelsToJson(GetCountOverTimePrApproveModels data) => json.encode(data.toJson());

class GetCountOverTimePrApproveModels {
    int? status;
    int? code;
    String? msg;
    Data? data;

    GetCountOverTimePrApproveModels({
        this.status,
        this.code,
        this.msg,
        this.data,
    });

    factory GetCountOverTimePrApproveModels.fromJson(Map<String, dynamic> json) => GetCountOverTimePrApproveModels(
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
