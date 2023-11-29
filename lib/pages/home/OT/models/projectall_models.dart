// To parse this JSON data, do
//
//     final projectAllModels = projectAllModelsFromJson(jsonString);

import 'dart:convert';

ProjectAllModels projectAllModelsFromJson(String str) => ProjectAllModels.fromJson(json.decode(str));

String projectAllModelsToJson(ProjectAllModels data) => json.encode(data.toJson());

class ProjectAllModels {
    int? status;
    List<Datum>? data;

    ProjectAllModels({
        this.status,
        this.data,
    });

    factory ProjectAllModels.fromJson(Map<String, dynamic> json) => ProjectAllModels(
        status: json["status"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    int? projectId;
    String? projectName;

    Datum({
        this.projectId,
        this.projectName,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        projectId: json["project_id"],
        projectName: json["project_name"],
    );

    Map<String, dynamic> toJson() => {
        "project_id": projectId,
        "project_name": projectName,
    };
}
