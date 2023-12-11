// ignore_for_file: unused_field

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fms_mobile_app/pages/home/OT/models/check_ot_model.dart';
import 'package:fms_mobile_app/pages/home/OT/service/worktype_service.dart';
import 'package:fms_mobile_app/services/provider_service.dart';
import 'package:ntp/ntp.dart';
import 'package:provider/provider.dart';

class TimerProvider extends ChangeNotifier {
  CheckOtModel? _checkOtModel;
  CheckOtModel? get checkOtModel => _checkOtModel;
  bool _checkbuttonot = false;
  bool get checkbuttonot => _checkbuttonot;
  int _second = 0;

  int? get second => _second;

  Duration _duration = const Duration();

  Duration get duration => _duration;

  DateTime? _currentLaosTimes;

  bool isLoading = false;
  Timer? timer;

  //OT
  int _secondsOT = 0;
  int? get secondOT => _secondsOT;

  Duration _durationOT = const Duration();

  Duration get durationOT => _durationOT;

  DateTime? _currentLaosTimesOT;

  bool isLoadingOT = false;
  Timer? timerOT;

  set setSecondOT(int? val) {
    _secondsOT = val ?? 0;
    notifyListeners();
  }

  set setDurationOT(int? val) {
    _durationOT = Duration(seconds: val ?? 0);
    notifyListeners();
  }

  void addTimeOT() {
    setDurationOT = _secondsOT;
    notifyListeners();
  }

  setCheckButtonOT(bool value) {
    _checkbuttonot = value;
    notifyListeners();
  }

  /// function nup vela
  void initTimeOT(context) async {
    final ntpTimes = await NTP.now();
    const laosTimeOffsets = Duration(hours: 0);
    // Laos time offset from UTC
    // final provider = Provider.of<ProviderService>(context, listen: false);

    /// dueng vela khrng Laos jark server
    _currentLaosTimesOT = ntpTimes.add(laosTimeOffsets);

    /// check in time man vela t lerm kod khor OT
    final checkInTime = _checkOtModel?.data?.checkinTime;
    if (checkInTime != null) {
      /// ao vela khrng Laos trn pah ju bun ma ha khuam harng khrng vi na t jark trn t lerm kod OT
      setSecondOT = ntpTimes.difference(checkInTime).inSeconds;
      addTimeOT();
    }
    notifyListeners();
  }

  Future<void> startTimerOT(context) async {
    ///get khor moun jark OT status khrng user
    _checkOtModel = await WorkTypeService().checkOtTime();

    /// thar hark OT code pen true hai pai lerm function nup vela
    if (_checkOtModel?.code == true) {
      /// timer ja update thouk2 1 vi
      _checkbuttonot = true;
      timerOT = Timer.periodic(const Duration(seconds: 1), (_) => initTimeOT(context));
      notifyListeners();
    }
  }

  void stopTimerOT(context) async {
    final provider = Provider.of<ProviderService>(context, listen: false);
    await provider.setCheckAttend();
    timerOT?.cancel();

    _durationOT = Duration(seconds: 0);
    _checkbuttonot = false;
    notifyListeners();
  }

  set setSecond(int? val) {
    _second = val ?? 0;
    notifyListeners();
  }

  set setDuration(int? val) {
    _duration = Duration(seconds: val ?? 0);
    notifyListeners();
  }

  void addTime() {
    setDuration = _second;
  }

  void initTime(context) async {
    final ntpTimes = await NTP.now();
    const laosTimeOffsets = Duration(hours: 0);
    // Laos time offset from UTC
    final provider = Provider.of<ProviderService>(context, listen: false);
    _currentLaosTimes = ntpTimes.add(laosTimeOffsets);
    final checkIn = provider.checkAttend?.data?.checkinTime;
    if (checkIn != null) {
      setSecond = ntpTimes.difference(checkIn).inSeconds;
      addTime();
    }
    notifyListeners();
  }

  void stopTimer(context) {
    final provider = Provider.of<ProviderService>(context, listen: false);
    provider.setCheckAttend();
    print("dura===${_duration.inMinutes}");
    timer?.cancel();

     print("after dura===${_duration.inMinutes}");
    //_duration = Duration(seconds: 0);
    notifyListeners();
  }

  Future<void> startTimer(context) async {
    final provider = Provider.of<ProviderService>(context, listen: false);
    if (provider.checkAttend!.data!.inWork == true) {
      timer = Timer.periodic(const Duration(seconds: 1), (_) => initTime(context));
      notifyListeners();
    }
  }
}
