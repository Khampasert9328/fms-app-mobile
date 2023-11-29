// To parse this JSON data, do
//
//     final leaveCalendaModels = leaveCalendaModelsFromJson(jsonString);

import 'dart:convert';

LeaveCalendaModels leaveCalendaModelsFromJson(String str) => LeaveCalendaModels.fromJson(json.decode(str));

String leaveCalendaModelsToJson(LeaveCalendaModels data) => json.encode(data.toJson());

class LeaveCalendaModels {
    int? status;
    List<Datum>? data;

    LeaveCalendaModels({
        this.status,
        this.data,
    });

    factory LeaveCalendaModels.fromJson(Map<String, dynamic> json) => LeaveCalendaModels(
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
    String? lStatusName;

    Datum({
        this.date,
        this.lStatusName,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        lStatusName: json["l_status_name"],
    );

    Map<String, dynamic> toJson() => {
        "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "l_status_name": lStatusName,
    };
}
