import 'package:flutter/material.dart';
import 'package:fms_mobile_app/pages/ot/models/HR/HR_models.dart';
import 'package:fms_mobile_app/pages/ot/HR/models/checkbox_models.dart';
import 'package:fms_mobile_app/services/get_years_service.dart';

class SetItmem extends ChangeNotifier {
  final List<CheckBoxHRModels> _checkboxhrmodels = [];
  List<CheckBoxHRModels> get checkboxhrmodels => _checkboxhrmodels;

  final List<int?> _overTimeId = [];
  List<int?> get overTimeId => _overTimeId;

  int? _setyear;
  int? get setyears => _setyear;

  int? _selectMonth;
  int? get selectMonth => _selectMonth;
  int? _selectYear;
  int? _selectMonthSucees;
  int? _selectYearSucees;
  int? get selectYearSucees => _selectYearSucees;
  int? get selectMonthSucees => _selectMonthSucees;
  int? get selectYear => _selectYear;
  int? _employeid;
  int? get employeeid => _employeid;

  // void setYears(int val) async {
  //   final res = await YearService().getYearsAll();
  //   _setyear = res?.data?[0].pureYear;
  //   notifyListeners();
  // }

  void setEmployeid(int val) {
    _employeid = val;
    notifyListeners();
  }

  void setSelectMonth(int val) {
    _selectMonth = val;
    notifyListeners();
  }

  void setSelectYear(int val) {
    _selectYear = val;
    notifyListeners();
  }

  void setSelectMonthSuccess(int val) {
    _selectMonthSucees = val;
    notifyListeners();
  }

  void setSelectYearSuccess(int val) {
    _selectYearSucees = val;
    notifyListeners();
  }

  bool checked(int? val) {
    bool check = _overTimeId.contains(val);
    return check;
  }

  bool checkSelectAll(List<HRModels> data) {
    if (overTimeId.isEmpty) {
      return false;
    }

    for (var i in data) {
      if (!overTimeId.contains(i.eOvertimeId)) {
        return false;
      }
    }

    return true;
  }

  void toggleCheckbox(int? val) {
    if (_overTimeId.contains(val)) {
      _overTimeId.remove(val);
    } else {
      _overTimeId.add(val);
    }
    print(_overTimeId);
    notifyListeners(); // Notify listeners only when there's a change.
  }

  void selectAllCheckBox(List<HRModels> data) async {
    if (_overTimeId.isEmpty) {
      for (var i in data) {
        _overTimeId.add(i.eOvertimeId);
      }
    } else {
      _overTimeId.clear();
    }
    print(_overTimeId);
    notifyListeners();
  }

  String? _workType;
  String? get workType => _workType;

  String? _project;
  String? get project => _project;

  String? _workCode;
  String? get workCode => _workCode;

  String? _remark;
  String? get remark => _remark;

  set workType(String? val) {
    _workType = val;
    notifyListeners();
  }

  set project(String? val) {
    _project = val;
    notifyListeners();
  }

  set workCode(String? val) {
    _workCode = val;
    notifyListeners();
  }

  set remark(String? val) {
    _remark = val;
    notifyListeners();
  }

  Future<void> clearProviders() async {
    _workType = null;
    _project = null;
    _workCode = null;
    _remark = null;
  }
}
