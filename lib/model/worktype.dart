// class WorkType {
//   int? workTypeId;
//   String? name;
//   String? code;

//   WorkType({this.workTypeId, this.name, this.code});

//   WorkType.fromJson(Map<String, dynamic> json) {
//     workTypeId = json['work_type_id'];
//     name = json['name'];
//     code = json['code'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['work_type_id'] = this.workTypeId;
//     data['name'] = this.name;
//     data['code'] = this.code;
//     return data;
//   }

//  bool userFilterByCreationDate(String filter) {
//     return this.name.toString().contains(filter);
//   }
// }

class WorkTypeModels {
  int? status;
  List<DataModels>? data;

  WorkTypeModels({this.status, this.data});

  WorkTypeModels.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <DataModels>[];
      json['data'].forEach((v) {
        data!.add(new DataModels.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataModels {
  int? workTypeId;
  String? name;
  String? code;

  DataModels({this.workTypeId, this.name, this.code});

  DataModels.fromJson(Map<String, dynamic> json) {
    workTypeId = json['work_type_id'];
    name = json['name'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['work_type_id'] = this.workTypeId;
    data['name'] = this.name;
    data['code'] = this.code;
    return data;
  }

   bool userFilterByCreationDate(String filter) {
    return this.name.toString().contains(filter);
  }
}

