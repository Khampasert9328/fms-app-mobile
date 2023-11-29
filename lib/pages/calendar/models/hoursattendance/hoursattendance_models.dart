// To parse this JSON data, do
//
//     final getHoursAttendanceModels = getHoursAttendanceModelsFromJson(jsonString);

import 'dart:convert';

GetHoursAttendanceModels getHoursAttendanceModelsFromJson(String str) => GetHoursAttendanceModels.fromJson(json.decode(str));

String getHoursAttendanceModelsToJson(GetHoursAttendanceModels data) => json.encode(data.toJson());

class GetHoursAttendanceModels {
    int? status;
    double? data;

    GetHoursAttendanceModels({
        this.status,
        this.data,
    });

    factory GetHoursAttendanceModels.fromJson(Map<String, dynamic> json) => GetHoursAttendanceModels(
        status: json["status"],
        data: json["data"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data,
    };
}
