// To parse this JSON data, do
//
//     final userDetail = userDetailFromJson(jsonString);

import 'dart:convert';

UserDetail userDetailFromJson(String str) => UserDetail.fromJson(json.decode(str));

String userDetailToJson(UserDetail data) => json.encode(data.toJson());

class UserDetail {
    UserDetail({
        this.status,
        this.data,
    });

    int? status;
    Data? data;

    factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
        status: json["status"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
    };
}

class Data {
    Data({
        this.employeeId,
        this.lang,
        this.levelId,
        this.departmentId,
        this.divisionId,
        this.isSupervisor,
        this.isSa,
        this.fieldLocationId,
        this.isSecretary,
        this.fullname,
        this.fullnameEn,
        this.level,
        this.divisionName,
        this.departmentName,
        this.workingType,
        this.profileImg,
        this.workingArea,
        this.gender,
        this.email,
        this.dob,
        this.age,
        this.mobile,
        this.mapUrl,
        this.profileImgNew,
    });

    int? employeeId;
    String? lang;
    int? levelId;
    int? departmentId;
    int? divisionId;
    int? isSupervisor;
    int? isSa;
    int? fieldLocationId;
    int? isSecretary;
    String? fullname;
    String? fullnameEn;
    String? level;
    String? divisionName;
    String? departmentName;
    String? workingType;
    String? profileImg;
    String? workingArea;
    String? gender;
    String? email;
    DateTime? dob;
    int? age;
    String? mobile;
    String? mapUrl;
    String? profileImgNew;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        employeeId: json["employee_id"],
        lang: json["lang"],
        levelId: json["level_id"],
        departmentId: json["department_id"],
        divisionId: json["division_id"],
        isSupervisor: json["is_supervisor"],
        isSa: json["is_sa"],
        fieldLocationId: json["field_location_id"],
        isSecretary: json["is_secretary"],
        fullname: json["fullname"],
        fullnameEn: json["fullname_en"],
        level: json["level"],
        divisionName: json["division_name"],
        departmentName: json["department_name"],
        workingType: json["working_type"],
        profileImg: json["profile_img"],
        workingArea: json["working_area"],
        gender: json["gender"],
        email: json["email"],
        dob: DateTime.parse(json["dob"]),
        age: json["age"],
        mobile: json["mobile"],
        mapUrl: json["map_url"],
        profileImgNew: json["profile_img_new"],
    );

    Map<String, dynamic> toJson() => {
        "employee_id": employeeId,
        "lang": lang,
        "level_id": levelId,
        "department_id": departmentId,
        "division_id": divisionId,
        "is_supervisor": isSupervisor,
        "is_sa": isSa,
        "field_location_id": fieldLocationId,
        "is_secretary": isSecretary,
        "fullname": fullname,
        "fullname_en": fullnameEn,
        "level": level,
        "division_name": divisionName,
        "department_name": departmentName,
        "working_type": workingType,
        "profile_img": profileImg,
        "working_area": workingArea,
        "gender": gender,
        "email": email,
        "dob": dob?.toIso8601String(),
        "age": age,
        "mobile": mobile,
        "map_url": mapUrl,
        "profile_img_new": profileImgNew,
    };
}
