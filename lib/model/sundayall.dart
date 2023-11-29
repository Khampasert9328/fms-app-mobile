class SundayAll {
  String? sunday;

  SundayAll({this.sunday});

  SundayAll.fromJson(Map<String, dynamic> json) {
    sunday = json['sunday'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sunday'] = this.sunday;
    return data;
  }
}
