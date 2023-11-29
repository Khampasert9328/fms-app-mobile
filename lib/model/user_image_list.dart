// To parse this JSON data, do
//
//     final userImageList = userImageListFromJson(jsonString);

import 'dart:convert';

UserImageList userImageListFromJson(String str) => UserImageList.fromJson(json.decode(str));

String userImageListToJson(UserImageList data) => json.encode(data.toJson());

class UserImageList {
    UserImageList({
        this.status,
        this.data,
    });

    int? status;
    List<Datum>? data;

    factory UserImageList.fromJson(Map<String, dynamic> json) => UserImageList(
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
