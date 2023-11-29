class AttendanceHistory {
  String? date;
  String? dateType;
  int? isAttend;
  String? checkin;
  String? checkout;
  int? sumTotalMinutes;

  AttendanceHistory(
      {this.date,
      this.dateType,
      this.isAttend,
      this.checkin,
      this.checkout,
      this.sumTotalMinutes});

  AttendanceHistory.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    dateType = json['date_type'];
    isAttend = json['is_attend'];
    checkin = json['checkin'];
    checkout = json['checkout'];
    sumTotalMinutes = json['sum_total_minutes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['date_type'] = this.dateType;
    data['is_attend'] = this.isAttend;
    data['checkin'] = this.checkin;
    data['checkout'] = this.checkout;
    data['sum_total_minutes'] = this.sumTotalMinutes;
    return data;
  }
}