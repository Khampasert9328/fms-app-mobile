// To parse this JSON data, do
//
//     final getTimeAttendanceModels = getTimeAttendanceModelsFromJson(jsonString);

import 'dart:convert';

GetTimeAttendanceModels getTimeAttendanceModelsFromJson(String str) => GetTimeAttendanceModels.fromJson(json.decode(str));

String getTimeAttendanceModelsToJson(GetTimeAttendanceModels data) => json.encode(data.toJson());

class GetTimeAttendanceModels {
    int? status;
    double? data;

    GetTimeAttendanceModels({
        this.status,
        this.data,
    });

    factory GetTimeAttendanceModels.fromJson(Map<String, dynamic> json) => GetTimeAttendanceModels(
        status: json["status"],
        data: json["data"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data,
    };
}
