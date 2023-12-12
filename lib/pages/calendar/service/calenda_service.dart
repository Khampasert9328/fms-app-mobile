import 'package:firebase_auth/firebase_auth.dart';
import 'package:fms_mobile_app/constant/app_api.dart';
import 'package:fms_mobile_app/pages/calendar/models/attendance/attendance_models.dart';
import 'package:fms_mobile_app/pages/calendar/models/calendasetup/calendasetup_models.dart';
import 'package:fms_mobile_app/pages/calendar/models/hoursattendance/hoursattendance_models.dart';
import 'package:fms_mobile_app/pages/calendar/models/leavecalenda/leavecalenda_models.dart';
import 'package:fms_mobile_app/pages/calendar/models/timesheetscalenda/timesheetscalenda_models.dart';
import 'package:fms_mobile_app/pages/calendar/provider/calenda_provicer.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class CalenDaService {
  Future<TimeSheetsCalendaModels?> getTimeSheetsCalenda(context) async {
    DateTime datenow = DateTime.now();
    String monthnow = DateFormat('MM').format(datenow);
    String yearnow = DateFormat('yyyy').format(datenow);
    final provider = Provider.of<CalendarProvider>(context, listen: false);
    final user = await FirebaseAuth.instance.currentUser?.getIdToken();
    final token = user;
    String url =
        '${AppAPI.apiPath}/timesheets/month?month=${provider.setmonthcalenda ?? monthnow}&year=${provider.setyearcalenda ?? yearnow}';
    final res = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (res.statusCode == 200) {
      return timeSheetsCalendaModelsFromJson(res.body);
    }
    return null;
  }

  Future<LeaveCalendaModels?> getLeaveCalenda(context) async {
    final provider = Provider.of<CalendarProvider>(context, listen: false);
    final user = await FirebaseAuth.instance.currentUser?.getIdToken();
    final token = user;
    String url = '${AppAPI.apiPath}/leaves/month?month=${provider.setmonthcalenda}&year=${provider.setyearcalenda}';
    final res = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (res.statusCode == 200) {
      return leaveCalendaModelsFromJson(res.body);
    }
    return null;
  }

  Future<AttendanceCalendaModels?> getAttendanceCalenda(context) async {
    final provider = Provider.of<CalendarProvider>(context, listen: false);
    final user = await FirebaseAuth.instance.currentUser?.getIdToken();
    final token = user;
    String url = '${AppAPI.apiPath}/attendance/month?month=${provider.setmonthcalenda}&year=${provider.setyearcalenda}';
    final res = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    print("attendance");
    if (res.statusCode == 200) {
      print("${res.body}");
      return attendanceCalendaModelsFromJson(res.body);
    }
    return null;
  }

  Future<CalendaSetUpModels?> getCalendaSetUp(context) async {
    final provider = Provider.of<CalendarProvider>(context, listen: false);
    final user = await FirebaseAuth.instance.currentUser?.getIdToken();
    final token = user;
    String url =
        '${AppAPI.apiPath}/attendance/calendar/events/month?=${provider.setmonthcalenda}&year=${provider.setyearcalenda}';
    final res = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    print("calendasetup");
    if (res.statusCode == 200) {
      return calendaSetUpModelsFromJson(res.body);
    }
    return null;
  }
}
