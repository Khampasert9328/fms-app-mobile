class HolidayCalenda {
  String? date;
  String? dateType;
  String? details;

  HolidayCalenda({this.date, this.dateType, this.details});

  HolidayCalenda.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    dateType = json['date_type'];
    details = json['details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['date_type'] = this.dateType;
    data['details'] = this.details;
    return data;
  }
}