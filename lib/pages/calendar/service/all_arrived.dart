import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fms_mobile_app/pages/calendar/models/holiday/holidays_models.dart';
import 'package:fms_mobile_app/pages/calendar/models/response/all_arrive_models.dart';
import 'package:fms_mobile_app/pages/calendar/models/response/hollyday_models.dart';
import 'package:fms_mobile_app/pages/calendar/models/response/time_sheet_response.dart';
import 'package:fms_mobile_app/services/api_service.dart';

class CalendarService {
  final Dio _dio = Dio();

  Future<AllArrivedModels?> getAllArrived() async {
    final user = await FirebaseAuth.instance.currentUser?.getIdToken();
    String? token = user;
    
    try {
      final res = await _dio.get('${APIService().apiPath}/attendance/startwork_all',
          options: Options(headers: {"Authorization": "Bearer $token"}));
      if (res.statusCode == 200) {
        final model = AllArrivedModels.fromJson(res.data);
        return model;
      }
    } catch (e) {
      throw Exception("error: $e");
    }
    return null;
  }

  Future<TimeSheetResponse?> getAllTimeSheet() async {
    final user = await FirebaseAuth.instance.currentUser?.getIdToken();
    String? token = user;
    try {
      final res = await _dio.get('${APIService().apiPath}/attendance/timesheets/approvals',
          options: Options(headers: {"Authorization": "Bearer $token"}));
      if (res.statusCode == 200) {
        final model = TimeSheetResponse.fromJson(res.data);
        return model;
      }
    } catch (e) {
      throw Exception('Failed: $e');
    }
    return null;
  }

  Future<HolidaysTimeSheetsModels?> holidayService() async {
    final user = await FirebaseAuth.instance.currentUser?.getIdToken();
    String? token = user;

    final dio = Dio();
    final res = await dio.get('${APIService().apiPath}/attendance/calendar/events/month?month=7&year=2023',
        options: Options(headers: {"Authorization": "Bearer $token"}));
    if (res.statusCode == 200) {
      HolidaysTimeSheetsModels? model = HolidaysTimeSheetsModels?.fromJson(res.data);
      return model;
    } else {
      throw Exception();
    }
  }
}
