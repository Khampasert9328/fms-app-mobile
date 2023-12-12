// ignore_for_file: unused_local_variable
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
import 'package:fms_mobile_app/pages/Approve/DRApporveWork/models/dr_approve_success.dart';
import 'package:fms_mobile_app/pages/Approve/DRApporveWork/models/getallforapprovetime_models.dart';
import 'package:fms_mobile_app/pages/Approve/DRApporveWork/models/gettimesheetallMonthandyear_models.dart';
import 'package:fms_mobile_app/pages/Approve/DRApporveWork/service/dr_approve_service.dart';
import 'package:fms_mobile_app/pages/Approve/HRApproveVacation/models/hrleaverequest_models.dart';
import 'package:fms_mobile_app/pages/Approve/HRApproveVacation/service/hr_leave_request.dart';
import 'package:fms_mobile_app/pages/dasboard/models/timesheets_panding_days.dart';
import 'package:fms_mobile_app/pages/dasboard/service/dasboard_service.dart';
import 'package:fms_mobile_app/pages/home/OT/models/ot_screen_models.dart';
import 'package:fms_mobile_app/pages/home/OT/models/projectall_models.dart';
import 'package:fms_mobile_app/pages/home/OT/models/workcode_models.dart';
import 'package:fms_mobile_app/pages/home/OT/service/worktype_service.dart';
import 'package:fms_mobile_app/pages/home/provider/timer_provider.dart';
import 'package:fms_mobile_app/pages/ot/DR/models/dr_await_models.dart';
import 'package:fms_mobile_app/pages/ot/DR/models/dr_success_models.dart';
import 'package:fms_mobile_app/pages/ot/DR/service/dr_service.dart';
import 'package:fms_mobile_app/pages/leave/models/leave_models.dart';
import 'package:fms_mobile_app/pages/leave/models/leave_type_models.dart';
import 'package:fms_mobile_app/pages/ot/HR/provider/set_item_checkbox.dart';
import 'package:fms_mobile_app/pages/ot/PM/models/pm_await_models.dart';
import 'package:fms_mobile_app/pages/ot/PM/models/pm_success_models.dart';
import 'package:fms_mobile_app/pages/ot/PM/service/pm_service.dart';
import 'package:fms_mobile_app/pages/ot/TM/models/leave_friends_models.dart';
import 'package:fms_mobile_app/pages/ot/TM/service/tm_service.dart';
import 'package:fms_mobile_app/pages/ot/models/HR/HR_models.dart';
import 'package:fms_mobile_app/pages/ot/models/overtimeexecultive/overtimeexecultive_models.dart';
import 'package:fms_mobile_app/pages/ot/models/overtimeexecultive/overtimeexecultivecount_models.dart';
import 'package:fms_mobile_app/pages/ot/models/overtimeproject/overtime_count.dart';
import 'package:fms_mobile_app/pages/ot/models/overtimeproject/overtimeproject_models.dart';
import 'package:fms_mobile_app/pages/ot/ot_by_id.dart';
import 'package:fms_mobile_app/pages/ot/HR/models/hr_checking_success.dart';
import 'package:fms_mobile_app/pages/ot/HR/service/hr_approved.dart';
import 'package:fms_mobile_app/pages/ot/service/get_hr_approved.dart';
import 'package:fms_mobile_app/pages/overtime/models/GetMyOverTime.dart';
import 'package:fms_mobile_app/pages/overtime/service/ot_service.dart';
import 'package:fms_mobile_app/pages/timesheets/models/time_attendance.dart';
import 'package:fms_mobile_app/pages/timesheets/service/time_attendance.dart';
import 'package:fms_mobile_app/services/api_service.dart';
import 'package:fms_mobile_app/shared/mydata.dart';
import 'package:geolocator/geolocator.dart' as location;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:package_info_plus/package_info_plus.dart';

import 'package:provider/provider.dart';

class ProviderService extends ChangeNotifier {
  bool _btnStartisLoading = false;
  bool get btnStartisLoading => _btnStartisLoading;

  String tokenUser = "";

  File? imageFile;
  File? imageProFile;

  DateTime? timeSheetList;

  //respone mssessge error Login
  String responeMsg = "";

  String? _versionApp;
  String? get versionApp => _versionApp;
  String versionCodeApp = "";

  UserDetail? _userDetail;
  UserDetail? get userDetail => _userDetail;

  UserDetailById? _userDetailById;
  UserDetailById? get userDetailById => _userDetailById;

  UserImageList? _userImageList;
  UserImageList? get userImageList => _userImageList;

  ImageHistory? _imageHistory;
  ImageHistory? get imageHistory => _imageHistory;

  CheckAttend? _checkAttend;
  CheckAttend? get checkAttend => _checkAttend;

  CheckSundayAndHoliday? _checkSundayAndHoliday;
  CheckSundayAndHoliday? get checkSundayAndHoliday => _checkSundayAndHoliday;

  CheckFieldLocations? _checkFieldLocations;
  CheckFieldLocations? get checkFieldLocations => _checkFieldLocations;

  PendingDay? _pendingDay;
  PendingDay? get pendingDays => _pendingDay;
  GetCountOverTimeHrApproveModels? _countHR;
  GetCountOverTimeHrApproveModels? get countHR => _countHR;
  GetCountOverTimePrApproveModels? _countPr;
  GetCountOverTimePrApproveModels? get countPr => _countPr;

  TimesheetListDetial? _timesheetListDetial;
  TimesheetListDetial? get timesheetListDetial => _timesheetListDetial;

  TimesheetDateDetial? _timesheetDateDetial;
  TimesheetDateDetial? get timesheetDateDetial => _timesheetDateDetial;

  AdminTimesheetListDetial? _adminTimesheetListDetial;
  AdminTimesheetListDetial? get adminTimesheetListDetial => _adminTimesheetListDetial;

  AdminTimesheetDateDetial? _adminTimesheetDateDetial;
  AdminTimesheetDateDetial? get adminTimesheetDateDetial => _adminTimesheetDateDetial;

  NotificationLists? _notificationLists;
  NotificationLists? get notificationLists => _notificationLists;

  NotificationCounts? _notificationCounts;
  NotificationCounts? get notificationCounts => _notificationCounts;

  ListPadding? _listPadding;
  ListPadding? get listPadding => _listPadding;

  ListSuccess? _listSuccess;
  ListSuccess? get listSuccess => _listSuccess;

  ListOtPading? _listOtPading;
  ListOtPading? get listOtPading => _listOtPading;

  ListOtSuccess? _listOtSuccess;
  ListOtSuccess? get listOtSuccess => _listOtSuccess;

  AdminOtPadding? _adminOtPadding;
  AdminOtPadding? get adminOtPadding => _adminOtPadding;

  AdminOtSuccess? _adminOtSuccess;
  AdminOtSuccess? get adminOtSuccess => _adminOtSuccess;

  StdCheckingOt? _stdCheckingOt;
  StdCheckingOt? get stdCheckingOt => _stdCheckingOt;

  CheckingStartOt? _checkingStartOt;
  CheckingStartOt? get checkingStartOt => _checkingStartOt;

  LeavesById? _leavesById;
  LeavesById? get leavesById => _leavesById;

  LeaveAdminById? _leaveAdminById;
  LeaveAdminById? get leaveAdminById => _leaveAdminById;

  AdminTimeSheetPadding? _adminTimeSheetPadding;
  AdminTimeSheetPadding? get adminTimeSheetPadding => _adminTimeSheetPadding;

  AdminTimeSheetApprovals? _adminTimeSheetApprovals;
  AdminTimeSheetApprovals? get adminTimeSheetApprovals => _adminTimeSheetApprovals;

  OtById? _otById;
  OtById? get otById => _otById;

  AdminOtById? _adminOtById;
  AdminOtById? get adminOtById => _adminOtById;

  AdminLeavesPadding? _adminLeavesPadding;
  AdminLeavesPadding? get adminLeavesPadding => _adminLeavesPadding;

  AdminLeavesSuccess? _adminLeavesSuccess;
  AdminLeavesSuccess? get adminLeavesSuccess => _adminLeavesSuccess;

  List<AttendanceHistory> attendancehistory = [];
  List<HistoryInDay> historyinday = [];
  List<TeamWork> teamwork = [];
  List<StartworkAll> startwork_all = [];
  List<HolidayCalenda> holidaycalenda = [];
  List<TimesheetsApprovals> timesheetsapprovals = [];
  List<TimesheetsLeave> timesheetsleave = [];
  List<LocationAll> locationall = [];
  List<SundayAll> sundayall = [];
  List<DataModels> workType = [];
  List<ProjectAll> projectAll = [];

  List<WorkCode> workcode = [];

  //leaveType
  LeaveTypeModels? _leavetype;
  LeaveTypeModels? get leavetype => _leavetype;
  LeaveModels? _leave;
  LeaveModels? get leave => _leave;

//Models ຫົວໜ້າໂປຣເຈັກ ອະນຸມັດ
  OverTimeProjectModels? _overtimeproject;
  OverTimeProjectModels? get overtimeproject => _overtimeproject;
  OverTimeCountModels? _overtimecount;
  OverTimeCountModels? get overtimecount => _overtimecount;

  //Models ຫົວໜ້າໜ່ວຍງານ ອະນຸມັດ
  GetOvertimeExecutiveCountModels? _overtimeexeccount;
  GetOvertimeExecutiveCountModels? get overtimeexeccount => _overtimeexeccount;
  GetOvertimeExecutiveApproveModels? _executiveApprove;
  GetOvertimeExecutiveApproveModels? get executiveApprove => _executiveApprove;

//isloading
  bool _isloading = false;
  bool get isloading => _isloading;

//get Location Now

  location.Position? _userLocation;
  location.Position? get userLocation => _userLocation;

  int StdEndworkThisDay = 0;

  setBtStartLoading(bool val) {
    _btnStartisLoading = val;
    notifyListeners();
  }

  SetStdTimesheet(int ThisDay) async {
    // print(dateTime);

    StdEndworkThisDay = ThisDay;
    // final response = await APIService().getCheckFieldLocations(checkinlatlng);
    // checkFieldLocations = response;
    notifyListeners();
  }

  List<PendingDay> PendingDaysss = [];

  setVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _versionApp = packageInfo.version;
    versionCodeApp = packageInfo.buildNumber;
    print("version111===${_versionApp}");

    notifyListeners();
  }

  //Image Upload
  void setFileForUpload(file) {
    if (file == null) {
      imageFile == null;
    } else {
      imageFile = file;
    }

    notifyListeners();
  }

  setTimesheet() async {
    final user = FirebaseAuth.instance.currentUser!;
    final idTokens = await user.getIdToken();
    if (idTokens!.isNotEmpty && idTokens != "") {
      workType = await APIService().getWorkType();
      projectAll = await APIService().getProjectAll("");
      workcode = await APIService().getWorkCode();
      // setProject("");
      notifyListeners();
    }
  }

  set notificationLists(val) {
    _notificationLists = val;
    notifyListeners();
  }

  setNotilist() async {
    final user = FirebaseAuth.instance.currentUser!;
    final idTokens = await user.getIdToken();
    if (idTokens!.isNotEmpty && idTokens != "") {
      final noti = await APIService().getNotificationLists(idTokens);

      notificationLists = noti;
      notifyListeners();
    }
  }

  set notificationCounts(val) {
    _notificationCounts = val;
    notifyListeners();
  }

  String NotiCout = '1';

  setNotiCout() async {
    final user = FirebaseAuth.instance.currentUser!;
    final idTokens = await user.getIdToken();

    if (idTokens!.isNotEmpty && idTokens != "") {
      if (NotiCout != '0') {
        final noti = await APIService().getNotificationCounts(idTokens);

        notificationCounts = noti;
        MyData.noticout = noti.data!.count!.toInt();
      }

      // print('${NotiCout} asdasd');

      NotiCout = '0';

      while (true) {
        await Future.delayed(const Duration(seconds: 5));

        final noti = await APIService().getNotificationCounts(idTokens);

        notificationCounts = noti;

        MyData.noticout = noti.data!.count!.toInt();
        notifyListeners();
      }
    }
  }

  setProject(String q) async {
    final user = FirebaseAuth.instance.currentUser!;
    final idTokens = await user.getIdToken();
    if (idTokens!.isNotEmpty && idTokens != "") {
      if (projectAll != null) {
        projectAll = await APIService().getProjectAll(q);
      }

      notifyListeners();
    }
  }

  // setWorkcodeAll() async {
  //   final user = FirebaseAuth.instance.currentUser!;
  //   final idTokens = await user.getIdToken();
  //   if (idTokens.isNotEmpty && idTokens != "") {
  //     //  workcode = await APIService().getWorkCode(worktypeid);

  //       // print("1122");

  //     notifyListeners();
  //   }
  // }

  void setProFileForUpload(file) {
    if (file == null) {
      imageProFile == null;
    } else {
      imageProFile = file;
    }

    notifyListeners();
  }

  int _pageSelectedIndex = 0;
  int get pageSelected => _pageSelectedIndex;

  //_pageSelected Index
  final PageController _pageController = PageController(initialPage: 0);
  PageController get pageController => _pageController;

  set pageSelected(int index) {
    // _pageController.animateToPage(index,
    //     duration: Duration(microseconds: 300), curve: Curves.bounceOut);
    _pageSelectedIndex = index;
    notifyListeners();
  }

  set userDetail(val) {
    _userDetail = val;
    notifyListeners();
  }

  set imageHistory(val) {
    _imageHistory = val;
    notifyListeners();
  }

  setUserDetailModel() async {
    final user = FirebaseAuth.instance.currentUser!;
    final idTokens = await user.getIdToken();

    String? token = await FirebaseMessaging.instance.getToken();

    if (idTokens!.isNotEmpty && idTokens != "") {
      final res = await APIService().getUserToken(idTokens);
      // final res1 = await APIService().getImageHistory(idTokens);

      // final resprofile = await APIService().getProfile(idTokens);
      await UpdateTokenMsg();
      userDetail = res;
      // imageHistory = res1;

      final fullname = res.data?.fullnameEn;
      final fullnameLa = res.data?.fullname;
      final email = userDetail?.data?.email;
      final mobile = userDetail?.data?.mobile;
      final divisionName = userDetail?.data?.divisionName;
      final departmentName = userDetail?.data?.departmentName;
      final level = userDetail?.data?.level;
      final profile = userDetail?.data?.profileImgNew;
      // MyData.employeeId = employeeId! ;
      MyData.token = idTokens;
      MyData.fullname = fullname ?? '';
      MyData.fullnameLa = fullnameLa ?? '';
      MyData.email = email ?? '';
      MyData.mobile = mobile ?? '';
      MyData.division_name = divisionName ?? '';
      MyData.department_name = departmentName ?? '';
      MyData.level = level ?? '';
      MyData.age = "${res.data?.age ?? ''}";
      MyData.dob = "${res.data?.dob ?? ''}";
      MyData.gender = "${res.data?.gender ?? ''}";
      MyData.workingArea = "${res.data?.workingArea ?? ''}";
      MyData.workingType = "${res.data?.workingType ?? ''}";
      MyData.profileImg = res.data?.profileImgNew ?? '';
      MyData.field_location_id = res.data?.fieldLocationId ?? 0;
      MyData.urlMap = res.data?.mapUrl ?? '';

      MyData.levelID = res.data?.levelId;

      // print(MyData.urlMap);

      // _savePreference("employee_id", employeeId);
      // _savePreference("token", idTokens);

      notifyListeners();
    }
  }

  set pendingDays(val) {
    _pendingDay = val;
    notifyListeners();
  }

  set countHR(val) {
    _countHR = val;
    notifyListeners();
  }

  set prCount1(val) {
    _countPr = val;
    notifyListeners();
  }

  setPendingDay() async {
    final user = FirebaseAuth.instance.currentUser!;
    final idTokens = await user.getIdToken();

    if (idTokens!.isNotEmpty && idTokens != "") {
      final res = await APIService().getPendingDay(idTokens);

      pendingDays = res;

      final pendingDay = pendingDays?.data?.pendingDay;

      MyData.pendingday = pendingDay ?? 0;

      notifyListeners();
    }
  }

  setCountHR() async {
    final user = FirebaseAuth.instance.currentUser!;
    final idTokens = await user.getIdToken();

    if (idTokens!.isNotEmpty && idTokens != "") {
      final res = await APIService().getCountHr(idTokens);

      countHR = res;

      final countHRDay = countHR?.data?.overtimeApprove;

      MyData.countHR = countHRDay ?? 0;

      notifyListeners();
    }
  }

  setCountPR() async {
    final user = FirebaseAuth.instance.currentUser!;
    final idTokens = await user.getIdToken();

    if (idTokens!.isNotEmpty && idTokens != "") {
      final res = await APIService().getCountProject(idTokens);

      prCount1 = res;

      MyData.countPRM = res.data!.overtimeApprove ?? 0;

      notifyListeners();
    }
  }

  set listOtSuccess(val) {
    _listOtSuccess = val;
    notifyListeners();
  }

  set listOtPading(val) {
    _listOtPading = val;
    notifyListeners();
  }

  setListOT() async {
    final user = FirebaseAuth.instance.currentUser!;
    final idTokens = await user.getIdToken();

    if (idTokens!.isNotEmpty && idTokens != "") {
      final ListOtSuccess = await APIService().getListOTSuccess(idTokens);
      final ListOtPading = await APIService().getListOTPading(idTokens);
      listOtPading = ListOtPading;
      listOtSuccess = ListOtSuccess;
      notifyListeners();
    }
  }

  set adminOtPadding(val) {
    _adminOtPadding = val;
    notifyListeners();
  }

  set adminOtSuccess(val) {
    _adminOtSuccess = val;
    notifyListeners();
  }

  setListAdminOT() async {
    final user = FirebaseAuth.instance.currentUser!;
    final idTokens = await user.getIdToken();

    if (idTokens!.isNotEmpty && idTokens != "") {
      final AdminOtSuccess = await APIService().getListAdminOTSuccess(idTokens, EmployeeId.toString());
      final AdminOtPadding = await APIService().getListAdminOTPading(idTokens, EmployeeId.toString());
      adminOtPadding = AdminOtPadding;
      adminOtSuccess = AdminOtSuccess;
      notifyListeners();
    }
  }

  set listSuccess(val) {
    _listSuccess = val;
    notifyListeners();
  }

  set listPadding(val) {
    _listPadding = val;
    notifyListeners();
  }

  set checkingStartOt(val) {
    _checkingStartOt = val;
    notifyListeners();
  }

  SetCheckingStartOT() async {
    final user = FirebaseAuth.instance.currentUser!;
    final idTokens = await user.getIdToken();

    if (idTokens!.isNotEmpty && idTokens != "") {
      final CheckingStartOt = await APIService().CheckingStartOtNow(idTokens);

      checkingStartOt = CheckingStartOt;

      notifyListeners();
    }
  }

  set stdCheckingOt(val) {
    _stdCheckingOt = val;
    notifyListeners();
  }

  CheckingOt() async {
    final user = FirebaseAuth.instance.currentUser!;
    final idTokens = await user.getIdToken();

    if (idTokens!.isNotEmpty && idTokens != "") {
      final StdCheckingOt = await APIService().CheckingStdOTCreate(idTokens);

      stdCheckingOt = StdCheckingOt;

      notifyListeners();
    }
  }

  setList() async {
    final user = FirebaseAuth.instance.currentUser!;
    final idTokens = await user.getIdToken();

    if (idTokens!.isNotEmpty && idTokens != "") {
      final ListPadding = await APIService().getListPadding(idTokens);
      final ListSuccess = await APIService().getListSuccess(idTokens);

      listPadding = ListPadding;
      listSuccess = ListSuccess;

      notifyListeners();
    }
  }

  set leavesById(val) {
    _leavesById = val;
    notifyListeners();
  }

  setLeaveByID() async {
    final user = FirebaseAuth.instance.currentUser!;
    final idTokens = await user.getIdToken();

    if (idTokens!.isNotEmpty && idTokens != "") {
      final LeavesById = await APIService().getLeaveByID(idTokens, LeaveId.toString());

      leavesById = LeavesById;

      notifyListeners();
    }
  }

  set leaveAdminById(val) {
    _leaveAdminById = val;
    notifyListeners();
  }

  setLeaveAdminByID() async {
    final user = FirebaseAuth.instance.currentUser!;
    final idTokens = await user.getIdToken();

    if (idTokens!.isNotEmpty && idTokens != "") {
      final LeavesById = await APIService().getLeaveAdminByID(idTokens, LeaveAdminId.toString(), EmployeeId.toString());

      leaveAdminById = LeavesById;

      notifyListeners();
    }
  }

  set otById(val) {
    _otById = val;
    notifyListeners();
  }

  setOTByID() async {
    final user = FirebaseAuth.instance.currentUser!;
    final idTokens = await user.getIdToken();

    if (idTokens!.isNotEmpty && idTokens != "") {
      final OtById = await APIService().getOTByID(idTokens, OTId.toString());

      otById = OtById;

      notifyListeners();
    }
  }

  set adminOtById(val) {
    _adminOtById = val;
    notifyListeners();
  }

  setAdminOTByID() async {
    final user = FirebaseAuth.instance.currentUser!;
    final idTokens = await user.getIdToken();

    if (idTokens!.isNotEmpty && idTokens != "") {
      final AdminOtById = await APIService().getAdminOTByID(idTokens, OTAdminId.toString(), EmployeeId.toString());

      adminOtById = AdminOtById;

      notifyListeners();
    }
  }

  set timesheetListDetial(val) {
    _timesheetListDetial = val;
    notifyListeners();
  }

  set timesheetDateDetial(val) {
    _timesheetDateDetial = val;
    notifyListeners();
  }

  setTimesheetListDetial(context) async {
    final user = FirebaseAuth.instance.currentUser!;
    final idTokens = await user.getIdToken();

    // if (idTokens!.isNotEmpty && idTokens != "") {
    // int Nday = timeSheetList!.day;
    // int Nmonth = timeSheetList!.month;
    // int Nyear = timeSheetList!.year;
    // print(_remark.text);
    //  Nmonth >= 10 ? Nmonth : "0${Nmonth}"
    //String date = "${Nyear}-${Nmonth >= 10 ? Nmonth : "0${Nmonth}"}-${Nday >= 10 ? Nday : "0${Nday}"}";
    _isloading = true;

    final resTimesheetListDetial = await APIService().getTimesheetListDetial(context);
    final resTimesheetDateDetial = await APIService().getTimesheetDateDetial(context);

    timesheetListDetial = resTimesheetListDetial;
    timesheetDateDetial = resTimesheetDateDetial;
    _isloading = false;

    notifyListeners();
    //}
  }

  GetTimeAttendanceModels? _timeattendance;
  GetTimeAttendanceModels? get timeattendance => _timeattendance;
  Future<void> getTimeAttendance(context) async {
    _isloading = true;
    _timeattendance = await TimeAttendance().getTimeAttendance(context);
    _isloading = false;
    notifyListeners();
  }

  DateTime? AdmintimeSheetList;
  SetAdminTimeSheetItem(DateTime dateTime) async {
    // print(dateTime);

    AdmintimeSheetList = dateTime;
    // final response = await APIService().getCheckFieldLocations(checkinlatlng);
    // checkFieldLocations = response;
    notifyListeners();
  }

  set adminTimesheetListDetial(val) {
    _adminTimesheetListDetial = val;
    notifyListeners();
  }

  set adminTimesheetDateDetial(val) {
    _adminTimesheetDateDetial = val;
    notifyListeners();
  }

  setAdminTimesheetListDetial() async {
    final user = FirebaseAuth.instance.currentUser!;
    final idTokens = await user.getIdToken();

    if (idTokens!.isNotEmpty && idTokens != "") {
      int Nday = AdmintimeSheetList!.day;
      int Nmonth = AdmintimeSheetList!.month;
      int Nyear = AdmintimeSheetList!.year;

      // EmployeeId
      // print(_remark.text);
      //  Nmonth >= 10 ? Nmonth : "0${Nmonth}"
      String date = "${Nyear}-${Nmonth >= 10 ? Nmonth : "0${Nmonth}"}-${Nday >= 10 ? Nday : "0${Nday}"}";

      final resTimesheetListDetial =
          await APIService().getAdminTimesheetListDetial(idTokens, date, EmployeeId.toString());
      final resTimesheetDateDetial =
          await APIService().getAdminTimesheetDateDetial(idTokens, date, EmployeeId.toString());

      adminTimesheetListDetial = resTimesheetListDetial;
      adminTimesheetDateDetial = resTimesheetDateDetial;

      notifyListeners();
    }
  }

  setAttendanceHistory() async {
    final user = FirebaseAuth.instance.currentUser!;
    final idTokens = await user.getIdToken();
    if (idTokens!.isNotEmpty && idTokens != "") {
      if (attendancehistory != null) {
        attendancehistory = await APIService().getAttendanceHistory(idTokens);
      }

      notifyListeners();
    }
  }

  setHistoryInDay() async {
    final user = FirebaseAuth.instance.currentUser!;
    final idTokens = await user.getIdToken();
    if (idTokens!.isNotEmpty && idTokens != "") {
      historyinday = await APIService().getHistoryInDay();
      notifyListeners();
    }
  }

  setTeamWork() async {
    final user = FirebaseAuth.instance.currentUser!;
    final idTokens = await user.getIdToken();
    print("token==${idTokens}");

    if (idTokens!.isNotEmpty && idTokens != "") {
      teamwork = await APIService().getTeamwork(idTokens);

      notifyListeners();
    }
  }

  Future<void> setLeaveType() async {
    final user = FirebaseAuth.instance.currentUser!;
    final idTokens = await user.getIdToken();
    if (idTokens!.isNotEmpty && idTokens != "") {
      _isloading = true;
      _leavetype = await APIService().getLeaveType(idTokens);
      _isloading = false;
    }
    notifyListeners();
  }

  setStartWorkAll() async {
    final user = FirebaseAuth.instance.currentUser!;
    final idTokens = await user.getIdToken();
    if (idTokens!.isNotEmpty && idTokens != "") {
      startwork_all = await APIService().getStartworkAll();
      holidaycalenda = await APIService().getHolidayCalenda();
      //    locationall = await APIService().getLocationAll();
      sundayall = await APIService().getSundayAll();
      timesheetsapprovals = await APIService().getTimesheetsApprovals();

      timesheetsleave = await APIService().getTimesheetsLeave();

      notifyListeners();
    }
  }

  setMapAll() async {
    final user = FirebaseAuth.instance.currentUser!;
    final idTokens = await user.getIdToken();
    if (idTokens!.isNotEmpty && idTokens != "") {
      locationall = await APIService().getLocationAll();

      notifyListeners();
    }
  }

  set checkAttend(val) {
    _checkAttend = val;
    notifyListeners();
  }

  setCheckAttend() async {
    final user = FirebaseAuth.instance.currentUser!;
    final idTokens = await user.getIdToken();
    if (idTokens!.isNotEmpty && idTokens != "") {
      final res = await APIService().getCheckAttend(idTokens);

      checkAttend = res;

      notifyListeners();
    }
  }

  set checkSundayAndHoliday(val) {
    _checkSundayAndHoliday = val;
    notifyListeners();
  }

  setSundayAndHoliday() async {
    final user = FirebaseAuth.instance.currentUser!;
    final idTokens = await user.getIdToken();
    if (idTokens!.isNotEmpty && idTokens != "") {
      final res = await APIService().getSundayAndHoliday(idTokens);

      checkSundayAndHoliday = res;
      notifyListeners();
    }
  }

  set checkFieldLocations(val) {
    _checkFieldLocations = val;
    notifyListeners();
  }

  SetCheckFieldLocations(String checkinlatlng) async {
    print(checkinlatlng);
    final response = await APIService().getCheckFieldLocations(checkinlatlng);
    checkFieldLocations = response;
  }

  SetTimeSheetItem(DateTime dateTime) async {
    // print(dateTime);

    timeSheetList = dateTime;
    // final response = await APIService().getCheckFieldLocations(checkinlatlng);
    // checkFieldLocations = response;
    notifyListeners();
  }

  setLocation() async {
    _userLocation = await _determinePosition();
    // print(userLocation);
    notifyListeners();
    // MyData.checkinlatlng = userLocation.;
  }

  Future<location.Position> _determinePosition() async {
    location.LocationPermission permission;

    permission = await location.Geolocator.checkPermission();

    if (permission == location.LocationPermission.denied) {
      permission = await location.Geolocator.requestPermission();
      if (permission == location.LocationPermission.denied) {
        return Future.error('Location Permissions are denied');
      }
    }
    return await location.Geolocator.getCurrentPosition();
  }

  final lang = "lang";

  String? langs = "en";
  String? get langUA => langs;

  Future<String?> savePreference(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString(lang, value);

    notifyListeners();

    return lang;
  }

  changeLanguage(val) {
    savePreference(val);
    notifyListeners();
  }

  Future<String?> _getPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(lang);
  }

  Future<void> initLang() async {
    langs = await _getPreference();
    notifyListeners();
  }

  Future<bool> checkInNew(String checkinlatlng, String path, context) async {
    final timer = Provider.of<TimerProvider>(context, listen: false);

    print(checkinlatlng);
    final response = await APIService().checkIn(checkinlatlng, path, context);

    if (response == 'OK') {
      await setCheckAttend();
      timer.startTimer(context);

      return true;
    } else {
      return false;
    }
  }

  Future<bool> checkOutNew(String checkinlatlng, context) async {
    final user = FirebaseAuth.instance.currentUser!;
    String? idTokens = await user.getIdToken();

    final isSuccess = await APIService().getCheckout(idTokens!, checkinlatlng, context);

    if (isSuccess == true) {
      // EtimesheetId == null ;
      // SetStdTimesheet(0);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateProfiles(String path) async {
    final response = await APIService().updateprofile(path);

    if (response == 'OK') {
      setUserDetailModel();

      return true;
    } else {
      return false;
    }
  }

  bool loadding_activepage = true;
  int loadding_activepagestd = 1;

  bool loadding_teamwork = true;
  int loadding_teamworkstad = 1;

  Refreshactive_page() {
    setHistoryInDay();
    notifyListeners();
  }

  Refreshteamwork_page() {
    setTeamWork();
    notifyListeners();
  }

  bool loadding_home = true;
  int loadding_homestd = 1;
  bool home_std = false;

  bool loadding_noti = true;
  int loadding_notitd = 1;
  bool noti_std = false;

  RefreshHomepahe() async {
    await setAttendanceHistory();
    await setCheckAttend();
    await setUserDetailModel();
    await setSundayAndHoliday();
    await setHistoryInDay();
    await setTeamWork();
    await SetCheckingStartOT();
    notifyListeners();
    // setTeamWork();
    // notifyListeners();
  }

  RefreshHomepahe1() async {
    await setAttendanceHistory();
    await setCheckAttend();
    // await setUserDetailModel();
    // await setSundayAndHoliday();
    // await setHistoryInDay();
    // await setTeamWork();
    // await SetCheckingStartOT();
    notifyListeners();
    // setTeamWork();
    // notifyListeners();
  }

  Future<bool> UpdateTokenMsg() async {
    final user = FirebaseAuth.instance.currentUser!;
    String? idTokens = await user.getIdToken();

    String? tokenMsg = await FirebaseMessaging.instance.getToken();
    // print(tokenMsg.toString());

    final isSuccess = await APIService().getUpdateToken(
        idTokens!,
        Platform.isIOS
            ? "ios"
            : Platform.isAndroid
                ? "android"
                : "",
        tokenMsg.toString());

    if (isSuccess == true) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> AddTimesheeSelect(
      String projectId, String workType, String workcode, String workHour, String remark, context) async {
    final user = FirebaseAuth.instance.currentUser!;
    String? idTokens = await user.getIdToken();

    String? tokenMsg = await FirebaseMessaging.instance.getToken();

    final isSuccess =
        await APIService().AddTimeSheet(idTokens!, projectId, workType, workcode, workHour, remark, context);

    if (isSuccess == true) {
      return true;
    } else {
      return false;
    }
  }

  int? EtimesheetId;
  SetTimeSheetItemDelete(int? EtimesheetIds) async {
    print(EtimesheetIds);

    EtimesheetId = EtimesheetIds;
    // final response = await APIService().getCheckFieldLocations(checkinlatlng);
    // checkFieldLocations = response;
    notifyListeners();
  }

  Future<bool> DelectTimesheetBtId() async {
    final user = FirebaseAuth.instance.currentUser!;
    String? idTokens = await user.getIdToken();

    final isSuccess = await APIService().DelectTimeByEm(idTokens!, EtimesheetId!);

    if (isSuccess == true) {
      EtimesheetId == null;
      return true;
    } else {
      return false;
    }
  }

  Future<bool> AddLeaveNew(
      String startdate, String enddate, String leavetype, String details, String employeeid) async {
    final user = FirebaseAuth.instance.currentUser!;
    String? idTokens = await user.getIdToken();

    final isSuccess = await APIService().AddLeave(
      idTokens!,
      startdate,
      enddate,
      leavetype,
      details,
      employeeid,
    );

    if (isSuccess == true) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> AddOTNew(
    String date,
    String startTime,
    String endTime,
    String detail,
    String projectId,
    String workcode,
  ) async {
    final user = FirebaseAuth.instance.currentUser!;
    String? idTokens = await user.getIdToken();

    String? tokenMsg = await FirebaseMessaging.instance.getToken();

    final isSuccess = await APIService().AddOT(idTokens!, date, startTime, endTime, detail, projectId, workcode);

    if (isSuccess == true) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> CreateCheckInAndOutOTNew(
    String checkinlatlng,
    String overtimeId,
  ) async {
    final user = FirebaseAuth.instance.currentUser!;
    String? idTokens = await user.getIdToken();

    final isSuccess = await APIService().CreateCheckInAndOutOT(idTokens!, checkinlatlng, overtimeId);

    if (isSuccess == true) {
      return true;
    } else {
      return false;
    }
  }

  int? LeaveId;
  int? LeaveIdProcessIndex;

  SetLeaveId(int? leaveId, int? leaveIdProcessIndex) async {
    LeaveId = leaveId;
    LeaveIdProcessIndex = leaveIdProcessIndex;

    notifyListeners();
  }

  int? LeaveAdminId;
  int? LeaveAdminIdProcessIndex;

  SetLeaveAdminId(int? leaveAdminId, int? leaveAdminIdProcessIndex) async {
    LeaveAdminId = leaveAdminId;
    LeaveAdminIdProcessIndex = leaveAdminIdProcessIndex;

    notifyListeners();
  }

  int? OTId;
  int? OTProcessIndex;

  SetOTId(int? otid, int? otidProcessIndex) async {
    OTId = otid;
    OTProcessIndex = otidProcessIndex;

    notifyListeners();
  }

  int? OTAdminId;
  int? OTAdminProcessIndex;

  SetAdminOTId(int? oTAdminId, int? oTAdminProcessIndex) async {
    OTAdminId = oTAdminId;
    OTAdminProcessIndex = oTAdminProcessIndex;

    notifyListeners();
  }

  set userDetailById(val) {
    _userDetailById = val;
    notifyListeners();
  }

  set userImageList(val) {
    _userImageList = val;
    notifyListeners();
  }

  int? EmployeeId;

  SetEmployeeId(int? employeeId) async {
    final user = FirebaseAuth.instance.currentUser!;
    String? idTokens = await user.getIdToken();

    EmployeeId = employeeId;
    notifyListeners();

    if (idTokens!.isNotEmpty && idTokens != "") {
      final res = await APIService().getUserDetailByID(idTokens, employeeId.toString());
      //  final res1 = await APIService().getUserDetailImageByID(idTokens,EmployeeId.toString());

      userDetailById = res;
      //   userImageList = res1;
      //   notifyListeners();
    }
  }

  SetEmployeeIdDetail() async {
    final user = FirebaseAuth.instance.currentUser!;
    String? idTokens = await user.getIdToken();

    //EmployeeId = employeeId;
    notifyListeners();

    if (idTokens!.isNotEmpty && idTokens != "") {
      final res = await APIService().getUserDetailByID(idTokens, EmployeeId.toString());
      //  final res1 = await APIService().getUserDetailImageByID(idTokens,EmployeeId.toString());

      userDetailById = res;
      //   userImageList = res1;
      notifyListeners();
    }
  }

  SetItemEmployeeId() async {
    final user = FirebaseAuth.instance.currentUser!;
    String? idTokens = await user.getIdToken();

    // EmployeeId = employeeId;

    if (idTokens!.isNotEmpty && idTokens != "") {
      //  final res = await APIService().getUserDetailByID(idTokens,EmployeeId.toString());

      // final res1 = await APIService()
      //     .getUserDetailImageByID(idTokens, EmployeeId.toString());

      // userDetailById = res;

      // userImageList = res1;
      print(EmployeeId);
      notifyListeners();
    }
  }

  set adminLeavesPadding(val) {
    _adminLeavesPadding = val;
    notifyListeners();
  }

  set adminLeavesSuccess(val) {
    _adminLeavesSuccess = val;
    notifyListeners();
  }

  setAdminLeaveList() async {
    final user = FirebaseAuth.instance.currentUser!;
    final idTokens = await user.getIdToken();

    if (idTokens!.isNotEmpty && idTokens != "") {
      final AdminLeavesPadding = await APIService().getListAdminLeavesPadding(idTokens, EmployeeId.toString());
      final AdminLeavesSuccess = await APIService().getListAdminLeavesSuccess(idTokens, EmployeeId.toString());

      adminLeavesPadding = AdminLeavesPadding;
      adminLeavesSuccess = AdminLeavesSuccess;

      notifyListeners();
    }
  }

  set adminTimeSheetApprovals(val) {
    _adminTimeSheetApprovals = val;
    notifyListeners();
  }

  set adminTimeSheetPadding(val) {
    _adminTimeSheetPadding = val;
    notifyListeners();
  }

  setAdminTimeSheetList() async {
    final user = FirebaseAuth.instance.currentUser!;
    final idTokens = await user.getIdToken();

    if (idTokens!.isNotEmpty && idTokens != "") {
      final AdminTimeSheetPadding = await APIService().getListAdminTimesheetPadding(idTokens, EmployeeId.toString());
      final AdminTimeSheetApprovals = await APIService().getListAdminTimesheetSuccess(idTokens, EmployeeId.toString());

      adminTimeSheetPadding = AdminTimeSheetPadding;
      adminTimeSheetApprovals = AdminTimeSheetApprovals;

      notifyListeners();
    }
  }

  Future<bool> ApprovalLeaves(
    String isApproved,
    String eLeaveId,
    String remark,
  ) async {
    final user = FirebaseAuth.instance.currentUser!;
    String? idTokens = await user.getIdToken();

    final isSuccess = await APIService().ApprovalLeaves(idTokens!, isApproved, eLeaveId, remark);

    if (isSuccess == true) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> ApprovalOverTime(
    String isApproved,
    String eOvertimeId,
    String remark,
  ) async {
    final user = FirebaseAuth.instance.currentUser!;
    String? idTokens = await user.getIdToken();

    final isSuccess = await APIService().ApprovalOverTime(idTokens!, isApproved, eOvertimeId, remark);

    if (isSuccess == true) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> UpdateNotiCout() async {
    final user = FirebaseAuth.instance.currentUser!;
    String? idTokens = await user.getIdToken();

    final isSuccess = await APIService().UpdateNotiCout(idTokens!);

    if (isSuccess == true) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> ApprovalTimeSheet(
    String isPassed,
    String remark,
  ) async {
    final user = FirebaseAuth.instance.currentUser!;
    String? idTokens = await user.getIdToken();

    int Nday = AdmintimeSheetList!.day;
    int Nmonth = AdmintimeSheetList!.month;
    int Nyear = AdmintimeSheetList!.year;

    // EmployeeId
    // print(_remark.text);
    //  Nmonth >= 10 ? Nmonth : "0${Nmonth}"
    String date = "${Nyear}-${Nmonth >= 10 ? Nmonth : "0${Nmonth}"}-${Nday >= 10 ? Nday : "0${Nday}"}";

    final isSuccess = await APIService().ApprovalTimeSheet(idTokens!, isPassed, date, remark, EmployeeId.toString());

    if (isSuccess == true) {
      return true;
    } else {
      return false;
    }
  }

  /////Models HR

  HrApprovedModels? _hrApprovedModels;
  HrApprovedModels? get hrApproved => _hrApprovedModels;
  HrCheckingSuccessModels? _hrCheckingsuccess;
  HrCheckingSuccessModels? get hrCheckingsuccess => _hrCheckingsuccess;

  //PM Models
  PmModels? _pmModels;
  PmModels? get pmModels => _pmModels;
  PmSuccessModels? _pmsuccess;
  PmSuccessModels? get pmsuccess => _pmsuccess;

  //DR Models
  DrAwaitModels? _drAwaitModels;
  DrAwaitModels? get drAwaitModels => _drAwaitModels;
  DrSuccessModels? _drSuccessModels;
  DrSuccessModels? get drSuccessModels => _drSuccessModels;

  //DR Approve
  GetAllForApproveTimeSheetModels? _getallapprove;
  GetAllForApproveTimeSheetModels? get getallapprove => _getallapprove;
  GetTimeSheetsAllMonthandYearModels? _gettimesheetallmonthyear;
  GetTimeSheetsAllMonthandYearModels? get gettimesheetallmonthyear => _gettimesheetallmonthyear;

  DrApprovedSuccessModels? _drApproveSuccess;
  DrApprovedSuccessModels? get drApproveSuccess => _drApproveSuccess;

  TimeSheetPandingDaysModels? _timeSheetPanding;
  TimeSheetPandingDaysModels? get timeSheetPanding => _timeSheetPanding;

  TotalCountModels? _totalCount;
  TotalCountModels? get totalCount => _totalCount;

  // WorkTypeModels? _workType;
  // WorkTypeModels? get workTypeall => _workType;
  ProjectAllModels? _projectAll;
  ProjectAllModels? get projectAllmodels => _projectAll;
  WorkCodeModels? _workCode;
  WorkCodeModels? get workCodeall => _workCode;

  HrLeaveRequestModels? _hrLeaveRequest;
  HrLeaveRequestModels? get hrLeaveRequest => _hrLeaveRequest;

  LeaveFriendsModels? _leaveFriends;
  LeaveFriendsModels? get leaveFriends => _leaveFriends;

  GetMyOverTimeModels? _overTime;
  GetMyOverTimeModels? get overTime => _overTime;

  Future<void> getovertimawait() async {
    _isloading = true;
    _overTime = await MyOTService().getMyOvertimAwait();
    _isloading = false;
    notifyListeners();
  }

  Future<void> getovertimSuccess() async {
    _isloading = true;
    _overTime = await MyOTService().getMyOvertimSuccess();
    _isloading = false;
    notifyListeners();
  }

  ////////////////////////////////////////////////////////////////
  Future<void> getLeavePro() async {
    final user = FirebaseAuth.instance.currentUser!;
    String? token = await user.getIdToken();

    _isloading = true;
    _leave = await APIService().getLeave(token);
    _isloading = false;

    notifyListeners();
  }

  Future<void> getOverTimeProjectPro() async {
    final user = FirebaseAuth.instance.currentUser!;
    String? token = await user.getIdToken();
    if (_overtimeproject == null) {
      _isloading = true;
      _overtimeproject = await APIService().getOverTimeProject(token);
      _isloading = false;
    }
    notifyListeners();
  }

  Future<void> getOverTimeCountPro() async {
    final user = FirebaseAuth.instance.currentUser!;
    String? token = await user.getIdToken();

    _isloading = true;
    _overtimecount = await APIService().getOverTimeCount(token);
    if (_overtimecount != null) {
      MyData.countOvertime = _overtimecount!.data.overtimeApprove;
    }
    _isloading = false;

    notifyListeners();
  }

  Future<void> getOverTimeExecultsPro() async {
    final user = FirebaseAuth.instance.currentUser!;
    String? token = await user.getIdToken();
    if (_executiveApprove == null) {
      _isloading = true;
      _executiveApprove = await APIService().getOvertimeExecutiveApprove(token);
      _isloading = false;
    }
    notifyListeners();
  }

  Future<void> getOverTimeExecultsCountPro() async {
    final user = FirebaseAuth.instance.currentUser!;
    String? token = await user.getIdToken();
    _overtimeexeccount = await APIService().getOvertimeExecutiveCount(token);
    if (_overtimeexeccount != null) {
      MyData.Overtimexecount = _overtimeexeccount!.data.overtimeApprove;
    }
    notifyListeners();
  }

  ///hr
  Future<void> getHRApprovedPro() async {
    final user = FirebaseAuth.instance.currentUser!;
    String? token = await user.getIdToken();

    _isloading = true;
    _hrApprovedModels = await HRService().getHRApproved(token);
    checkStatusHR(_hrApprovedModels);
    _isloading = false;

    notifyListeners();
  }

  bool? _status;
  bool? get status => _status;

  void checkStatusHR(HrApprovedModels? data) {
    for (var i in data!.data!) {
      if (i.oStatusId == 3 || ((i.oStatusId == 4 || i.oStatusId == -1) && i.statusApproved! > 0)) {
        _status = true;
      } else {
        _status = false;
      }
    }
    notifyListeners();
  }

  Future<void> getHRCheckSucces() async {
    _isloading = true;
    _hrCheckingsuccess = await HRApprovedService().getHRCheckingSuccess();
    _isloading = false;

    notifyListeners();
  }

  Future<void> getPMPro() async {
    _isloading = true;
    _pmModels = await PMService().getPmService();
    checkStatusPM(_pmModels);
    _isloading = false;

    notifyListeners();
  }

  void checkStatusPM(PmModels? data) {
    for (var i in data!.data!) {
      if (i.oStatusId == 1 || ((i.oStatusId == 2 || i.oStatusId == -1) && i.statusApproved! > 0)) {
        _status = true;
      } else {
        _status = false;
      }
    }
    notifyListeners();
  }

  Future<void> getPMSuccessPro() async {
    _isloading = true;
    _pmsuccess = await PMService().getPmSuccess();
    _isloading = false;

    notifyListeners();
  }

  Future<void> getDRAwaitPro() async {
    _isloading = true;
    _drAwaitModels = await DRService().getDrAwait();
    checkStatusDR(_drAwaitModels);
    _isloading = false;

    notifyListeners();
  }

  void checkStatusDR(DrAwaitModels? data) {
    for (var i in data!.data!) {
      if (i.oStatusId == 2 || ((i.oStatusId == 3 || i.oStatusId == -1) && i.statusApproved! > 0)) {
        _status = true;
      } else {
        _status = false;
      }
    }
    notifyListeners();
  }

  Future<void> getDRSuccessPro() async {
    _isloading = true;
    _drSuccessModels = await DRService().getDRSuccessSer();
    _isloading = false;

    notifyListeners();
  }

  Future<void> getallformapprovetimesheetPro() async {
    _isloading = true;
    _getallapprove = await DRApproveService().getAllForApproveTimeSheet();

    _isloading = false;
    notifyListeners();
  }

  Future<void> getTimeSheetsMonthYearPro(context) async {
    _isloading = true;
    _gettimesheetallmonthyear = await DRApproveService().getTimeMonthAndYears(context);
    _isloading = false;
    notifyListeners();
  }

  Future<void> getTimeSheetsSuccess(context) async {
    _isloading = true;
    _drApproveSuccess = await DRApproveService().getDRApprovedSuccess(context);
    _isloading = false;
    notifyListeners();
  }

  Future<void> getTimeSheetsPandingdays() async {
    _isloading = true;
    _timeSheetPanding = await DasBoardService().timesheetpandingday();
    _isloading = false;
    notifyListeners();
  }

  Future<void> getTotalCountPro() async {
    _isloading = true;
    _totalCount = await APIService().getTotalCount();
    _isloading = false;
    notifyListeners();
  }

  // Future<void> getWorkTypeandProject(context) async {
  //   if (_workCode == null || _workType == null || _projectAll == null) {
  //     _isloading = true;
  //     _workType = await WorkTypeService().getWorkType();
  //     _workCode = await WorkTypeService().getWorkCode(context);
  //     _projectAll = await WorkTypeService().getWorkProjecall();
  //     _isloading = false;
  //     notifyListeners();
  //   }
  // }

  Future<HrLeaveRequestModels?> getHrLeaveReq() async {
    _isloading = true;
    _hrLeaveRequest = await HRLeaveRequestService().getHRLeaveRequest();
    checkStatusHRReuq(_hrLeaveRequest);
    _isloading = false;
    notifyListeners();
    return _hrLeaveRequest;
  }

  void checkStatusHRReuq(HrLeaveRequestModels? data) {
    for (var i in data!.data!) {
      if (i.lStatusId == 3 || ((i.lStatusId == 4 || i.lStatusId == -1) && i.statusApproved! > 0)) {
        _status = true;
      } else {
        _status = false;
      }
    }
    notifyListeners();
  }

  Future<void> getHrLeaveReqSuccess() async {
    _isloading = true;
    _hrLeaveRequest = await HRLeaveRequestService().getHRLeaveRequestSuccess();
    _isloading = false;
    notifyListeners();
  }

  Future<void> getLeaveFirendsPro() async {
    _isloading = true;
    _leaveFriends = await TMServicer().getleavefirends();
    checkStatusTM(_leaveFriends);
    _isloading = false;
    notifyListeners();
  }

  void checkStatusTM(LeaveFriendsModels? data) {
    for (var i in data!.data!) {
      if (i.levelId != 3 ||
          (i.lStatusId == 1 ||
              i.lStatusId == -1 ||
              i.lStatusId == 2 ||
              (i.approvedBy == null || i.statusApproved! > 0))) {
        if (i.levelId == 3 || (i.lStatusId != 4 || (i.statusUser == 2 || i.statusApproved == 2 || i.lStatusId == 2))) {
          _status = true;
        }
      } else {
        _status = false;
      }
    }
    notifyListeners();
  }

  Future<void> getLeaveFirendsSuccPro() async {
    _isloading = true;
    _leaveFriends = await TMServicer().getleavefirendsSuccess();
    _isloading = false;
    notifyListeners();
  }
}
