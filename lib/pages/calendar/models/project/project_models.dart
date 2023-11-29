// To parse this JSON data, do
//
//     final projectModel = projectModelFromJson(jsonString);

import 'dart:convert';

ProjectModel projectModelFromJson(String str) => ProjectModel.fromJson(json.decode(str));

String projectModelToJson(ProjectModel data) => json.encode(data.toJson());

class ProjectModel {
  int? status;
  List<Datum?>? data;

  ProjectModel({
    this.status,
    this.data,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) => ProjectModel(
    status: json["status"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x?.toJson())),
  };
}

class Datum {
  int? projectId;
  String? projectName;
  String? projectCode;

  Datum({
    this.projectId,
    this.projectName,
    this.projectCode,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    projectId: json["project_id"],
    projectName: json["project_name"],
    projectCode: json["project_code"],
  );

  Map<String, dynamic> toJson() => {
    "project_id": projectId,
    "project_name": projectName,
    "project_code": projectCode,
  };
}
