class TeamWork {
  int? employeeId;
  String? fullname;
  String? level;
  String? divisionName;
  String? departmentName;
  String? email;
  String? mobile;
  String? profileImgNew;

  TeamWork(
      {this.employeeId,
      this.fullname,
      this.level,
      this.divisionName,
      this.departmentName,
      this.email,
      this.mobile,
      this.profileImgNew});

  TeamWork.fromJson(Map<String, dynamic> json) {
    employeeId = json['employee_id'];
    fullname = json['fullname'];
    level = json['level'];
    divisionName = json['division_name'];
    departmentName = json['department_name'];
    email = json['email'];
    mobile = json['mobile'];
    profileImgNew = json['profile_img_new'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employee_id'] = this.employeeId;
    data['fullname'] = this.fullname;
    data['level'] = this.level;
    data['division_name'] = this.divisionName;
    data['department_name'] = this.departmentName;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['profile_img_new'] = this.profileImgNew;
    return data;
  }
}