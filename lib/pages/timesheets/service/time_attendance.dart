import 'package:firebase_auth/firebase_auth.dart';
import 'package:fms_mobile_app/constant/app_api.dart';
import 'package:fms_mobile_app/pages/ot/HR/provider/set_item_checkbox.dart';
import 'package:fms_mobile_app/pages/timesheets/models/time_attendance.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TimeAttendance {
  Future<GetTimeAttendanceModels?> getTimeAttendance(context) async {
    final date = Provider.of<SetItmem>(context, listen: false);
    final user = FirebaseAuth.instance.currentUser!;
    DateTime datenow = DateTime.now();
    String monthnow = DateFormat('yyyy-MM-dd').format(datenow);
    final idTokens = await user.getIdToken();
    final res = await http.get(
        Uri.parse("${AppAPI.apiPath}/timesheets/attendances/date/time?date=${date.dateCalenda ?? monthnow}"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $idTokens',
        });
    print('attendance===${res.statusCode}');
    if (res.statusCode == 200) {
      return getTimeAttendanceModelsFromJson(res.body);
    }
    return null;
  }
}
