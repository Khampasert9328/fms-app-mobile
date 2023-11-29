//     final checkSundayAndHoliday = checkSundayAndHolidayFromJson(jsonString);

import 'dart:convert';

CheckSundayAndHoliday? checkSundayAndHolidayFromJson(String str) => CheckSundayAndHoliday.fromJson(json.decode(str));

String checkSundayAndHolidayToJson(CheckSundayAndHoliday? data) => json.encode(data!.toJson());

class CheckSundayAndHoliday {
    CheckSundayAndHoliday({
        this.status,
        this.data,
    });

    int? status;
    Data? data;

    factory CheckSundayAndHoliday.fromJson(Map<String, dynamic> json) => CheckSundayAndHoliday(
        status: json["status"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data!.toJson(),
    };
}

class Data {
    Data({
        this.inDayStartwork,
        this.status,
    });

    bool? inDayStartwork;
    String? status;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        inDayStartwork: json["inDay_Startwork"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "inDay_Startwork": inDayStartwork,
        "status": status,
    };
}