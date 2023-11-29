// To parse this JSON data, do
//
//     final totalCountModels = totalCountModelsFromJson(jsonString);

import 'dart:convert';

TotalCountModels totalCountModelsFromJson(String str) => TotalCountModels.fromJson(json.decode(str));

String totalCountModelsToJson(TotalCountModels data) => json.encode(data.toJson());

class TotalCountModels {
    int? status;
    int? code;
    String? msg;
    Data? data;

    TotalCountModels({
        this.status,
        this.code,
        this.msg,
        this.data,
    });

    factory TotalCountModels.fromJson(Map<String, dynamic> json) => TotalCountModels(
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
