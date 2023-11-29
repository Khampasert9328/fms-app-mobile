import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fms_mobile_app/pages/calendar/models/attendance/attendance_models.dart';
import 'package:fms_mobile_app/pages/calendar/models/calendasetup/calendasetup_models.dart';
import 'package:fms_mobile_app/pages/calendar/models/holiday/holidays_models.dart';
import 'package:fms_mobile_app/pages/calendar/models/leavecalenda/leavecalenda_models.dart';
import 'package:fms_mobile_app/pages/calendar/models/response/all_arrive_models.dart';
import 'package:fms_mobile_app/pages/calendar/models/response/time_sheet_response.dart';
import 'package:fms_mobile_app/pages/calendar/models/timesheetscalenda/timesheetscalenda_models.dart';
import 'package:fms_mobile_app/pages/calendar/service/all_arrived.dart';
import 'package:fms_mobile_app/pages/calendar/service/calenda_service.dart';

class CalendarProvider extends ChangeNotifier {
  HolidaysTimeSheetsModels? _holidayModel;
  HolidaysTimeSheetsModels? get holidayModel => _holidayModel;

  AllArrivedModels? _allArrivedModels;
  AllArrivedModels? get allArrivedModel => _allArrivedModels;

  TimeSheetResponse? _timeSheetResponse;
  TimeSheetResponse? get timesheetResponse => _timeSheetResponse;

  bool? _isLoading = false; // Initialize to false by default
  bool? get isLoading => _isLoading;

  String? _setmonthcalenda;
  String? get setmonthcalenda => _setmonthcalenda;
  String? _setyearcalenda;
  String? get setyearcalenda => _setyearcalenda;

  //new Calenda
  TimeSheetsCalendaModels? _timeSheetsCalenda;
  TimeSheetsCalendaModels? get timeSheetsCalenda => _timeSheetsCalenda;
  LeaveCalendaModels? _leaveCalenda;
  LeaveCalendaModels? get leaveCalenda => _leaveCalenda;
  AttendanceCalendaModels? _attendance;
  AttendanceCalendaModels? get attendance => _attendance;
  CalendaSetUpModels? _calendaSetUp;
  CalendaSetUpModels? get calendaSetUp => _calendaSetUp;



  Future<void> getAllTimeSheets(context) async {
    try {
      _timeSheetsCalenda = await CalenDaService().getTimeSheetsCalenda(context);
      notifyListeners();
    } catch (e) {
      print('Error fetching all timesheets data: $e');
    }
  }

  Future<void> getAllLeave(context) async {
    try {
      _leaveCalenda = await CalenDaService().getLeaveCalenda(context);
      notifyListeners();
    } catch (e) {
      print('Error fetching all leave data: $e');
    }
  }

  Future<void> getAllAttendance(context) async {
    try {
      _attendance = await CalenDaService().getAttendanceCalenda(context);
      notifyListeners();
    } catch (e) {
      print('Error fetching all attendance data: $e');
    }
  }

  Future<void> getAllcalendasetup(context) async {
    try {
      _calendaSetUp = await CalenDaService().getCalendaSetUp(context);
      notifyListeners();
    } catch (e) {
      print('Error fetching all calendasetup data: $e');
    }
  }

  Future<void> initAllCalenda(context) async {
    if (_timeSheetsCalenda == null || _leaveCalenda == null || _attendance == null || _calendaSetUp == null) {
      _isLoading = true;
      notifyListeners();
      try {
        await getAllTimeSheets(context);
        await getAllLeave(context);
        await getAllAttendance(context);
        await getAllcalendasetup(context);
      } catch (e) {
        print('Error initializing calendar: $e');
      }
      _isLoading = false;
      notifyListeners();
    }
  }

 

  // Future<void> clearAllCalendar() async {
  //   _timeSheetsCalenda = null;
  //   _leaveCalenda = null;
  //   _attendance = null;
  //   _calendaSetUp = null;
  // }

  //  Future<void> refreshAllCalendar(context) async {
  //   await clearAllCalendar();
  //   initAllCalenda(context);
  // }

  Future<void> setDataMonthCalendar(String? val) async {
    _setmonthcalenda = val;
  }

  Future<void> setDataYearsCalendar(String? val) async {
    _setyearcalenda = val;
  }

  Future<void> getAllArrived() async {
    try {
      _allArrivedModels = await CalendarService().getAllArrived();
      notifyListeners();
    } catch (error) {
      print('Error fetching all arrived data: $error');
    }
  }

  Future<void> getHolidayModel() async {
    try {
      _holidayModel = await CalendarService().holidayService();
      notifyListeners();
    } catch (error) {
      print('Error fetching all arrived data: $error');
    }
  }

  Future<void> getAllTimeSheet() async {
    try {
      _timeSheetResponse = await CalendarService().getAllTimeSheet();
      notifyListeners();
    } catch (error) {
      print('Error fetching all arrived data: $error');
    }
  }

  void initCalendar() async {
    if (_holidayModel == null || _timeSheetResponse == null || _allArrivedModels == null) {
      _isLoading = true;
      notifyListeners();
      try {
        await getAllArrived();
        await getHolidayModel();
        await getAllTimeSheet();
      } catch (error) {
        print('Error initializing calendar: $error');
      }

      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> clearCalendar() async {
    _timeSheetResponse = null;
    _allArrivedModels = null;
    _holidayModel = null;
  }

  Future<void> refreshCalendar() async {
    await clearCalendar();
    initCalendar();
  }
}
