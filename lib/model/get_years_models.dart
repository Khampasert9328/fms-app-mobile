// To parse this JSON data, do
//
//     final getYearsModels = getYearsModelsFromJson(jsonString);

import 'dart:convert';

GetYearsModels getYearsModelsFromJson(String str) => GetYearsModels.fromJson(json.decode(str));

String getYearsModelsToJson(GetYearsModels data) => json.encode(data.toJson());

class GetYearsModels {
    int? status;
    List<Datum>? data;

    GetYearsModels({
        this.status,
        this.data,
    });

    factory GetYearsModels.fromJson(Map<String, dynamic> json) => GetYearsModels(
        status: json["status"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    int? pureYear;

    Datum({
        this.pureYear,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        pureYear: json["pure_year"],
    );

    Map<String, dynamic> toJson() => {
        "pure_year": pureYear,
    };
}
