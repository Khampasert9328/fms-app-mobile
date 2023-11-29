// To parse this JSON data, do
//
//     final workCodeModels = workCodeModelsFromJson(jsonString);

import 'dart:convert';

WorkCodeModels workCodeModelsFromJson(String str) => WorkCodeModels.fromJson(json.decode(str));

String workCodeModelsToJson(WorkCodeModels data) => json.encode(data.toJson());

class WorkCodeModels {
    int? status;
    List<Datum>? data;

    WorkCodeModels({
        this.status,
        this.data,
    });

    factory WorkCodeModels.fromJson(Map<String, dynamic> json) => WorkCodeModels(
        status: json["status"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    int? workcodeId;
    String? workcode;
    int? divisionId;
    int? workTypeId;

    Datum({
        this.workcodeId,
        this.workcode,
        this.divisionId,
        this.workTypeId,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        workcodeId: json["workcode_id"],
        workcode: json["workcode"],
        divisionId: json["division_id"],
        workTypeId: json["work_type_id"],
    );

    Map<String, dynamic> toJson() => {
        "workcode_id": workcodeId,
        "workcode": workcode,
        "division_id": divisionId,
        "work_type_id": workTypeId,
    };
}
