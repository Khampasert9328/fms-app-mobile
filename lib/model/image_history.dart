// To parse this JSON data, do
//
//     final imageHistory = imageHistoryFromJson(jsonString);

import 'dart:convert';

ImageHistory imageHistoryFromJson(String str) => ImageHistory.fromJson(json.decode(str));

String imageHistoryToJson(ImageHistory data) => json.encode(data.toJson());

class ImageHistory {
    ImageHistory({
        this.status,
        this.data,
    });

    int? status;
    List<Datum>? data;

    factory ImageHistory.fromJson(Map<String, dynamic> json) => ImageHistory(
        status: json["status"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        this.attendanceImgurl,
        this.date,
    });

    String? attendanceImgurl;
    DateTime? date;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        attendanceImgurl: json["attendance_imgurl"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
    );

    Map<String, dynamic> toJson() => {
        "attendance_imgurl": attendanceImgurl,
        "date": date?.toIso8601String(),
    };
}
