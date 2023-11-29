// To parse this JSON data, do
//
//     final timeSheetsCalendaModels = timeSheetsCalendaModelsFromJson(jsonString);

import 'dart:convert';

TimeSheetsCalendaModels timeSheetsCalendaModelsFromJson(String str) => TimeSheetsCalendaModels.fromJson(json.decode(str));

String timeSheetsCalendaModelsToJson(TimeSheetsCalendaModels data) => json.encode(data.toJson());

class TimeSheetsCalendaModels {
    int? status;
    List<Datum>? data;

    TimeSheetsCalendaModels({
        this.status,
        this.data,
    });

    factory TimeSheetsCalendaModels.fromJson(Map<String, dynamic> json) => TimeSheetsCalendaModels(
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
    int? workcode;
    int? status;

    Datum({
        this.date,
        this.workcode,
        this.status,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        workcode: json["workcode"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "workcode": workcode,
        "status": status,
    };
}
