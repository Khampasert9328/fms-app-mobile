// To parse this JSON data, do
//
//     final locationAll = locationAllFromJson(jsonString);

import 'dart:convert';

List<LocationAll> locationAllFromJson(String str) => List<LocationAll>.from(json.decode(str).map((x) => LocationAll.fromJson(x)));

String locationAllToJson(List<LocationAll> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LocationAll {
    LocationAll({
        this.fieldLocationId,
        this.name,
        this.description,
        this.latLng,
        this.img,
        this.distance,
        this.address,
        this.provinceId,
        this.startDate,
    });

    int? fieldLocationId;
    String? name;
    String? description;
    String? latLng;
    String? img;
    int? distance;
    String? address;
    int? provinceId;
    DateTime? startDate;

    factory LocationAll.fromJson(Map<String, dynamic> json) => LocationAll(
        fieldLocationId: json["field_location_id"],
        name: json["name"],
        description: json["description"],
        latLng: json["lat_lng"],
         img: json["img"],
        distance: json["distance"],
        address: json["address"],
        provinceId: json["province_id"],
        startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
    );

    Map<String, dynamic> toJson() => {
        "field_location_id": fieldLocationId,
        "name": name,
        "description": description,
        "lat_lng": latLng,
        "img": img,
        "distance": distance,
        "address": address,
        "province_id": provinceId,
        "start_date": startDate?.toIso8601String(),
    };
}
