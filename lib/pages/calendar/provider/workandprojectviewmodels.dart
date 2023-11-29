import 'package:flutter/cupertino.dart';
import 'package:fms_mobile_app/pages/calendar/models/hoursattendance/hoursattendance_models.dart';
import 'package:fms_mobile_app/pages/calendar/models/project/project_models.dart';
import 'package:fms_mobile_app/pages/calendar/models/workcode/work_code_models.dart';
import 'package:fms_mobile_app/pages/calendar/models/worktype/work_type_models.dart';
import 'package:fms_mobile_app/pages/calendar/service/workandproject/work_and_project.dart';

class WorkAndProjectProvider extends ChangeNotifier {
  WorkCodeModel? _workCodeModel;
  WorkCodeModel? get workCodeModel => _workCodeModel;

  WorkTypeModel? _workTypeModel;
  WorkTypeModel? get workTypeModel => _workTypeModel;

  ProjectModel? _projectModel;
  ProjectModel? get projectModel => _projectModel;

  GetHoursAttendanceModels? _hoursAttendance;
  GetHoursAttendanceModels? get hoursAttendance => _hoursAttendance;

  bool loading = false;

  void initWorkAndProject() async {
    if (_workTypeModel == null || _projectModel == null || _workCodeModel == null) {
      loading = true;
      _workCodeModel = await WorkAndProjectService().getAllWorkCode();
      _workTypeModel = await WorkAndProjectService().getAllWorkType();
      _projectModel = await WorkAndProjectService().getAllProject();
      _hoursAttendance = await WorkAndProjectService().getHoursAttendance();
      loading = false;
      notifyListeners();
    }
  }
}
