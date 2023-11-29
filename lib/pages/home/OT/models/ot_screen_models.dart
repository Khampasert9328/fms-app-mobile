// To parse this JSON data, do
//
//     final workTypeModels = workTypeModelsFromJson(jsonString);

import 'dart:convert';

WorkTypeModels workTypeModelsFromJson(String str) => WorkTypeModels.fromJson(json.decode(str));

String workTypeModelsToJson(WorkTypeModels data) => json.encode(data.toJson());

class WorkTypeModels {
    int? status;
    List<WorkTypeAll>? data;

    WorkTypeModels({
        this.status,
        this.data,
    });

    factory WorkTypeModels.fromJson(Map<String, dynamic> json) => WorkTypeModels(
        status: json["status"],
        data: json["data"] == null ? [] : List<WorkTypeAll>.from(json["data"]!.map((x) => WorkTypeAll.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class WorkTypeAll {
    int? workTypeId;
    String? name;
    String? code;

    WorkTypeAll({
        this.workTypeId,
        this.name,
        this.code,
    });

    factory WorkTypeAll.fromJson(Map<String, dynamic> json) => WorkTypeAll(
        workTypeId: json["work_type_id"],
        name: json["name"],
        code: json["code"],
    );

    Map<String, dynamic> toJson() => {
        "work_type_id": workTypeId,
        "name": name,
        "code": code,
    };
}
