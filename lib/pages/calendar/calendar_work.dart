import 'package:flutter/material.dart';
import 'package:fms_mobile_app/pages/calendar/provider/calenda_provicer.dart';
import 'package:fms_mobile_app/pages/calendar/screen/add_time_sheets.dart';
import 'package:fms_mobile_app/pages/timesheets/timesheet_list.dart';
import 'package:fms_mobile_app/theme/color.dart';
import 'package:fms_mobile_app/utils/set/set_status.dart';
import 'package:fms_mobile_app/widgets/loading/loading_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final DateFormat formatDate = DateFormat("yyyy-MM-dd");
  final DateTime endDate = DateTime(2040, 12, 31);
  DateTime? _selectedDate;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _loadCalendarData();
    });
    super.initState();
  }

  void _loadCalendarData() async {
    print("Loading calendar data...");
    final calendarVm = Provider.of<CalendarProvider>(context, listen: false);
    await calendarVm.initAllCalenda(context);
    print("Calendar data loaded!");
  }

  // void _loadCalendarData() async {
  //   final calendarVm = Provider.of<CalendarProvider>(context, listen: false);
  //   calendarVm.initAllCalenda(context);
  // }

  Widget _buildCalendarBody(CalendarProvider provider) {
    if (provider.isLoading == true) {
      return const LoadingWidget();
    } else {
      return SfCalendar(
        scheduleViewSettings: const ScheduleViewSettings(
          appointmentTextStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.white,
            fontFamily: 'NotoSansLao',
          ),
        ),
        monthViewSettings: const MonthViewSettings(
            showTrailingAndLeadingDates: false,
            dayFormat: 'EEE',
            appointmentDisplayCount: 5,
            navigationDirection: MonthNavigationDirection.horizontal,
            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
        view: CalendarView.month,
        onViewChanged: (ViewChangedDetails details) async {
          if (details.visibleDates.isNotEmpty) {
            DateTime visibleDate = details.visibleDates[0];
            String formatMonth = DateFormat('MM').format(visibleDate);
            String formatYears = DateFormat('yyyy').format(visibleDate);

            provider.setDataMonthCalendar(formatMonth);
            provider.setDataYearsCalendar(formatYears);
            provider.getAllLeave(context);
            provider.getAllTimeSheets(context);
            provider.getAllcalendasetup(context);
            await provider.getAllAttendance(context);
          }
        },
        dataSource: _getCalendarDataSource(context),
        onTap: (CalendarTapDetails details) {
          for (var i in provider.attendance!.data!) {
            if (i.date != null) {
              if (formatDate.format(details.date!) == formatDate.format(i.date!)) {
                print("hiiii");
                Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => TimeSheetList(),
            ),
          );
                break;
              } else {
                print("no");
              }
            }
          }
          

          setState(() {
            _selectedDate = details.date;
          });
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
         backgroundColor: primary,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        title: const Text(
          'ປະຕິທິນ',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<CalendarProvider>(builder: (context, provider, child) {
        return _buildCalendarBody(provider);
      }),
      bottomSheet: _selectedDate != null
          ? Container(
              color: Colors.grey[200],
              padding: const EdgeInsets.all(16),
              child: Text('Selected Date: ${_selectedDate.toString()}'),
            )
          : null,
    );
  }

  _DataSource _getCalendarDataSource(BuildContext context) {
    final List<Appointment> appointments = [];
    final provider = Provider.of<CalendarProvider>(context, listen: false);

    // Generate appointments for all Sundays in the year 2023
    DateTime startDate = DateTime(2021, 1, 1);

    while (startDate.isBefore(endDate)) {
      if (provider.leaveCalenda!.data!.isNotEmpty) {
        for (var i in provider.leaveCalenda!.data!) {
          final Appointment holiday = Appointment(
              subject: i.lStatusName ?? "",
              startTime: startDate,
              endTime: startDate.add(const Duration(hours: 23, minutes: 59)),
              color: Colors.blueAccent,
              startTimeZone: 'SE Asia Standard Time',
              endTimeZone: 'SE Asia Standard Time',
              isAllDay: true);

          if (formatDate.format(startDate) == formatDate.format(i.date!)) {
            appointments.add(holiday);
          }
        }
      }

      if (provider.attendance?.data != []) {
        for (var i in provider.attendance!.data!) {
          if (i.date != null) {
            final Appointment arrived = Appointment(
                subject: "ມາວຽກ",
                startTime: i.date!,
                endTime: startDate.add(
                  const Duration(hours: 23, minutes: 59),
                ),
                color: primary,
                startTimeZone: 'SE Asia Standard Time',
                endTimeZone: 'SE Asia Standard Time',
                isAllDay: false);

            if (formatDate.format(startDate) == formatDate.format(i.date!)) {
              appointments.add(arrived);
            }
          }
        }
      }

      if (provider.timeSheetsCalenda?.data != null) {
        for (var i in provider.timeSheetsCalenda!.data!) {
          Appointment timeSheet = Appointment(
              subject: SetStatus().status(context, i.status!),
              startTime: i.date!,
              endTime: startDate.add(const Duration(hours: 23, minutes: 59)),
              color: SetStatus().statusColor(i.status!),
              startTimeZone: 'SE Asia Standard Time',
              endTimeZone: 'SE Asia Standard Time',
              // recurrenceRule:  Icons.abc_sharp,
              isAllDay: false);
          if (formatDate.format(startDate) == formatDate.format(i.date!)) {
            appointments.add(timeSheet);
          }
        }
      }

      if (provider.calendaSetUp?.data != null) {
        for (var i in provider.calendaSetUp!.data!) {
          Appointment calendasetup = Appointment(
              subject: i.details!,
              startTime: i.date!,
              endTime: startDate.add(const Duration(hours: 23, minutes: 59)),
              color: red,
              startTimeZone: 'SE Asia Standard Time',
              endTimeZone: 'SE Asia Standard Time',
              // recurrenceRule:  Icons.abc_sharp,
              isAllDay: false);
          if (formatDate.format(startDate) == formatDate.format(i.date!)) {
            appointments.add(calendasetup);
          }
        }
      }
      startDate = startDate.add(
        const Duration(days: 1),
      );
    }
    return _DataSource(appointments);
  }
}

class _DataSource extends CalendarDataSource {
  _DataSource(List<Appointment> source) {
    appointments = source;
  }
}
