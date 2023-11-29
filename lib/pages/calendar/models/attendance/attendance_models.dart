// To parse this JSON data, do
//
//     final attendanceCalendaModels = attendanceCalendaModelsFromJson(jsonString);

import 'dart:convert';

AttendanceCalendaModels attendanceCalendaModelsFromJson(String str) => AttendanceCalendaModels.fromJson(json.decode(str));

String attendanceCalendaModelsToJson(AttendanceCalendaModels data) => json.encode(data.toJson());

class AttendanceCalendaModels {
    int? status;
    List<Datum>? data;

    AttendanceCalendaModels({
        this.status,
        this.data,
    });

    factory AttendanceCalendaModels.fromJson(Map<String, dynamic> json) => AttendanceCalendaModels(
        status: json["status"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    DateTime? date;

    Datum({
        this.date,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
    );

    Map<String, dynamic> toJson() => {
        "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    };
}
