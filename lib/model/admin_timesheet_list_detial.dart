// To parse this JSON data, do
//
//     final timesheetListDetial = timesheetListDetialFromJson(jsonString);

import 'dart:convert';

AdminTimesheetListDetial timesheetListDetialFromJson(String str) => AdminTimesheetListDetial.fromJson(json.decode(str));

String timesheetListDetialToJson(AdminTimesheetListDetial data) => json.encode(data.toJson());

class AdminTimesheetListDetial {
    AdminTimesheetListDetial({
        this.date,
        this.timesheetApproved,
        this.timesheetApprovedRemark,
        this.ioList,
    });

    String? date;
    String? timesheetApproved;
    String? timesheetApprovedRemark;
    List<IoList>? ioList ;

    factory AdminTimesheetListDetial.fromJson(Map<String, dynamic> json) => AdminTimesheetListDetial(
        date: json["date"],
        timesheetApproved: json["timesheet_approved"],
        timesheetApprovedRemark: json["timesheet_approved_remark"],
        ioList: json["io_list"] == null ? [] : List<IoList>.from(json["io_list"]!.map((x) => IoList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "date": date,
        "timesheet_approved": timesheetApproved,
        "timesheet_approved_remark": timesheetApprovedRemark,
        "io_list": ioList == null ? [] : List<dynamic>.from(ioList!.map((x) => x.toJson())),
    };
}

class IoList {
    IoList({
        this.attendanceId,
        this.checkinTime,
        this.checkoutTime,
        this.sumTotalMinutes,
    });

    int? attendanceId;
    String? checkinTime;
    String? checkoutTime;
    int? sumTotalMinutes;

    factory IoList.fromJson(Map<String, dynamic> json) => IoList(
        attendanceId: json["attendance_id"],
        checkinTime: json["checkin_time"],
        checkoutTime: json["checkout_time"]  ,
        sumTotalMinutes: json["sum_total_minutes"],
    );

    Map<String, dynamic> toJson() => {
        "attendance_id": attendanceId,
        "checkin_time": checkinTime,
        "checkout_time": checkoutTime,
        "sum_total_minutes": sumTotalMinutes,
    };
}
