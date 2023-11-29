// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fms_mobile_app/constant/app_api.dart';
import 'package:fms_mobile_app/pages/calendar/models/request/time_sheet_request.dart';
import 'package:fms_mobile_app/pages/calendar/provider/calenda_provicer.dart';
import 'package:fms_mobile_app/pages/calendar/provider/time_sheet_provider.dart';
import 'package:fms_mobile_app/widgets/loading/loading_success.dart';
import 'package:fms_mobile_app/widgets/loading/loading_widget.dart';
import 'package:provider/provider.dart';

class TimeSheetService {
  final Dio _dio = Dio();

  Future<void> addTimeSheet(BuildContext context, TimeSheetRequest timeSheetRequest) async {
    showDialogSuccess(context);

    final user = await FirebaseAuth.instance.currentUser?.getIdToken();
    String? token = user;

    final res = await _dio.post(
      '${AppAPI.apiPath}/timesheets/submit/previous',
      options: Options(headers: {"Authorization": 'Bearer $token'}),
      data: timeSheetRequest.toJson(),
    );

    if (res.statusCode == 200) {
      print("statusCode:${res.statusCode}");
      showDialogSuccess(context);
      Navigator.pop(context);
    } else {
      throw Exception();
    }
  }

  void showDialogSuccess(context) {
    final provider = Provider.of<TimeSheetProvider>(context, listen: false);
    final calendar = Provider.of<CalendarProvider>(context, listen: false);
    showDialog(
        context: context,
        builder: (_) {
          return LoadingDialog(
              title: 'ເພີ່ມ time sheet ສຳເລັດ',
              onTap: () {
                // provider.clearProviders();
                // calendar.refreshCalendar();
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);
              });
        });
  }



  
}
