// To parse this JSON data, do
//
//     final notificationLists = notificationListsFromJson(jsonString);

import 'dart:convert';

NotificationLists notificationListsFromJson(String str) => NotificationLists.fromJson(json.decode(str));

String notificationListsToJson(NotificationLists data) => json.encode(data.toJson());

class NotificationLists {
    NotificationLists({
        this.data,
        this.totalRows,
        this.totalPage,
        this.count,
        this.currentPage,
    });

    List<Datum>? data;
    int? totalRows;
    int? totalPage;
    int? count;
    int? currentPage;

    factory NotificationLists.fromJson(Map<String, dynamic> json) => NotificationLists(
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        totalRows: json["totalRows"],
        totalPage: json["totalPage"],
        count: json["count"],
        currentPage: json["currentPage"],
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "totalRows": totalRows,
        "totalPage": totalPage,
        "count": count,
        "currentPage": currentPage,
    };
}

class Datum {
    Datum({
        this.notificationId,
        this.userId,
        this.notificationType,
        this.notificationTitle,
        this.notificationBody,
        this.url,
        this.isRead,
        this.time,
    });

    int? notificationId;
    int? userId;
    int? notificationType;
    String? notificationTitle;
    String? notificationBody;
    String? url;
    int? isRead;
    DateTime? time;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        notificationId: json["notification_id"],
        userId: json["user_id"],
        notificationType: json["notification_type"],
        notificationTitle: json["notification_title"],
        notificationBody: json["notification_body"],
        url: json["url"],
        isRead: json["is_read"],
        time: json["time"] == null ? null : DateTime.parse(json["time"]),
    );

    Map<String, dynamic> toJson() => {
        "notification_id": notificationId,
        "user_id": userId,
        "notification_type": notificationType,
        "notification_title": notificationTitle,
        "notification_body": notificationBody,
        "url": url,
        "is_read": isRead,
        "time": time?.toIso8601String(),
    };
}
