// ignore_for_file: unrelated_type_equality_checks, use_build_context_synchronously, curly_braces_in_flow_control_structures

import 'dart:async';
import 'dart:io';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fms_mobile_app/pages/Approve/DRApporveWork/screen/main.dart';
import 'package:fms_mobile_app/pages/Approve/HRApproveVacation/screen/hr_request_main.dart';
import 'package:fms_mobile_app/pages/dasboard/dasboard.dart';
import 'package:fms_mobile_app/pages/home/OT/ot_screen.dart';
import 'package:fms_mobile_app/pages/home/OT/service/worktype_service.dart';
import 'package:fms_mobile_app/pages/home/provider/timer_provider.dart';
import 'package:fms_mobile_app/pages/ot/DR/screen/dr_main.dart';
import 'package:fms_mobile_app/pages/calendar/calendar_work.dart';
import 'package:fms_mobile_app/pages/leave/leave_page.dart';
import 'package:fms_mobile_app/pages/mapcompany/map_company.dart';
import 'package:fms_mobile_app/pages/ot/PM/screen/pm_main.dart';
import 'package:fms_mobile_app/pages/ot/TM/screen/tm_main.dart';
import 'package:fms_mobile_app/pages/ot/ot_page.dart';
import 'package:fms_mobile_app/pages/ot/HR/main_hr.dart';
import 'package:fms_mobile_app/pages/teams/team_work.dart';
import 'package:fms_mobile_app/pages/timesheets/timesheet_list.dart';
import 'package:fms_mobile_app/pages/timesheets/timesheet_new.dart';
import 'package:fms_mobile_app/services/auth_service.dart';
import 'package:fms_mobile_app/services/provider_service.dart';
import 'package:fms_mobile_app/shared/mydata.dart';
import 'package:fms_mobile_app/theme/color.dart';
import 'package:fms_mobile_app/widgets/DisplayTimerUI.dart';
import 'package:fms_mobile_app/widgets/ItemWorkHome.dart';
import 'package:fms_mobile_app/widgets/MyElevatedButton_Gray.dart';
import 'package:fms_mobile_app/widgets/MyElevatedButton_Primary.dart';
import 'package:fms_mobile_app/widgets/MyElevatedButton_Secondary.dart';
import 'package:fms_mobile_app/widgets/custom_image.dart';
import 'package:fms_mobile_app/widgets/loading/loading_success.dart';
import 'package:fms_mobile_app/widgets/loading/loading_widget.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:upgrader/upgrader.dart';

class HomePages extends StatefulWidget {
  const HomePages({Key? key}) : super(key: key);

  @override
  _HomePagesState createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  bool? _btnStartisLoading = false;
  bool? stdbtnStart = true;
  bool? _btnStartOTisLoading = false;
  bool? stdbtnStartOT = true;
  bool? _btnEndisLoading = false;
  bool? stdbtnEnd = true;
  Timer? timer;
  Timer? timerOt;
  bool? timeStart = true;
  bool? stdrefresh = false;
  int? checkingStartOt;
  Duration myDuration = const Duration();
  Duration myDurationOT = const Duration();

  final _gradient = const LinearGradient(
    colors: [primary, Colors.purple],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  @override
  void initState() {
    super.initState();

    final authService = Provider.of<AuthService>(context, listen: false);
    // context.read<ProviderService>().getOverTimeCountPro();
    // context.read<ProviderService>().getOverTimeExecultsCountPro();
    context.read<ProviderService>().getTotalCountPro();
    context.read<TimerProvider>().startTimer(context);
    context.read<TimerProvider>().startTimerOT(context);

    if (authService.stdLogin == 1) {
      checkingWorkRe();

      // providerService.setNotiCout();

      setState(() {
        authService.stdLoginInlogin(0);
      });
    } else {
      checkingWork();
    }
  }

  _fuctionNewTap(BuildContext context) async {
    String refresh = await Navigator.push(context, MaterialPageRoute(builder: (context) => const TimeSheetNew()));

    if (refresh == "true") {
      final providerService = Provider.of<ProviderService>(context, listen: false);
      await providerService.SetStdTimesheet(0);
      setState(() => timeStart = false);
      await checkingWorkRe();
      // await StartOT();
      setState(() => _btnEndisLoading = false);
      setState(() => stdbtnEnd = true);
      setState(() => timeStart = true);
    } else if (refresh == "") {
      final providerService = Provider.of<ProviderService>(context, listen: false);
      await providerService.SetStdTimesheet(0);
      setState(() => timeStart = false);
      // await checkingWork();
      // await StartOT();
      setState(() => _btnEndisLoading = false);
      setState(() => stdbtnEnd = true);
      setState(() => timeStart = true);
    }

    if (refresh == "CheckOut") {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: primary,
        content: Text("ເລິ່ມວຽກສຳເລັດ"),
        duration: Duration(seconds: 4),
      ));

      final providerService = Provider.of<ProviderService>(context, listen: false);
      await providerService.SetStdTimesheet(0);
      setState(() => timeStart = false);
      await checkingWorkRe();
      // await StartOT();
      timer?.cancel();
      setState(() => _btnEndisLoading = false);
      setState(() => stdbtnEnd = true);
      setState(() => timeStart = true);
    }
  }

  Future checkingWork() async {
    final providerService = Provider.of<ProviderService>(context, listen: false);

    if (providerService.home_std == false) {
      setState(() {
        providerService.loadding_home = true;
        providerService.loadding_homestd = 1;
      });

      providerService.setUserDetailModel();
      // print(1);
      providerService.setCheckAttend();
      // print(2);
      providerService.setSundayAndHoliday();
      // print(3);
      providerService.setAttendanceHistory();

      providerService.setPendingDay();

      providerService.setHistoryInDay();
      // print(5);
      providerService.setTeamWork();

      providerService.setStartWorkAll();

      providerService.setMapAll();

      providerService.setList();

      providerService.CheckingOt();
      providerService.setListOT();
      //print(6);
      //  providerService.setPendingDay();
      //print(7);

      //await  providerService.setStartWorkAll();
      // print(8);

      await startOT();
      await startWorkAll();
      setState(() {
        providerService.loadding_home = false;
        providerService.loadding_homestd = 0;
        providerService.home_std = true;
      });
    } else {
      setState(() {
        providerService.loadding_home = true;
        providerService.loadding_homestd = 1;
      });

      await startOT();
      await startWorkAll();
      setState(() {
        providerService.loadding_home = false;
        providerService.loadding_homestd = 0;
      });
    }
  }

  Future checkingWorkRe() async {
    final providerService = Provider.of<ProviderService>(context, listen: false);

    setState(() {
      providerService.loadding_home = true;
      providerService.loadding_homestd = 1;
    });

    await providerService.setUserDetailModel();
    // print(1);
    await providerService.setCheckAttend();
    // print(2);
    await providerService.setSundayAndHoliday();
    // print(3);
    await providerService.setAttendanceHistory();

    providerService.setPendingDay();

    //print(4);
    providerService.setHistoryInDay();
    // print(5);
    providerService.setTeamWork();

    providerService.setStartWorkAll();

    providerService.setMapAll();

    providerService.setList();

    //await  providerService.setStartWorkAll();
    // print(8);

    await startOT();
    //await startWorkAll();

    setState(() {
      providerService.loadding_home = false;
      providerService.loadding_homestd = 0;
    });
  }

  startOT() async {
    final providerService = Provider.of<ProviderService>(context, listen: false);
    await providerService.SetCheckingStartOT();
    checkingStartOt = providerService.checkingStartOt!.data?.length;
    final CheckingOT = providerService.checkingStartOt!.data;
    if (stdrefresh == true) {
      timerOt?.cancel();
    }
    if (checkingStartOt != 0) {
      if (CheckingOT?[0].checkinTime != null && CheckingOT?[0].checkoutTime == null) {
        int? totalSecond = CheckingOT![0].totalSeconds!;
        myDurationOT = Duration(seconds: totalSecond, minutes: 0, hours: 0);
        timerOt = Timer.periodic(const Duration(seconds: 1), (_) => addTimeOT());
        print(CheckingOT[0].totalSeconds);
      } else if (CheckingOT?[0].checkinTime != null && CheckingOT?[0].checkoutTime != null) {
        int? totalSecond = CheckingOT![0].totalSeconds!;
        myDurationOT = Duration(seconds: totalSecond, minutes: 0, hours: 0);
      }
    }
  }

  startWorkAll() {
    final providerService = Provider.of<ProviderService>(context, listen: false);
    final time = Provider.of<TimerProvider>(context, listen: false);
    if (providerService.checkAttend?.data?.inWork == true && providerService.checkAttend?.data?.attendanceId != 0) {
      int totalSeconds = (providerService.checkAttend?.data?.totalSeconds?.toInt() ?? 0);

      // print(totalSeconds);
      // int year = int.parse(providerService.checkAttend?.data?.totalMinutes);
      myDuration = Duration(seconds: totalSeconds, minutes: 0, hours: 0);
      if (timeStart == true) {
        timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
      }
    } else if (providerService.checkAttend?.data?.inWork == false &&
        providerService.checkAttend?.data?.attendanceId != 0) {
      int totalSeconds = (providerService.checkAttend?.data?.totalSeconds?.toInt() ?? 0);
      myDuration = Duration(seconds: totalSeconds, minutes: 0, hours: 0);

      // print(totalSeconds);
      // int year = int.parse(providerService.checkAttend?.data?.totalMinutes);
    }
    //ຖ້າຍັງບໍກົດ
    // else {
    //   setState(() {
    //     providerService.loadding_home = false;
    //     providerService.loadding_homestd = 0;
    //   });
    // }
  }

  addTimeOT() {
    const addSecond = 1;
    if (mounted) {
      setState(() {
        final second = myDurationOT.inSeconds + addSecond;
        myDurationOT = Duration(seconds: second);
      });
    }
  }

  addTime() {
    const addSecond = 1;
    if (mounted) {
      setState(() {
        final second = myDuration.inSeconds + addSecond;
        myDuration = Duration(seconds: second);
      });
    }
  }

  /////
  String formatTwoDigits(int? n) => n.toString().padLeft(2, "0");

  @override
  Widget build(BuildContext context) {
    final providerService = Provider.of<ProviderService>(context, listen: false);
    return Scaffold(
        // backgroundColor: appBgColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          title: Center(
              child: Text(providerService.langs == 'la' ? "ໜ້າຫຼັກ" : "Home",
                  textAlign: TextAlign.center, style: const TextStyle(color: Colors.white))),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[Color(0xff039881), Color(0xff024C41)]),
            ),
          ),
        ),
        body: Builder(
          builder: (BuildContext context) {
            return OfflineBuilder(
              connectivityBuilder: (BuildContext context, ConnectivityResult connectivity, Widget child) {
                final bool connected = connectivity != ConnectivityResult.none;
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    child,
                    connected
                        ? const SizedBox()
                        : Positioned(
                            left: 0.0,
                            right: 0.0,
                            height: 32.0,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              color: connected ? Colors.green.shade400 : const Color(0xFFEE4400),
                              child: connected
                                  ? const Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "ONLINE",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    )
                                  : const Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "OFFLINE",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        SizedBox(
                                          width: 8.0,
                                        ),
                                        SizedBox(
                                          width: 12.0,
                                          height: 12.0,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2.0,
                                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                  ],
                );
              },
              child: Container(
                decoration: const BoxDecoration(),
                child: _checkPlatform(),
              ),
            );
          },
        ));
  }

  Widget _checkPlatform() {
    return Platform.isIOS
        ? UpgradeAlert(
            upgrader: Upgrader(
              dialogStyle: UpgradeDialogStyle.cupertino,
              durationUntilAlertAgain: const Duration(milliseconds: 500),
              showReleaseNotes: false,
              showIgnore: false,
              showLater: false,
              shouldPopScope: () => false,
            ),
            child: getRefreshIndicator())
        : Platform.isAndroid
            ? UpgradeAlert(
                upgrader: Upgrader(
                  dialogStyle: UpgradeDialogStyle.cupertino,
                  durationUntilAlertAgain: const Duration(milliseconds: 500),
                  showReleaseNotes: false,
                  showIgnore: false,
                  showLater: false,
                  shouldPopScope: () => false,
                ),
                child: getRefreshIndicator(),
              )
            : getRefreshIndicator();
  }

  getRefreshIndicator() {
    final providerService = Provider.of<ProviderService>(context, listen: false);
    return RefreshIndicator(
      child: providerService.loadding_home == true && providerService.loadding_homestd == 1
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : getBody(),
      onRefresh: () async {
        setState(() {
          providerService.loadding_home = true;
          providerService.loadding_homestd = 1;
          stdrefresh = true;
        });
        await Future.delayed(const Duration(seconds: 2));
        await providerService.RefreshHomepahe();

        setState(() {
          providerService.loadding_home = false;
          providerService.loadding_homestd = 0;
          stdrefresh = false;
        });
      },
    );
  }

  getBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          getAppBar(),
          const SizedBox(
            height: 15,
          ),
          getItemWork(),
          const SizedBox(
            height: 15,
          ),
          getStartWork(),
          const SizedBox(
            height: 15,
          ),
          const DasBoard(),
          const SizedBox(
            height: 15,
          ),

          getStartOT(),
          const SizedBox(
            height: 15,
          ),

          // checkingStartOt == 0
          //     ? const SizedBox(
          //         height: 15,
          //       )
          //     : const SizedBox(
          //         height: 30,
          //       ),
          // checkingStartOt == 0 ? Container() : getStartOT(),
          // checkingStartOt == 0
          //     ? Container()
          //     : const SizedBox(
          //         height: 30,
          //       ),

          getChartdatas(),

          // getNewCoins(),
        ],
      ),
    );
  }

  getStartOT() {
    final providerService = Provider.of<ProviderService>(context, listen: false);

    //final CheckingOT = providerService.checkingStartOt!.data;
    //print(CheckingOT![0].endTime);
    return Padding(
      padding: const EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 10),
      child: AnimatedContainer(
        duration: const Duration(seconds: 2),
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
        decoration: BoxDecoration(
          color: appBgColor,
          //color: providerService.mode== ThemeMode.light ? appBgColor : appBgColordark ,
          borderRadius: BorderRadius.circular(13),
          //  boxShadow: const[
          //     BoxShadow(offset: Offset(1,1),blurRadius: 20,color: Colors.black)
          //   ],
          gradient: _gradient,
        ),
        child: Container(
          color: Colors.white,
          child: SizedBox(
              width: 400,
              height: 260,
              child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          alignment: Alignment.center,
                          // ignore: prefer_const_constructors
                          child: Text(
                            providerService.langs == 'la' ? " ບັນທຶກ OT " : "Record OT hours",
                            // ignore: prefer_const_constructors
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: primary),
                          )),
                      const SizedBox(
                        height: 5,
                      ),
                      // Container(
                      //     alignment: Alignment.center,
                      //     // ignore: prefer_const_constructors
                      //     child: Text(
                      //       providerService.langs == 'la'
                      //           ? " ແຕ່ ${CheckingOT[0].startTime} ໂມງ  ຫາ  ${CheckingOT[0].endTime} ໂມງ "
                      //           : " Start  ${CheckingOT[0].startTime}  to  ${CheckingOT[0].endTime}  ",
                      //       // ignore: prefer_const_constructors
                      //       style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300, color: black),
                      //     )),
                      const SizedBox(
                        height: 20,
                      ),
                      displayTimerOT(),
                      const SizedBox(
                        height: 10,
                      ),
                      // CheckingOT[0].checkinTime == null && CheckingOT[0].checkoutTime == null
                      //?
                      providerService.checkbuttonot == false
                          ? MyElevatedButtonPrimary(
                              width: double.infinity,
                              onPressed: () async {
                                providerService.setCheckButtonOT(true);
                                final time = Provider.of<TimerProvider>(context, listen: false);
                                if (stdbtnStart == true) {
                                  setState(() => stdbtnStart = false);

                                  setState(() => _btnStartisLoading = true);
                                  if (_btnStartisLoading == true) {
                                    await providerService.setLocation();

                                    if (Geolocator.checkPermission == LocationPermission.denied) {
                                      providerService.setLocation();
                                    } else {
                                      await providerService.SetCheckFieldLocations(
                                          "${providerService.userLocation?.latitude},${providerService.userLocation?.longitude}");
                                      if (providerService.checkFieldLocations?.data.code == 1) {
                                        final res = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => OverTimeOT(
                                                      latitude: '${providerService.userLocation?.latitude}',
                                                      longitude: '${providerService.userLocation?.longitude}',
                                                    )));

                                        if (res) {
                                          if (!mounted)
                                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                              backgroundColor: primary,
                                              content: Text("ເລິ່ມເຮັດໂອທີສຳເລັດ"),
                                              duration: Duration(seconds: 2),
                                            ));

                                          setState(() => _btnStartisLoading = false);
                                          setState(() => stdbtnStart = true);
                                        } else {
                                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                            backgroundColor: red,
                                            content: Text("ເຮັດໂອທີບໍ່ສຳເລັດ"),
                                            duration: Duration(seconds: 2),
                                          ));
                                          // providerService.setFileForUpload(null);

                                          setState(() => _btnStartisLoading = false);
                                          setState(() => stdbtnStart = true);
                                        }
                                      } else {
                                        setState(() => _btnStartisLoading = false);
                                        setState(() => stdbtnStart = true);
                                        _showMyDialog();
                                      }
                                    }
                                  }
                                }
                              },
                              borderRadius: BorderRadius.circular(24),
                              child: const Text(
                                "ເລີ່ມເຮັດ OT",
                                style: TextStyle(
                                  color: white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          : MyElevatedButtonPrimary(
                              width: double.infinity,
                              onPressed: () async {
                                WorkTypeService()
                                    .stopOT(context,
                                        '${providerService.userLocation?.latitude},${providerService.userLocation?.longitude}')
                                    .then((value) {
                                  providerService.setCheckButtonOT(false);
                                });
                              },
                              borderRadius: BorderRadius.circular(24),
                              child: const Text(
                                "ເຊົາເຮັດ OT",
                                style: TextStyle(
                                  color: white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                    ],
                  ))),
        ),
      ),
    );
  }

  getAppBar() {
    final providerService = Provider.of<ProviderService>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 10),
      child: Container(
        height: 100,
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
        decoration: BoxDecoration(
            color: appBgColor,
            //color: providerService.mode== ThemeMode.light ? appBgColor : appBgColordark ,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 0.1),
              ),
              BoxShadow(
                color: Colors.grey.shade200,
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, -0.1),
              ),
              BoxShadow(
                color: Colors.grey.shade200,
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(-0.1, 0),
              ),
              BoxShadow(
                color: Colors.grey.shade200,
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0.1, 0),
              ),
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // AvatarImage(MyData.profileImg, isSVG: false, width: 57, height: 57),
            CustomImage(
              MyData.profileImg,
              width: 60,
              height: 57,
              radius: 25,
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
                child: FadeInRight(
              animate: true,
              child: Container(
                alignment: Alignment.centerLeft,
                // color: Colors.red,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      providerService.langs == 'la' ? MyData.fullnameLa : MyData.fullname,
                      style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: primary),
                    ),
                    Text(
                      MyData.level,
                      style: TextStyle(fontSize: 10.sp),
                    ),
                    Text(
                      MyData.department_name,
                      style: TextStyle(fontSize: 9.sp),
                    ),
                  ],
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }

  getItemWork() {
    return Padding(
      padding: const EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 10),
      child: Container(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        decoration: BoxDecoration(
            color: appBgColor,
            //color: providerService.mode== ThemeMode.light ? appBgColor : appBgColordark ,
            borderRadius: BorderRadius.circular(13),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 0.1),
              ),
              BoxShadow(
                color: Colors.grey.shade200,
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, -0.1),
              ),
              BoxShadow(
                color: Colors.grey.shade200,
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(-0.1, 0),
              ),
              BoxShadow(
                color: Colors.grey.shade200,
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0.1, 0),
              ),
            ]),
        child: displayItem(),
      ),
    );
  }

  Widget displayItem() {
    final providerService = Provider.of<ProviderService>(context, listen: false);
    return Consumer<ProviderService>(
      builder: ((context, value, child) {
        if (value.isloading == true) {
          return const LoadingWidget();
        } else if (value.totalCount == null) {
          return const SizedBox();
        }
        return SizedBox(
          child: Center(
            child: GridView.count(
              padding: const EdgeInsets.symmetric(vertical: 10),
              primary: false,
              shrinkWrap: true,
              crossAxisCount: 4,
              crossAxisSpacing: 1,
              children: [
                FadeIn(
                  animate: true,
                  child: ItemWorkHome(
                      icon: Image.asset(
                        'assets/icons/time.png',
                        height: 35,
                        width: 35,
                      ),
                      title: providerService.langs == 'la' ? "ວຽກ" : "Work",
                      cout: MyData.pendingday > 99 ? "99+" : "${MyData.pendingday}",
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CalendarScreen(),
                          ),
                        );
                      }),
                ),
                FadeInUp(
                  animate: true,
                  child: ItemWorkHome(
                      icon: Image.asset(
                        'assets/icons/OT.png',
                        height: 35,
                        width: 35,
                      ),
                      title: providerService.langs == 'la' ? "ໂອທີ" : "OT",
                      cout: '0',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const OTPage(),
                          ),
                        );
                        // _showMyDialog();
                      }),
                ),
                FadeInDown(
                  animate: true,
                  child: ItemWorkHome(
                      icon: Image.asset(
                        'assets/icons/Leave.png',
                        height: 35,
                        width: 35,
                      ),
                      title: providerService.langs == 'la' ? "ລາພັກ" : "Leave",
                      cout: '0',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LeavePage(),
                          ),
                        );
                      }),
                ),
                FadeInLeft(
                  animate: true,
                  child: ItemWorkHome(
                      icon: Image.asset(
                        'assets/icons/Team.png',
                        height: 35,
                        width: 35,
                      ),
                      title: providerService.langs == 'la' ? "ທີມ" : "Team",
                      cout: '0',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TeamWork(),
                          ),
                        );
                      }),
                ),
                FadeInRight(
                  animate: true,
                  child: ItemWorkHome(
                      icon: Image.asset(
                        'assets/icons/Maps.png',
                        height: 35,
                        width: 35,
                      ),
                      title: providerService.langs == 'la' ? "ແຜນທີ່" : "Map",
                      cout: '0',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Mapcompany(),
                          ),
                        );
                      }),
                ),
                value.totalCount!.code != 1
                    ? const SizedBox()
                    : FadeInLeft(
                        animate: true,
                        child: ItemWorkHome(
                            icon: Image.asset(
                              'assets/icons/leave-PM.png',
                              height: 35,
                              width: 35,
                            ),
                            title: providerService.langs == 'la' ? "ອະນຸມັດລາພັກ" : "Approve OT",
                            cout: MyData.countOvertime > 99 ? "99+" : "${MyData.countOvertime}",
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const TMMain(),
                                ),
                              );
                            }),
                      ),
                value.totalCount!.code != 1
                    ? const SizedBox()
                    : FadeInLeft(
                        animate: true,
                        child: ItemWorkHome(
                          icon: Image.asset(
                            'assets/icons/OT-PM.png',
                            height: 35,
                            width: 35,
                          ),
                          title: providerService.langs == 'la' ? "ອະນຸມັດ OT" : "Approve OT",
                          cout: MyData.Overtimexecount > 99 ? "99+" : "${MyData.Overtimexecount}",
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PMMain(),
                              ),
                            );
                          },
                        ),
                      ),
                value.totalCount!.code != 1
                    ? const SizedBox()
                    : FadeInLeft(
                        animate: true,
                        child: ItemWorkHome(
                          icon: Image.asset(
                            'assets/icons/OT-HR.png',
                            height: 35,
                            width: 35,
                          ),
                          title: providerService.langs == 'la' ? "ອະນຸມັດ OT" : "Approve OT",
                          cout: MyData.Overtimexecount > 99 ? "99+" : "${MyData.Overtimexecount}",
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MainHR(),
                              ),
                            );
                          },
                        ),
                      ),
                value.totalCount!.code != 1
                    ? const SizedBox()
                    : FadeInLeft(
                        animate: true,
                        child: ItemWorkHome(
                          icon: Image.asset(
                            'assets/icons/leave-HR.png',
                            height: 35,
                            width: 35,
                          ),
                          title: providerService.langs == 'la' ? "ອະນຸມັດລາພັກ" : "Approve OT",
                          cout: MyData.Overtimexecount > 99 ? "99+" : "${MyData.Overtimexecount}",
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HRMainOT(),
                              ),
                            );
                          },
                        ),
                      ),
                value.totalCount!.code != 1
                    ? const SizedBox()
                    : FadeInLeft(
                        animate: true,
                        child: ItemWorkHome(
                          icon: Image.asset(
                            'assets/icons/leave-DR.png',
                            height: 35,
                            width: 35,
                          ),
                          title: providerService.langs == 'la' ? "ອະນຸມັດ OT" : "Approve OT",
                          cout: MyData.Overtimexecount > 99 ? "99+" : "${MyData.Overtimexecount}",
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DRMainOT(),
                              ),
                            );
                          },
                        ),
                      ),
                value.totalCount!.code != 1
                    ? const SizedBox()
                    : FadeInLeft(
                        animate: true,
                        child: ItemWorkHome(
                          icon: Image.asset(
                            'assets/icons/Time-DR.png',
                            height: 35,
                            width: 35,
                          ),
                          title: providerService.langs == 'la' ? "ອະນຸມັດໜ້າວຽກ" : "Approve OT",
                          cout: MyData.Overtimexecount > 99 ? "99+" : "${MyData.Overtimexecount}",
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DRMainApproved(),
                              ),
                            );
                          },
                        ),
                      ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget displayTimerOT() {
    final providerService = Provider.of<ProviderService>(context, listen: false);

    return Consumer<TimerProvider>(builder: (context, provitime, child) {
      return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        DisplayTimerUI(
            time: formatTwoDigits(provitime.durationOT.inHours),
            header: providerService.langs == 'la' ? "ຊົ່ວໂມງ" : "Hour"),
        const SizedBox(
          width: 8,
        ),
        DisplayTimerUI(
            time: formatTwoDigits(provitime.durationOT.inMinutes.remainder(60)),
            header: providerService.langs == 'la' ? "ນາທີ" : "Minute"),
        const SizedBox(
          width: 8,
        ),
        DisplayTimerUI(
            time: formatTwoDigits(provitime.durationOT.inSeconds.remainder(60)),
            header: providerService.langs == 'la' ? "ວິນາທີ" : "Second"),
      ]);
    });
  }

  Widget displayTimer() {
    final providerService = Provider.of<ProviderService>(context, listen: false);
    //final provitime = Provider.of<TimerProvider>(context, listen: false);

    return Consumer<TimerProvider>(builder: (context, provitime, ch) {
      return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        FadeInLeft(
          animate: true,
          child: DisplayTimerUI(
              time: formatTwoDigits(provitime.duration.inHours),
              header: providerService.langs == 'la' ? "ຊົ່ວໂມງ" : "Hour"),
        ),
        const SizedBox(
          width: 8,
        ),
        DisplayTimerUI(
            time: formatTwoDigits(provitime.duration.inMinutes.remainder(60)),
            header: providerService.langs == 'la' ? "ນາທີ" : "Minute"),
        const SizedBox(
          width: 8,
        ),
        FadeInRight(
          animate: true,
          child: DisplayTimerUI(
              time: formatTwoDigits(provitime.duration.inSeconds.remainder(60)),
              header: providerService.langs == 'la' ? "ວິນາທີ" : "Second"),
        ),
      ]);
    });
  }

  getStartWork() {
    final providerService = Provider.of<ProviderService>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 10),
      child: Container(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 0),
        decoration: BoxDecoration(color: appBgColor, borderRadius: BorderRadius.circular(13), boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 0.1),
          ),
          BoxShadow(
            color: Colors.grey.shade200,
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, -0.1),
          ),
          BoxShadow(
            color: Colors.grey.shade200,
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(-0.1, 0),
          ),
          BoxShadow(
            color: Colors.grey.shade200,
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0.1, 0),
          ),
        ]),
        child: SizedBox(
            child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FadeInLeft(
                      animate: true,
                      child: Container(
                          alignment: Alignment.center,
                          // ignore: prefer_const_constructors
                          child: Text(
                            providerService.langs == 'la'
                                ? "ບັນທຶກຊົ່ວໂມງເຮັດວຽກປະຈໍາວັນ"
                                : "Record daily working hours",
                            // ignore: prefer_const_constructors
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: primary),
                          )),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    displayTimer(),
                    const SizedBox(
                      height: 10,
                    ),
                    providerService.checkSundayAndHoliday?.data?.inDayStartwork == true
                        ? providerService.checkAttend?.data?.inWork == true &&
                                providerService.checkAttend?.data?.attendanceId != 0
                            ? MyElevatedButtonSecondary(
                                width: double.infinity,
                                onPressed: () async {
                                  setState(() => stdbtnEnd = false);

                                  setState(() => _btnEndisLoading = true);

                                  if (_btnEndisLoading == true) {
                                    await providerService.setLocation();

                                    if (Geolocator.checkPermission == LocationPermission.denied) {
                                      providerService.setLocation();
                                    } else {
                                      await providerService.SetCheckFieldLocations(
                                          "${providerService.userLocation?.latitude},${providerService.userLocation?.longitude}");
                                      if (providerService.checkFieldLocations?.data.code == 1) {
                                        DateTime now = DateTime.now();

                                        await providerService.SetStdTimesheet(1);
                                        await providerService.SetTimeSheetItem(DateTime(now.year, now.month, now.day));
                                        final res = await providerService.checkOutNew(
                                            "${providerService.userLocation?.latitude},${providerService.userLocation?.longitude}",
                                            context);
                                        if (res == true) {
                                          showDialog(
                                            context: context,
                                            builder: (context) => LoadingDialog(
                                              title: "ເລີກວຽກສຳເລັດ",
                                              onTap: () async {
                                                Navigator.pop(context);
                                                await _fuctionNewTap(context);
                                              },
                                            ),
                                          );
                                        }
                                      } else {
                                        setState(() => _btnEndisLoading = false);
                                        setState(() => stdbtnEnd = true);
                                        _showMyDialog();
                                      }
                                    }
                                  }
                                },
                                borderRadius: BorderRadius.circular(24),
                                child: _btnEndisLoading == true && stdbtnEnd == false
                                    ? Container(
                                        width: 24,
                                        height: 24,
                                        padding: const EdgeInsets.all(2.0),
                                        child: const CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 3,
                                        ),
                                      )
                                    : Text(
                                        providerService.langs == 'la' ? "ເລີກວຽກ" : 'Stop Work',
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                                      ))
                            : providerService.checkAttend?.data?.inWork == false &&
                                    providerService.checkAttend?.data?.attendanceId != 0
                                ? MyElevatedButton_Gray(
                                    width: double.infinity,
                                    onPressed: () async {},
                                    borderRadius: BorderRadius.circular(24),
                                    child: Text(
                                      providerService.langs == 'la' ? 'ເຮັດວຽກແລ້ວ' : ' Worked ',
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                                    ))
                                : MyElevatedButtonPrimary(
                                    width: double.infinity,
                                    onPressed: () async {
                                      final time = Provider.of<TimerProvider>(context, listen: false);
                                      if (stdbtnStart == true) {
                                        setState(() => stdbtnStart = false);

                                        setState(() => _btnStartisLoading = true);
                                        if (_btnStartisLoading == true) {
                                          await providerService.setLocation();

                                          if (Geolocator.checkPermission == LocationPermission.denied) {
                                            providerService.setLocation();
                                          } else {
                                            await providerService.SetCheckFieldLocations(
                                                "${providerService.userLocation?.latitude},${providerService.userLocation?.longitude}");
                                            if (providerService.checkFieldLocations?.data.code == 1) {
                                              String? path = '';

                                              final res = await providerService.checkInNew(
                                                  "${providerService.userLocation?.latitude},${providerService.userLocation?.longitude}",
                                                  path,
                                                  context);

                                              if (res == true) {
                                                print(res);
                                                time.startTimer(context);
                                                if (!mounted) return;

                                                await providerService.RefreshHomepahe1();

                                                await startWorkAll();

                                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                  backgroundColor: primary,
                                                  content: Text("ເລິ່ມວຽກສຳເລັດ"),
                                                  duration: Duration(seconds: 2),
                                                ));
                                                setState(() => _btnStartisLoading = false);
                                                setState(() => stdbtnStart = true);
                                              } else {
                                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                  backgroundColor: red,
                                                  content: Text("ເລິ່ມວຽກບໍ່ສຳເລັດ"),
                                                  duration: Duration(seconds: 2),
                                                ));
                                                providerService.setFileForUpload(null);

                                                setState(() => _btnStartisLoading = false);
                                                setState(() => stdbtnStart = true);
                                              }
                                            } else {
                                              setState(() => _btnStartisLoading = false);
                                              setState(() => stdbtnStart = true);
                                              _showMyDialog();
                                            }
                                          }
                                        }
                                      }
                                    },
                                    borderRadius: BorderRadius.circular(24),
                                    child: _btnStartisLoading == true && stdbtnStart == false
                                        ? Container(
                                            padding: const EdgeInsets.all(2.0),
                                            child: const CircularProgressIndicator(
                                              color: Colors.white,
                                              strokeWidth: 3,
                                            ),
                                          )
                                        : Text(
                                            providerService.langs == 'la' ? "ເລີ່ມວຽກ" : 'Start Work',
                                            style: const TextStyle(
                                                color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                                          ))
                        : MyElevatedButton_Gray(
                            width: double.infinity,
                            onPressed: () async {},
                            borderRadius: BorderRadius.circular(24),
                            child: Text(
                              providerService.langs == 'la' ? "ພັກວຽກ" : 'Leave',
                              style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                            )),
                  ],
                ))),
      ),
    );
  }

  getChartdatas() {
    final providerService = Provider.of<ProviderService>(context, listen: false);
    final attendance = providerService.attendancehistory;
    final List<ChartData> chartData = [];
    for (var i = 0; i < attendance.length; i++) {
      var dateInFormatText = attendance[i].date?.toString().split("-");

      int year = int.parse(dateInFormatText![0]);
      int mm = int.parse(dateInFormatText[1]);
      int day = int.parse(dateInFormatText[2]);

      double totaltime = double.parse('${attendance[i].sumTotalMinutes}') / 60;

      chartData.add(ChartData(DateTime(year, mm, day), totaltime));
    }

    return Container(
        margin: const EdgeInsets.only(left: 10, right: 10),
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
        decoration: BoxDecoration(color: appBgColor, borderRadius: BorderRadius.circular(20), boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 0.1),
          ),
          BoxShadow(
            color: Colors.grey.shade200,
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, -0.1),
          ),
          BoxShadow(
            color: Colors.grey.shade200,
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(-0.1, 0),
          ),
          BoxShadow(
            color: Colors.grey.shade200,
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0.1, 0),
          ),
        ]),
        child: Column(
          children: [
            FadeInRight(
              animate: true,
              child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    providerService.langs == 'la' ? "ປະຫວັດການມາວຽກ" : "Attendance History",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: primary),
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            FadeInLeft(
              child: SfCartesianChart(
                primaryXAxis: DateTimeAxis(
                    dateFormat: DateFormat.Md(),
                    interval: 1,
                    borderColor: primary,
                    edgeLabelPlacement: EdgeLabelPlacement.shift,
                    labelStyle: const TextStyle(
                        // color: primary,
                        fontFamily: 'Roboto',
                        fontSize: 11,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500)),
                plotAreaBorderColor: Colors.transparent,
                borderColor: Colors.transparent,
                primaryYAxis: NumericAxis(
                  labelRotation: 90,
                  labelFormat: '{value} h',
                  interval: 2,
                  maximum: 12,
                  borderColor: primary,
                  labelStyle: const TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 11,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                series: <LineSeries<ChartData, DateTime>>[
                  LineSeries<ChartData, DateTime>(
                    color: primary,
                    dataSource: chartData,
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y,
                    markerSettings: const MarkerSettings(isVisible: true),
                    enableTooltip: true,
                  )
                ],
              ),
            ),
          ],
        ));
  }

  Future<void> _showMyDialog() async {
    final providerService = Provider.of<ProviderService>(context, listen: false);

    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('ຂໍ້ຄວາມ'),
        content: Text(providerService.checkFieldLocations!.data.status),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _showSuccus() async {
    final providerService = Provider.of<ProviderService>(context, listen: false);

    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Center(
            child: Text('ຢືນຢັນການເພີ່ມ',
                style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold))),
        content: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Text("ທ່ານຕ້ອງການເຊົາເຮັດ OT ບໍ?",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: primary, fontSize: 12, fontWeight: FontWeight.w300)),
            )
          ],
        ),
        actions: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SizedBox(
                  child: MyElevatedButtonSecondary(
                      height: 30,
                      onPressed: () {
                        setState(() => _btnStartOTisLoading = false);
                        setState(() => stdbtnStartOT = true);
                        Navigator.of(context).pop();
                      },
                      borderRadius: BorderRadius.circular(24),
                      child: const Text(
                        'ຍົກເລີກ',
                        style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                      )),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: MyElevatedButtonPrimary(
                    height: 30,
                    onPressed: () async {
                      if (stdbtnStartOT == true) {
                        setState(() => stdbtnStartOT = false);
                        setState(() => _btnStartOTisLoading = true);
                      }

                      // final startOT = await providerService.CreateCheckInAndOutOTNew(
                      //     "${providerService.userLocation?.latitude},${providerService.userLocation?.longitude}",
                      //     providerService.checkingStartOt!.data![0].eOvertimeId.toString());

                      // if (startOT == true) {
                      //   Navigator.pop(
                      //     context,
                      //   );
                      //   setState(() => stdrefresh = true);

                      //   setState(() => stdrefresh = false);
                      //   print("EndOT");
                      //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      //     backgroundColor: primary,
                      //     content: Text("ເຊົາເຮັດໂອທີ່ ສຳເລັດ"),
                      //     duration: Duration(seconds: 2),
                      //   ));
                      //   setState(() => _btnStartOTisLoading = false);
                      //   setState(() => stdbtnStartOT = true);
                      // } else {
                      //   Navigator.pop(
                      //     context,
                      //   );
                      //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      //     backgroundColor: red,
                      //     content: Text("ເຊົາເຮັດໂອທີ່ ບໍ່ສຳເລັດ"),
                      //     duration: Duration(seconds: 2),
                      //   ));

                      //   setState(() => _btnStartOTisLoading = false);
                      //   setState(() => stdbtnStartOT = true);
                      // }
                    },
                    borderRadius: BorderRadius.circular(24),
                    child: const Text(
                      'ຕົກລົງ',
                      style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                    )),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);

  final DateTime x;
  final double y;
}
