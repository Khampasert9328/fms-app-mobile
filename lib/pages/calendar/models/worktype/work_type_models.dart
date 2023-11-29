// To parse this JSON data, do
//
//     final workTypeModel = workTypeModelFromJson(jsonString);

import 'dart:convert';

WorkTypeModel workTypeModelFromJson(String str) => WorkTypeModel.fromJson(json.decode(str));

String workTypeModelToJson(WorkTypeModel data) => json.encode(data.toJson());

class WorkTypeModel {
  int? status;
  List<Datum>? data;

  WorkTypeModel({
    this.status,
    this.data,
  });

  factory WorkTypeModel.fromJson(Map<String, dynamic> json) => WorkTypeModel(
    status: json["status"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  int? workTypeId;
  String? name;
  String? code;

  Datum({
    this.workTypeId,
    this.name,
    this.code,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
