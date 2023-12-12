// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fms_mobile_app/constant/app_api.dart';
import 'package:fms_mobile_app/model/admin_leave_by_id.dart';
import 'package:fms_mobile_app/model/admin_leaves_padding.dart';
import 'package:fms_mobile_app/model/admin_leaves_success.dart';
import 'package:fms_mobile_app/model/admin_ot_by_id.dart';
import 'package:fms_mobile_app/model/admin_ot_padding.dart';
import 'package:fms_mobile_app/model/admin_ot_success.dart';
import 'package:fms_mobile_app/model/admin_timesheet_approvals.dart';
import 'package:fms_mobile_app/model/admin_timesheet_date_detial.dart';
import 'package:fms_mobile_app/model/admin_timesheet_list_detial.dart';
import 'package:fms_mobile_app/model/admin_timesheet_padding.dart';
import 'package:fms_mobile_app/model/attendance_history.dart';
import 'package:fms_mobile_app/model/check_attend.dart';
import 'package:fms_mobile_app/model/check_field_locations.dart';
import 'package:fms_mobile_app/model/checking_start_ot.dart';
import 'package:fms_mobile_app/model/checksundayandholiday.dart';
import 'package:fms_mobile_app/model/getCountHR.dart';
import 'package:fms_mobile_app/model/getCountProject.dart';
import 'package:fms_mobile_app/model/historyinday.dart';
import 'package:fms_mobile_app/model/holiday_calenda.dart';
import 'package:fms_mobile_app/model/image_history.dart';
import 'package:fms_mobile_app/model/leaves_by_id.dart';
import 'package:fms_mobile_app/model/list_ot_pading.dart';
import 'package:fms_mobile_app/model/list_ot_success.dart';
import 'package:fms_mobile_app/model/list_padding.dart';
import 'package:fms_mobile_app/model/list_success.dart';
import 'package:fms_mobile_app/model/location_all.dart';
import 'package:fms_mobile_app/model/notification_counts.dart';
import 'package:fms_mobile_app/model/notification_lists.dart';
import 'package:fms_mobile_app/model/pending_day.dart';
import 'package:fms_mobile_app/model/projectall.dart';
import 'package:fms_mobile_app/model/startwork_all.dart';
import 'package:fms_mobile_app/model/std_checking_ot.dart';
import 'package:fms_mobile_app/model/sundayall.dart';
import 'package:fms_mobile_app/model/teamwork.dart';
import 'package:fms_mobile_app/model/timesheet_date_detial.dart';
import 'package:fms_mobile_app/model/timesheet_list_detial.dart';
import 'package:fms_mobile_app/model/timesheets_approvals.dart';
import 'package:fms_mobile_app/model/timesheets_leave.dart';
import 'package:fms_mobile_app/model/totalcount.dart';
import 'package:fms_mobile_app/model/user_detail.dart';
import 'package:fms_mobile_app/model/user_detail_by_id.dart';
import 'package:fms_mobile_app/model/user_image_list.dart';
import 'package:fms_mobile_app/model/workcode.dart';
import 'package:fms_mobile_app/model/worktype.dart';
import 'package:fms_mobile_app/pages/calendar/provider/calenda_provicer.dart';
import 'package:fms_mobile_app/pages/home/provider/timer_provider.dart';
import 'package:fms_mobile_app/pages/leave/models/leave_models.dart';
import 'package:fms_mobile_app/pages/leave/models/leave_type_models.dart';
import 'package:fms_mobile_app/pages/ot/HR/provider/set_item_checkbox.dart';
import 'package:fms_mobile_app/pages/ot/models/overtimeexecultive/overtimeexecultive_models.dart';
import 'package:fms_mobile_app/pages/ot/models/overtimeexecultive/overtimeexecultivecount_models.dart';
import 'package:fms_mobile_app/pages/ot/models/overtimeproject/overtime_count.dart';
import 'package:fms_mobile_app/pages/ot/models/overtimeproject/overtimeproject_models.dart';
import 'package:fms_mobile_app/pages/ot/ot_by_id.dart';
import 'package:fms_mobile_app/pages/timesheets/timesheet_list.dart';
import 'package:fms_mobile_app/pages/timesheets/timesheet_new.dart';
import 'package:fms_mobile_app/shared/mydata.dart';
import 'package:fms_mobile_app/widgets/loading/loading_add_timesheet.dart';
import 'package:fms_mobile_app/widgets/loading/loading_success.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class APIService {
  // String apiPath = "http://172.17.78.101:3000/api";
  // String servicePath = "http://172.17.78.101:3000/services";
  //String apiPath = "http://192.168.181.40:3000/api";
  // String servicePath = "http://192.168.181.40:3000/services";
  String apiPath = "https://fms-api.archiineergroup.la/api";
  String servicePath = "https://fms-api.archiineergroup.la/services";

  Future<UserDetail> getUserToken(String idToken) async {
    final http.Response response =
        await http.get(Uri.parse('${apiPath.toString()}/employees/info'), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${idToken}',
    });

    if (response.statusCode == 200) {
      //  print(response.body);
      return UserDetail.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to UserToken');
    }
  }

  Future<ImageHistory> getImageHistory(String idToken) async {
    // List<UserDetail> userDetail = [];
    final http.Response response =
        await http.get(Uri.parse('${apiPath.toString()}/employees/image'), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${idToken}',
    });

    if (response.statusCode == 200) {
      //  print(response.body);
      return ImageHistory.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to UserToken');
    }
  }

  Future<UserDetailById> getUserDetailByID(String idToken, String employeeId) async {
    // List<UserDetail> userDetail = [];
    final http.Response response =
        await http.get(Uri.parse('${apiPath.toString()}/employees/info/${employeeId}'), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${idToken}',
    });

    if (response.statusCode == 200) {
      //  print(response.body);
      return UserDetailById.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to UserToken');
    }
  }

  Future<UserImageList> getUserDetailImageByID(String idToken, String employeeId) async {
    // List<UserDetail> userDetail = [];
    final http.Response response =
        await http.get(Uri.parse('${apiPath}/employees/image/${employeeId}'), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${idToken}',
    });

    if (response.statusCode == 200) {
      //  print(response.body);
      return UserImageList.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to UserToken');
    }
  }

  Future<List<AttendanceHistory>> getAttendanceHistory(String idToken) async {
    List<AttendanceHistory> attendancehistory = [];
    try {
      final http.Response response = await http.get(
        Uri.parse('${apiPath.toString()}/attendance/history'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${idToken}',
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> map = json.decode(response.body);
        List<dynamic> data = map["data"];
        attendancehistory = data.map((e) => AttendanceHistory.fromJson(e)).toList();
        return attendancehistory;
      } else {
        print('Failed to fetch attendance history. Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');
        throw Exception('Failed to fetch attendance history');
      }
    } catch (e) {
      print('Error: $e');
      throw e;
    }
  }

  Future<List<HistoryInDay>> getHistoryInDay() async {
    List<HistoryInDay> historyinday = [];
    final http.Response response =
        await http.get(Uri.parse('${apiPath}/attendance/HistoryInDay'), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${MyData.token}',
    });
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      List<dynamic> data = map["data"];
      historyinday = data.map((e) => HistoryInDay.fromJson(e)).toList();

      return historyinday;
    } else {
      throw Exception('Failed to get category');
    }
  }

  Future<List<TeamWork>> getTeamwork(String? token) async {
    List<TeamWork> teamwork = [];
    final http.Response response =
        await http.get(Uri.parse('${apiPath}/timesheets/approvals/list'), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${token}',
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      List<dynamic> data = map["data"];

      teamwork = data.map((e) => TeamWork.fromJson(e)).toList();

      return teamwork;
    } else {
      throw Exception('Failed to get category');
    }
  }

  Future<List<StartworkAll>> getStartworkAll() async {
    List<StartworkAll> teamwork = [];
    final http.Response response =
        await http.get(Uri.parse('${apiPath}/attendance/startwork_all'), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${MyData.token}',
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      List<dynamic> data = map["data"];
      teamwork = data.map((e) => StartworkAll.fromJson(e)).toList();

      return teamwork;
    } else {
      throw Exception('Failed to get category');
    }
  }

  Future<List<TimesheetsApprovals>> getTimesheetsApprovals() async {
    List<TimesheetsApprovals> teamwork = [];
    final http.Response response =
        await http.get(Uri.parse('${apiPath}/attendance/timesheets/approvals'), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${MyData.token}',
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      List<dynamic> data = map["data"];

      teamwork = data.map((e) => TimesheetsApprovals.fromJson(e)).toList();

      return teamwork;
    } else {
      throw Exception('Failed to get category');
    }
  }

  Future<List<TimesheetsLeave>> getTimesheetsLeave() async {
    List<TimesheetsLeave> teamwork = [];
    final http.Response response =
        await http.get(Uri.parse('${apiPath.toString()}/attendance/timesheets/leave'), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${MyData.token}',
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      List<dynamic> data = map["data"];
      teamwork = data.map((e) => TimesheetsLeave.fromJson(e)).toList();

      return teamwork;
    } else {
      throw Exception('Failed to get TimesheetsLeave');
    }
  }

  Future<List<HolidayCalenda>> getHolidayCalenda() async {
    List<HolidayCalenda> holidaycalenda = [];
    final http.Response response =
        await http.get(Uri.parse('${apiPath.toString()}/attendance/calendar/events'), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${MyData.token}',
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      List<dynamic> data = map["data"];
      holidaycalenda = data.map((e) => HolidayCalenda.fromJson(e)).toList();
      return holidaycalenda;
    } else {
      throw Exception('Failed to get category');
    }
  }

  Future<List<SundayAll>> getSundayAll() async {
    List<SundayAll> sundayall = [];
    final http.Response response =
        await http.get(Uri.parse('${apiPath.toString()}/attendance/calendar/sunday'), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${MyData.token}',
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      List<dynamic> data = map["data"];
      sundayall = data.map((e) => SundayAll.fromJson(e)).toList();
      return sundayall;
    } else {
      throw Exception('Failed to get category');
    }
  }

  Future<List<LocationAll>> getLocationAll() async {
    List<LocationAll> teamwork = [];
    final http.Response response =
        await http.get(Uri.parse('${apiPath.toString()}/check-field-locations/all'), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${MyData.token}',
    });

    if (response.statusCode == 200) {
      // print(response.body);
      Map<String, dynamic> map = json.decode(response.body);
      List<dynamic> data = map["data"];
      teamwork = data.map((e) => LocationAll.fromJson(e)).toList();
      return teamwork;
    } else {
      throw Exception('Failed to get LocationAll');
    }
  }

  Future<CheckAttend> getCheckAttend(String idToken) async {
    final http.Response response =
        await http.post(Uri.parse('${apiPath.toString()}/attendance/check-attend'), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${idToken}',
    });

    if (response.statusCode == 200) {
      return CheckAttend.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get checkAttend');
    }
  }

  Future<CheckFieldLocations> getCheckFieldLocations(String checkinlatlng) async {
    final http.Response response = await http.post(Uri.parse('${apiPath.toString()}/check-field-locations'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${MyData.token}',
        },
        body: jsonEncode(<String, String>{'checkin_lat_lng': checkinlatlng}));

    if (response.statusCode == 200) {
      return CheckFieldLocations.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get CheckFieldLocations');
    }
  }

  Future<CheckSundayAndHoliday> getSundayAndHoliday(idToken) async {
    final http.Response response =
        await http.post(Uri.parse('${apiPath.toString()}/attendance/check-sundayorholiday'), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${idToken}',
    });

    if (response.statusCode == 200) {
      return CheckSundayAndHoliday.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get checkAttend');
    }
  }

  Future<String> checkIn(String checkinlatlng, String path, context) async {
    final url = Uri.parse('${apiPath.toString()}/attendance/checkin_newV1/${checkinlatlng}');
    var request = http.MultipartRequest('POST', url);
    request.headers['Authorization'] = 'Bearer ${MyData.token}';

    if (path != "") {
      request.files.add(await http.MultipartFile.fromPath('myFile', path));
    }
    final response = await request.send();

    if (response.statusCode != 200) {
      throw Exception("Failed to CheckIn error");
    }

    final res = await response.stream.bytesToString();

    return jsonDecode(res)['message'];
  }

  Future<bool> getCheckout(String Token, String checkinlatlng, context) async {
    final timer = Provider.of<TimerProvider>(context, listen: false);
    final http.Response response = await http.post(
      Uri.parse('${apiPath.toString()}/attendance/checkout-new'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${Token}',
      },
      body: jsonEncode(
        <String, String>{
          'checkout_lat_lng': checkinlatlng,
        },
      ),
    );

    if (response.statusCode == 200) {
      timer.stopTimer(context);
      showDialog(
        context: context,
        builder: (context) => LoadingDialog(
          title: "ເລີກວຽກສຳເລັດ",
          onTap: () async {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => const TimeSheetList()));
          },
        ),
      );

      return true;
    } else {
      return false;
    }
  }

  Future<String> updateprofile(String path) async {
    final url = Uri.parse('${apiPath.toString()}/profiles/save');
    var request = http.MultipartRequest('POST', url);
    request.headers['Authorization'] = 'Bearer ${MyData.token}';

    if (path != "") {
      request.files.add(await http.MultipartFile.fromPath('myFile', path));
    }
    final response = await request.send();

    if (response.statusCode != 200) {
      throw Exception("Failed to CheckIn error");
    }

    final res = await response.stream.bytesToString();

    return jsonDecode(res)['message'];
  }

  Future<PendingDay> getPendingDay(String idToken) async {
    final http.Response response =
        await http.get(Uri.parse('${apiPath.toString()}/attendance/pending-days'), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${idToken}',
    });

    if (response.statusCode == 200) {
      return PendingDay.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to UserToken');
    }
  }

  Future<GetCountOverTimeHrApproveModels> getCountHr(String idToken) async {
    final http.Response response = await http.get(Uri.parse('${AppAPI.getCountHr}'), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${idToken}',
    });

    if (response.statusCode == 200) {
      return GetCountOverTimeHrApproveModels.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to UserToken');
    }
  }

  Future<GetCountOverTimePrApproveModels> getCountProject(String idToken) async {
    final http.Response response = await http.get(Uri.parse('${AppAPI.getCountProject}'), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${idToken}',
    });

    if (response.statusCode == 200) {
      return GetCountOverTimePrApproveModels.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to UserToken');
    }
  }

  Future<List<DataModels>> getWorkType() async {
    List<DataModels> workType = [];
    final http.Response response = await http.get(Uri.parse(AppAPI.worktype), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${MyData.token}',
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      List<dynamic> data = map["data"];
      workType = data.map((e) => DataModels.fromJson(e)).toList();

      return workType;
    } else {
      throw Exception('Failed to get workType');
    }
  }

  Future<List<ProjectAll>> getProjectAll(String q) async {
    List<ProjectAll> projectall = [];
    final http.Response response =
        await http.get(Uri.parse('${apiPath.toString()}/projects/search?q=${q}'), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${MyData.token}',
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      List<dynamic> data = map["data"];
      projectall = data.map((e) => ProjectAll.fromJson(e)).toList();

      return projectall;
    } else {
      throw Exception('Failed to get workType');
    }
  }

  Future<List<WorkCode>> getWorkCode() async {
    List<WorkCode> workcode = [];
    final http.Response response =
        await http.get(Uri.parse('${apiPath.toString()}/workcodes/work_type_id'), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${MyData.token}',
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      List<dynamic> data = map["data"];
      workcode = data.map((e) => WorkCode.fromJson(e)).toList();

      return workcode;
    } else {
      throw Exception('Failed to get workType');
    }
  }

  Future<bool> getUpdateToken(String Token, String deviceType, String tokenMsg) async {
    final http.Response response = await http.post(Uri.parse('${servicePath.toString()}/notifications/fcm-tokens-new'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${Token}',
        },
        body: jsonEncode(<String, String>{
          'device_type': deviceType,
          'token': tokenMsg,
          // 'qty': qty.toString()
        }));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> AddTimeSheet(
      String token, String projectid, String worktype, String workcode, String workhour, String remark, context) async {
    final date = Provider.of<SetItmem>(context, listen: false);

    LoadingAddTimeSheets().showDialogSuccess(context);
    final http.Response response = await http.post(Uri.parse('${apiPath.toString()}/timesheets/submit/request'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${token}',
        },
        body: jsonEncode(<String, String>{
          'date': date.dateCalenda.toString(),
          'project_id': projectid,
          'work_type': worktype,
          'workcode': workcode,
          'work_hour': workhour,
          'remark': remark
        }));

    if (response.statusCode == 200) {
      Navigator.pop(context);
      final calendarVm = Provider.of<CalendarProvider>(context, listen: false);
      await calendarVm.initAllCalenda(context);
      return true;
    } else {
      return false;
    }
  }

  Future<TimesheetListDetial> getTimesheetListDetial(context) async {
    final date = Provider.of<SetItmem>(context, listen: false);
    final user = FirebaseAuth.instance.currentUser!;
    DateTime datenow = DateTime.now();
    // String monthnow = DateFormat('MM').format(datenow);
    String yearnow = DateFormat('yyyy-MM-dd').format(datenow);
    String? idTokens = await user.getIdToken();

    final http.Response response = await http.get(
        Uri.parse('${apiPath.toString()}/attendance/list?date=${date.dateCalenda ?? yearnow}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $idTokens',
        });

    if (response.statusCode == 200) {
      return TimesheetListDetial.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to UserToken');
    }
  }

  Future<AdminTimesheetListDetial> getAdminTimesheetListDetial(String idToken, String date, String employeeId) async {
    final http.Response response = await http.get(
        Uri.parse('${apiPath.toString()}/attendance/employees/${employeeId}?date=${date}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${idToken}',
        });

    if (response.statusCode == 200) {
      return AdminTimesheetListDetial.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to UserToken');
    }
  }

  Future<TimesheetDateDetial> getTimesheetDateDetial(context) async {
    DateTime datenow = DateTime.now();
    // String monthnow = DateFormat('MM').format(datenow);
    String yearnow = DateFormat('yyyy-MM-dd').format(datenow);
    final date = Provider.of<SetItmem>(context, listen: false);
    final user = FirebaseAuth.instance.currentUser!;
    if (user != null) {
      String? idTokens = await user.getIdToken();
      final http.Response response = await http.get(
          Uri.parse('${AppAPI.apiPath}/timesheets/date?date=${date.dateCalenda ?? yearnow}'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $idTokens',
          });
      print("timesheetsdatedetail${response.statusCode}");
      if (response.statusCode == 200) {
        return TimesheetDateDetial.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to fetch timesheet details');
      }
    } else {
      throw Exception('User not authenticated');
    }
  }

  Future<AdminTimesheetDateDetial> getAdminTimesheetDateDetial(String idToken, String date, String employeeId) async {
    final http.Response response = await http.get(
        Uri.parse('${apiPath.toString()}/timesheets/date?date=${date}&employee=${employeeId}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${idToken}',
        });

    if (response.statusCode == 200) {
      return AdminTimesheetDateDetial.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to UserToken');
    }
  }

  Future<bool> DelectTimeByEm(
    String token,
    int e_timesheet_id,
  ) async {
    final http.Response response = await http.post(
      Uri.parse('${apiPath.toString()}/timesheets/delete/${e_timesheet_id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${token}',
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<NotificationLists> getNotificationLists(String? token) async {
    final http.Response response = await http
        .get(Uri.parse('${servicePath.toString()}/notifications/notification-lists'), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${token}',
    });

    // print('Response Code: ${response.statusCode}');
    // print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      return NotificationLists.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to UserToken');
    }
  }

  Future<NotificationCounts> getNotificationCounts(String? token) async {
    final http.Response response = await http.get(
      Uri.parse('${servicePath.toString()}/notifications/notification-counts'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${token}',
      },
    );

    if (response.statusCode == 200) {
      return NotificationCounts.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('User is not signed in');
    }
  }

  Future<bool> AddLeave(
      String? token, String? startdart, String? enddate, String? leavetype, String? detail, String? employee) async {
    final http.Response response = await http.post(Uri.parse(AppAPI.addrequestLeave),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${token}',
        },
        body: jsonEncode(<String, String>{
          "start_date": startdart!,
          "end_date": enddate!,
          "leave_type": leavetype!,
          "details": detail ?? "",
          "employee_substitute_id": employee!
        }));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<LeaveTypeModels?> getLeaveType(String idToken) async {
    try {
      final http.Response response = await http.get(Uri.parse(AppAPI.getleavetype), headers: <String, String>{
        'Authorization': 'Bearer ${idToken}',
      });
      if (response.statusCode == 200) {
        return leaveTypeModelsFromJson(response.body);
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<ListPadding> getListPadding(String idToken) async {
    final http.Response response =
        await http.get(Uri.parse('${apiPath.toString()}/leaves/list-padding'), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${idToken}',
    });

    if (response.statusCode == 200) {
      return ListPadding.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to UserToken');
    }
  }

  Future<ListSuccess> getListSuccess(String idToken) async {
    final http.Response response =
        await http.get(Uri.parse('${apiPath.toString()}/leaves/list-Success'), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${idToken}',
    });

    if (response.statusCode == 200) {
      return ListSuccess.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to UserToken');
    }
  }

  Future<bool> AddOT(
    String Token,
    String date,
    String start_time,
    String end_time,
    String detail,
    String project_id,
    String workcode,
  ) async {
    final http.Response response = await http.post(Uri.parse('${apiPath.toString()}/overtimes/request-new'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${Token}',
        },
        body: jsonEncode(<String, String>{
          "work_type": "1", //work_type == 1 ມີ project_id and workcode || work_type == 2  ມີແຕ່  workcode
          "project_id": "79",
          "workcode": "30",
          "checkin_lat_lng": "17.9648929,102.6343919",
          "detail": "asdasdww"
        }));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<ListOtSuccess> getListOTSuccess(String idToken) async {
    final http.Response response = await http.get(Uri.parse(AppAPI.getOTSuccess), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${idToken}',
    });

    if (response.statusCode == 200) {
      return listOtSuccessFromJson(response.body);
    } else {
      throw Exception('Failed to UserToken');
    }
  }

  Future<ListOtPading> getListOTPading(String idToken) async {
    final http.Response response = await http.get(Uri.parse(AppAPI.getOTAwait), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${idToken}',
    });

    if (response.statusCode == 200) {
      return listOtPadingFromJson(response.body);
    } else {
      throw Exception('Failed to UserToken');
    }
  }

  Future<AdminOtSuccess> getListAdminOTSuccess(String idToken, String employeeId) async {
    final http.Response response = await http
        .get(Uri.parse('${apiPath.toString()}/overtimes/list-admin-success/${employeeId}'), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${idToken}',
    });

    if (response.statusCode == 200) {
      return AdminOtSuccess.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to UserToken');
    }
  }

  Future<AdminOtPadding> getListAdminOTPading(String idToken, String employeeId) async {
    final http.Response response = await http
        .get(Uri.parse('${apiPath.toString()}/overtimes/list-admin-padding/${employeeId}'), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${idToken}',
    });

    if (response.statusCode == 200) {
      return AdminOtPadding.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to UserToken');
    }
  }

  Future<StdCheckingOt> CheckingStdOTCreate(String idToken) async {
    final http.Response response =
        await http.get(Uri.parse('${apiPath.toString()}/overtimes/checking-stutas-ot'), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${idToken}',
    });

    if (response.statusCode == 200) {
      return StdCheckingOt.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to UserToken');
    }
  }

  Future<CheckingStartOt> CheckingStartOtNow(String idToken) async {
    final http.Response response =
        await http.get(Uri.parse('${apiPath.toString()}/overtimes/checking-start-ot'), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${idToken}',
    });

    if (response.statusCode == 200) {
      return CheckingStartOt.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to UserToken');
    }
  }

  Future<bool> CreateCheckInAndOutOT(String Token, String checkinlatlng, String overtimeId) async {
    final http.Response response = await http.post(Uri.parse('${apiPath.toString()}/overtimes/check-in-out-ot-new'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${Token}',
        },
        body: jsonEncode(<String, String>{
          'checkout_lat_lng': checkinlatlng,
          'e_overtime_id': overtimeId,
        }));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<LeavesById> getLeaveByID(String idToken, String leaveid) async {
    final http.Response response =
        await http.get(Uri.parse('${apiPath.toString()}/leaves/list/${leaveid}'), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${idToken}',
    });

    if (response.statusCode == 200) {
      return LeavesById.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to UserToken');
    }
  }

  Future<LeaveAdminById> getLeaveAdminByID(String idToken, String leaveid, String employeeId) async {
    final http.Response response = await http
        .get(Uri.parse('${apiPath.toString()}/leaves/list/${leaveid}/${employeeId}'), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${idToken}',
    });

    if (response.statusCode == 200) {
      return LeaveAdminById.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to UserToken');
    }
  }

  Future<OtById> getOTByID(String idToken, String eOvertimeId) async {
    final http.Response response =
        await http.get(Uri.parse('${apiPath.toString()}/overtimes/list/${eOvertimeId}'), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${idToken}',
    });

    if (response.statusCode == 200) {
      return OtById.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to UserToken');
    }
  }

  Future<AdminOtById> getAdminOTByID(String idToken, String eOvertimeId, String employeeId) async {
    final http.Response response = await http
        .get(Uri.parse('${apiPath.toString()}/overtimes/list/${eOvertimeId}/${employeeId}'), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${idToken}',
    });

    if (response.statusCode == 200) {
      return AdminOtById.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to UserToken');
    }
  }

  Future<AdminLeavesPadding> getListAdminLeavesPadding(String idToken, String employeeId) async {
    final http.Response response = await http
        .get(Uri.parse('${apiPath.toString()}/leaves/list-admin-padding/${employeeId}'), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${idToken}',
    });

    if (response.statusCode == 200) {
      return AdminLeavesPadding.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to UserToken');
    }
  }

  Future<AdminLeavesSuccess> getListAdminLeavesSuccess(String idToken, String employeeId) async {
    final http.Response response = await http
        .get(Uri.parse('${apiPath.toString()}/leaves/list-admin-success/${employeeId}'), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${idToken}',
    });

    if (response.statusCode == 200) {
      return AdminLeavesSuccess.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to UserToken');
    }
  }

  Future<AdminTimeSheetPadding> getListAdminTimesheetPadding(String idToken, String employeeId) async {
    final http.Response response = await http
        .get(Uri.parse('${apiPath.toString()}/attendance/timesheets-padding/${employeeId}'), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${idToken}',
    });

    if (response.statusCode == 200) {
      return AdminTimeSheetPadding.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to UserToken');
    }
  }

  Future<AdminTimeSheetApprovals> getListAdminTimesheetSuccess(String idToken, String employeeId) async {
    final http.Response response = await http.get(
        Uri.parse('${apiPath.toString()}/attendance/timesheets-approvals/${employeeId}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${idToken}',
        });

    if (response.statusCode == 200) {
      return AdminTimeSheetApprovals.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to UserToken');
    }
  }

  Future<bool> ApprovalLeaves(String Token, String is_approved, String e_leave_id, String remark) async {
    final http.Response response = await http.post(Uri.parse('${apiPath.toString()}/leaves/approval-new'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${Token}',
        },
        body: jsonEncode(<String, String>{'is_approved': is_approved, 'e_leave_id': e_leave_id, 'remark': remark}));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> ApprovalOverTime(String Token, String is_approved, String e_overtime_id, String remark) async {
    final http.Response response = await http.post(Uri.parse('${apiPath.toString()}/overtimes/approval-new'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${Token}',
        },
        body:
            jsonEncode(<String, String>{'is_approved': is_approved, 'e_overtime_id': e_overtime_id, 'remark': remark}));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> ApprovalTimeSheet(String Token, String is_passed, String date, String remark, String employeeId) async {
    final http.Response response =
        await http.post(Uri.parse('${apiPath.toString()}/attendance/timesheets/approvals-new/${employeeId}'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer ${Token}',
            },
            body: jsonEncode(<String, String>{'is_passed': is_passed, 'date': date, 'remark': remark}));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> UpdateNotiCout(String Token) async {
    final http.Response response = await http.post(
      Uri.parse('${servicePath.toString()}/notifications/readed'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${Token}',
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  ////////////////////////////////////////////////////////////////
  Future<LeaveModels?> getLeave(String? token) async {
    try {
      final response = await http.get(
        Uri.parse(AppAPI.getleave),
        headers: <String, String>{
          "Authorization": "Bearer $token",
        },
      );
      if (response.statusCode == 200) {
        return leaveModelsFromJson(response.body);
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<OverTimeProjectModels?> getOverTimeProject(String? token) async {
    try {
      final response = await http.get(
        Uri.parse(AppAPI.getOverTimeProject),
        headers: <String, String>{
          "Authorization": "Bearer $token",
        },
      );
      if (response.statusCode == 200) {
        return overTimeProjectModelsFromJson(response.body);
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<OverTimeCountModels?> getOverTimeCount(String? token) async {
    try {
      final response = await http.get(
        Uri.parse(AppAPI.getOverTimeCount),
        headers: <String, String>{
          "Authorization": "Bearer $token",
        },
      );
      if (response.statusCode == 200) {
        return overTimeCountModelsFromJson(response.body);
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<GetOvertimeExecutiveApproveModels?> getOvertimeExecutiveApprove(String? token) async {
    try {
      final response = await http.get(
        Uri.parse(AppAPI.getOverTimeExecult),
        headers: <String, String>{
          "Authorization": "Bearer $token",
        },
      );
      if (response.statusCode == 200) {
        return getOvertimeExecutiveApproveModelsFromJson(response.body);
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<GetOvertimeExecutiveCountModels?> getOvertimeExecutiveCount(String? token) async {
    try {
      final response = await http.get(
        Uri.parse(AppAPI.getOverTimeExecultCount),
        headers: <String, String>{
          "Authorization": "Bearer $token",
        },
      );
      if (response.statusCode == 200) {
        return getOvertimeExecutiveCountModelsFromJson(response.body);
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<TotalCountModels?> getTotalCount() async {
    try {
      final user = await FirebaseAuth.instance.currentUser?.getIdToken();
      final token = user;
      String url = AppAPI.totalcount;
      final res = await http.get(Uri.parse(url), headers: {
        "Authorization": "Bearer $token",
      });
      if (res.statusCode == 200) {
        return totalCountModelsFromJson(res.body);
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }
}
