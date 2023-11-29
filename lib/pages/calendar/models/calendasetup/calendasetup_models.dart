// To parse this JSON data, do
//
//     final calendaSetUpModels = calendaSetUpModelsFromJson(jsonString);

import 'dart:convert';

CalendaSetUpModels calendaSetUpModelsFromJson(String str) => CalendaSetUpModels.fromJson(json.decode(str));

String calendaSetUpModelsToJson(CalendaSetUpModels data) => json.encode(data.toJson());

class CalendaSetUpModels {
    int? status;
    List<Datum>? data;

    CalendaSetUpModels({
        this.status,
        this.data,
    });

    factory CalendaSetUpModels.fromJson(Map<String, dynamic> json) => CalendaSetUpModels(
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
    String? dateType;
    String? details;

    Datum({
        this.date,
        this.dateType,
        this.details,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        dateType: json["date_type"],
        details: json["details"],
    );

    Map<String, dynamic> toJson() => {
        "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "date_type": dateType,
        "details": details,
    };
}
