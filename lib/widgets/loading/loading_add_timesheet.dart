import 'package:flutter/material.dart';
import 'package:fms_mobile_app/pages/calendar/calendar_work.dart';
import 'package:fms_mobile_app/pages/calendar/provider/calenda_provicer.dart';
import 'package:fms_mobile_app/pages/calendar/provider/time_sheet_provider.dart';
import 'package:fms_mobile_app/widgets/loading/loading_success.dart';
import 'package:provider/provider.dart';

class LoadingAddTimeSheets {
  void showDialogSuccess(context) {
    final provider = Provider.of<TimeSheetProvider>(context, listen: false);
    final calendar = Provider.of<CalendarProvider>(context, listen: false);
    showDialog(
        context: context,
        builder: (_) {
          return LoadingDialog(
              title: 'ເພີ່ມ time sheet ສຳເລັດ',
              onTap: () {
                provider.clearProviders();
                calendar.refreshCalendar();
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (_) => const CalendarScreen()));
              });
        });
  }
}
