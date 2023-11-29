class HistoryInDay {
  String? attendanceImgurl;
  String? date;
  String? checkin;
  String? checkout;
  String? checkinLatLng;
  String? checkoutLatLng;
  String? fullname;
  String? fullnameEn;
  String? profileImgNew;

  HistoryInDay(
      {this.attendanceImgurl,
      this.date,
      this.checkin,
      this.checkout,
      this.checkinLatLng,
      this.checkoutLatLng,
      this.fullname,
      this.fullnameEn,
      this.profileImgNew});

  HistoryInDay.fromJson(Map<String, dynamic> json) {
    attendanceImgurl = json['attendance_imgurl'];
    date = json['date'];
    checkin = json['checkin'];
    checkout = json['checkout'];
    checkinLatLng = json['checkin_lat_lng'];
    checkoutLatLng = json['checkout_lat_lng'];
    fullname = json['fullname'];
    fullnameEn = json['fullname_en'];
    profileImgNew = json['profile_img_new'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attendance_imgurl'] = this.attendanceImgurl;
    data['date'] = this.date;
    data['checkin'] = this.checkin;
    data['checkout'] = this.checkout;
    data['checkin_lat_lng'] = this.checkinLatLng;
    data['checkout_lat_lng'] = this.checkoutLatLng;
    data['fullname'] = this.fullname;
    data['fullname_en'] = this.fullnameEn;
    data['profile_img_new'] = this.profileImgNew;
    return data;
  }
}