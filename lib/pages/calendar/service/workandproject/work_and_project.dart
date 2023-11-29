
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fms_mobile_app/constant/app_api.dart';
import 'package:fms_mobile_app/pages/calendar/models/hoursattendance/hoursattendance_models.dart';
import 'package:fms_mobile_app/pages/calendar/models/project/project_models.dart';
import 'package:fms_mobile_app/pages/calendar/models/workcode/work_code_models.dart';
import 'package:fms_mobile_app/pages/calendar/models/worktype/work_type_models.dart';
import 'package:http/http.dart' as http;
class WorkAndProjectService {
  final Dio _dio = Dio();

  Future<WorkTypeModel?> getAllWorkType() async {
    final user = await FirebaseAuth.instance.currentUser?.getIdToken();
    String? token = user;
    final res = await _dio.get('${AppAPI.apiPath}/work-types',
        options: Options(headers: {"Authorization": 'Bearer $token'}));
    if (res.statusCode == 200) {
      return WorkTypeModel.fromJson(res.data);
    }
    return null;
  }

  Future<WorkCodeModel?> getAllWorkCode() async {
    final user = await FirebaseAuth.instance.currentUser?.getIdToken();
    String? token = user;
    final res = await _dio.get('${AppAPI.apiPath}/workcodes/work_type_id',
        options: Options(headers: {"Authorization": 'Bearer $token'}));
    if (res.statusCode == 200) {
      return WorkCodeModel.fromJson(res.data);
    }
    return null;
  }

  Future<ProjectModel?> getAllProject() async {
    final user = await FirebaseAuth.instance.currentUser?.getIdToken();
    String? token = user;
    final res = await _dio.get('${AppAPI.apiPath}/projects/search',
        options: Options(headers: {"Authorization": 'Bearer $token'}));
    if (res.statusCode == 200) {
      return ProjectModel.fromJson(res.data);
    }
    return null;
  }

  Future<GetHoursAttendanceModels?> getHoursAttendance() async {
    final user = await FirebaseAuth.instance.currentUser?.getIdToken();
    final token = user;
    String url = '${AppAPI.apiPath}/timesheets/attendances/date/time?date=2023-10-12';
    final res = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (res.statusCode == 200) {
      return getHoursAttendanceModelsFromJson(res.body);
    }
    return null;
  }
}
