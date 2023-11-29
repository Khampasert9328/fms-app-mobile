import 'package:flutter/material.dart';

class TimeSheetProvider extends ChangeNotifier {
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
