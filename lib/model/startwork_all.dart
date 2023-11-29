class StartworkAll {
  int? attendanceId;
  DateTime? checkinTime;
  DateTime? checkoutTime;
  String? date;
  DateTime? dateOld;
  int? totalSeconds;

  StartworkAll(
      {this.attendanceId,
      this.checkinTime,
      this.checkoutTime,
      this.date,
      this.dateOld,
      this.totalSeconds});

  StartworkAll.fromJson(Map<String, dynamic> json) {
    attendanceId = json['attendance_id'];
    checkinTime = json['checkin_time'] == null ? null : DateTime.parse(json["checkin_time"]);
    checkoutTime = json['checkout_time'] == null ? null : DateTime.parse(json["checkout_time"]);
    date = json['date'];
    dateOld = json['dateOld'] == null ? null : DateTime.parse(json["dateOld"]);
    totalSeconds = json['total_seconds'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attendance_id'] = this.attendanceId;
    data['checkin_time'] = checkinTime?.toIso8601String();
    data['checkout_time'] = checkoutTime?.toIso8601String();
    data['date'] = this.date;
    data['dateOld'] = dateOld?.toIso8601String();
    data['total_seconds'] = this.totalSeconds;
    return data;
  }
}