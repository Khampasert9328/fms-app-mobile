class ProjectAll {
  int? projectId;
  String? projectName;
  String? projectCode;

  ProjectAll({this.projectId, this.projectName, this.projectCode});

  ProjectAll.fromJson(Map<String, dynamic> json) {
    projectId = json['project_id'];
    projectName = json['project_name'];
    projectCode = json['project_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['project_id'] = this.projectId;
    data['project_name'] = this.projectName;
    data['project_code'] = this.projectCode;
    return data;
  }

  bool userFilterByCreationDate(String filter) {
    return this.projectName.toString().contains(filter);
  }
}

 
