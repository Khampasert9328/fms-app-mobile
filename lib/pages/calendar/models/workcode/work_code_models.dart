// To parse this JSON data, do
//
//     final workCodeModel = workCodeModelFromJson(jsonString);

import 'dart:convert';

WorkCodeModel workCodeModelFromJson(String str) => WorkCodeModel.fromJson(json.decode(str));

String workCodeModelToJson(WorkCodeModel data) => json.encode(data.toJson());

class WorkCodeModel {
  int? status;
  List<Datum>? data;

  WorkCodeModel({
    this.status,
    this.data,
  });

  factory WorkCodeModel.fromJson(Map<String, dynamic> json) => WorkCodeModel(
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
