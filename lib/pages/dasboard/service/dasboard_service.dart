import 'package:firebase_auth/firebase_auth.dart';
import 'package:fms_mobile_app/constant/app_api.dart';
import 'package:fms_mobile_app/pages/dasboard/models/timesheets_panding_days.dart';

import 'package:http/http.dart' as http;

class DasBoardService {
  Future<TimeSheetPandingDaysModels?> timesheetpandingday() async {
    final user = await FirebaseAuth.instance.currentUser?.getIdToken();
    final token = user;
    String url = AppAPI.timesheetspandingdays;
    final res = await http.get(Uri.parse(url), headers: {
      'Authorization': 'Bearer $token',
    });
    if (res.statusCode == 200) {
      return timeSheetPandingDaysModelsFromJson(res.body);
    }
    return null;
  }
}
