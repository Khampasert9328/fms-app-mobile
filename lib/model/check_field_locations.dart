// To parse this JSON data, do
//
//     final checkFieldLocations = checkFieldLocationsFromJson(jsonString);

import 'dart:convert';

CheckFieldLocations checkFieldLocationsFromJson(String str) => CheckFieldLocations.fromJson(json.decode(str));

String checkFieldLocationsToJson(CheckFieldLocations data) => json.encode(data.toJson());

class CheckFieldLocations {
    CheckFieldLocations({
        required this.status,
        required this.data,
    });

    int status;
    Data data;

    factory CheckFieldLocations.fromJson(Map<String, dynamic> json) => CheckFieldLocations(
        status: json["status"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
    };
}

class Data {
    Data({
        required this.code,
        required this.message,
        required this.status,
    });

    int code;
    String message;
    String status;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        code: json["code"],
        message: json["message"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "status": status,
    };
}