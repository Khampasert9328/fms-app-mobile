// To parse this JSON data, do
//
//     final timeSheetPandingDaysModels = timeSheetPandingDaysModelsFromJson(jsonString);

import 'dart:convert';

TimeSheetPandingDaysModels timeSheetPandingDaysModelsFromJson(String str) => TimeSheetPandingDaysModels.fromJson(json.decode(str));

String timeSheetPandingDaysModelsToJson(TimeSheetPandingDaysModels data) => json.encode(data.toJson());

class TimeSheetPandingDaysModels {
    int? status;
    List<Datum>? data;

    TimeSheetPandingDaysModels({
        this.status,
        this.data,
    });

    factory TimeSheetPandingDaysModels.fromJson(Map<String, dynamic> json) => TimeSheetPandingDaysModels(
        status: json["status"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    int? employeeId;
    String? fullname;
    String? fullnameEn;
    String? level;
    String? divisionName;
    String? departmentName;
    String? workingType;
    String? workingArea;
    String? gender;
    String? email;
    int? age;
    DateTime? startProgramDate;
    String? profileImgNew;
    int? pendingDay;

    Datum({
        this.employeeId,
        this.fullname,
        this.fullnameEn,
        this.level,
        this.divisionName,
        this.departmentName,
        this.workingType,
        this.workingArea,
        this.gender,
        this.email,
        this.age,
        this.startProgramDate,
        this.profileImgNew,
        this.pendingDay,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        employeeId: json["employee_id"],
        fullname: json["fullname"],
        fullnameEn: json["fullname_en"],
        level: json["level"],
        divisionName: json["division_name"],
        departmentName: json["department_name"],
        workingType: json["working_type"],
        workingArea: json["working_area"],
        gender: json["gender"],
        email: json["email"],
        age: json["age"],
        startProgramDate: json["start_program_date"] == null ? null : DateTime.parse(json["start_program_date"]),
        profileImgNew: json["profile_img_new"],
        pendingDay: json["pending_day"],
    );

    Map<String, dynamic> toJson() => {
        "employee_id": employeeId,
        "fullname": fullname,
        "fullname_en": fullnameEn,
        "level": level,
        "division_name": divisionName,
        "department_name": departmentName,
        "working_type": workingType,
        "working_area": workingArea,
        "gender": gender,
        "email": email,
        "age": age,
        "start_program_date": startProgramDate?.toIso8601String(),
        "profile_img_new": profileImgNew,
        "pending_day": pendingDay,
    };
}
