// To parse this JSON data, do
//
//     final overTimeCountModels = overTimeCountModelsFromJson(jsonString);

import 'dart:convert';

OverTimeCountModels overTimeCountModelsFromJson(String str) => OverTimeCountModels.fromJson(json.decode(str));

String overTimeCountModelsToJson(OverTimeCountModels data) => json.encode(data.toJson());

class OverTimeCountModels {
    int status;
    int code;
    String msg;
    Data data;

    OverTimeCountModels({
        required this.status,
        required this.code,
        required this.msg,
        required this.data,
    });

    factory OverTimeCountModels.fromJson(Map<String, dynamic> json) => OverTimeCountModels(
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
