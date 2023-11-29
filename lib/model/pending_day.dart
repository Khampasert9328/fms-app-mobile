// To parse this JSON data, do
//
//     final pendingDay = pendingDayFromJson(jsonString);

import 'dart:convert';

PendingDay pendingDayFromJson(String str) => PendingDay.fromJson(json.decode(str));

String pendingDayToJson(PendingDay data) => json.encode(data.toJson());

class PendingDay {
    PendingDay({
        this.status,
        this.data,
    });

    int? status;
    Data? data;

    factory PendingDay.fromJson(Map<String, dynamic> json) => PendingDay(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
    };
}

class Data {
    Data({
        this.pendingDay,
    });

    int? pendingDay;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        pendingDay: json["pending_day"],
    );

    Map<String, dynamic> toJson() => {
        "pending_day": pendingDay,
    };
}
