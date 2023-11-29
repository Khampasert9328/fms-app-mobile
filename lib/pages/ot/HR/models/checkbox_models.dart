import 'package:fms_mobile_app/pages/ot/models/HR/HR_models.dart';

class CheckBoxHRModels {
  HRModels data;
  int? eovertimeid;
  String? isapproved;
  String? remark;

  CheckBoxHRModels({required this.eovertimeid, this.isapproved, this.remark, required this.data});
}
