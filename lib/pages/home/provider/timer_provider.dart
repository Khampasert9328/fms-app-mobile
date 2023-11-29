import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fms_mobile_app/model/check_attend.dart';
import 'package:fms_mobile_app/services/provider_service.dart';
import 'package:ntp/ntp.dart';
import 'package:provider/provider.dart';

class TimerProvider extends ChangeNotifier {
 
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
    print(val);
    notifyListeners();
  }

    void addTimeOT() {
    setDurationOT = _secondsOT;
  }


  void initTimeOT(context) async {
    final ntpTimes = await NTP.now();
    const laosTimeOffsets = Duration(hours: 0);
    // Laos time offset from UTC
    final provider = Provider.of<ProviderService>(context, listen: false);
    _currentLaosTimes = ntpTimes.add(laosTimeOffsets);
    final checkIn = provider.checkAttend!.data!.checkinTime;
    if (checkIn != null) {
      setSecondOT = ntpTimes.difference(checkIn).inSeconds;
      addTimeOT();
    }
  }

   Future<void> startTimerOT(context) async {
    final provider = Provider.of<ProviderService>(context, listen: false);
    if (provider.checkAttend!.data!.inWork == true) {
      timer = Timer.periodic(const Duration(seconds: 1), (_) => initTimeOT(context));
    }
  }

   void stopTimerOT() {
    timer?.cancel();
  }




  set setSecond(int? val) {
    _second = val ?? 0;
    notifyListeners();
  }

  set setDuration(int? val) {
    _duration = Duration(seconds: val ?? 0);
    print(val);
    notifyListeners();
  }

  void addTime() {
    setDuration = _second;
  }

  // set setAttendModel(CheckAttend? val) {
  //   _checkAttendModel = val;
  //   notifyListeners();
  // }

  void initTime(context) async {
    final ntpTimes = await NTP.now();
    const laosTimeOffsets = Duration(hours: 0);
    // Laos time offset from UTC
    final provider = Provider.of<ProviderService>(context, listen: false);
    _currentLaosTimes = ntpTimes.add(laosTimeOffsets);
    final checkIn = provider.checkAttend!.data!.checkinTime;
    if (checkIn != null) {
      setSecond = ntpTimes.difference(checkIn).inSeconds;
      addTime();
    }
  }

  void stopTimer() {
    timer?.cancel();
  }

  Future<void> startTimer(context) async {
    final provider = Provider.of<ProviderService>(context, listen: false);
    if (provider.checkAttend!.data!.inWork == true) {
      timer = Timer.periodic(const Duration(seconds: 1), (_) => initTime(context));
    }
  }
}
