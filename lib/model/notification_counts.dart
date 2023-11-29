// To parse this JSON data, do
//
//     final notificationCounts = notificationCountsFromJson(jsonString);

import 'dart:convert';

NotificationCounts notificationCountsFromJson(String str) => NotificationCounts.fromJson(json.decode(str));

String notificationCountsToJson(NotificationCounts data) => json.encode(data.toJson());

class NotificationCounts {
    NotificationCounts({
        this.status,
        this.data,
    });

    int? status;
    Data? data;

    factory NotificationCounts.fromJson(Map<String, dynamic> json) => NotificationCounts(
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
        this.count,
    });

    int? count;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        count: json["count"],
    );

    Map<String, dynamic> toJson() => {
        "count": count,
    };
}
