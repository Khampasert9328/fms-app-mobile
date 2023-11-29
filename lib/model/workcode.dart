class WorkCode {
  int? workcodeId;
  String? workcode;
  int? divisionId;
  int? workTypeId;

  WorkCode({this.workcodeId, this.workcode, this.divisionId});

  WorkCode.fromJson(Map<String, dynamic> json) {
    workcodeId = json['workcode_id'];
    workcode = json['workcode'];
    divisionId = json['division_id'];
    workTypeId = json['work_type_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['workcode_id'] = this.workcodeId;
    data['workcode'] = this.workcode;
    data['division_id'] = this.divisionId;
    data['work_type_id'] = this.workTypeId;
    return data;
  }
}