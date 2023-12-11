// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:fms_mobile_app/pages/home/provider/timer_provider.dart';
import 'package:fms_mobile_app/pages/timesheets/timesheet_new.dart';
import 'package:fms_mobile_app/services/provider_service.dart';
import 'package:fms_mobile_app/theme/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fms_mobile_app/widgets/MyElevatedButton_Primary.dart';
import 'package:fms_mobile_app/widgets/MyElevatedButton_Secondary.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TimeSheetList extends StatefulWidget {
  const TimeSheetList({
    Key? key,
  }) : super(key: key);

  @override
  _TimeSheetListState createState() => _TimeSheetListState();
}

class _TimeSheetListState extends State<TimeSheetList> {
  bool? _loding;
  String stdLoad = "";
  void setData() async {
    setState(() {
      _loding = true;
    });

    final providerService =
        Provider.of<ProviderService>(context, listen: false);

    await providerService.setTimesheetListDetial();

    //  print("HomeStart123");
    print(providerService.StdEndworkThisDay);

    if (providerService.StdEndworkThisDay == 1) {
      if (providerService.StdEndworkThisDay == 1 &&
          providerService.timesheetDateDetial?.data?.length == 0) {
        _FuctionNewTap(context);
      }
    }

    setState(() {
      _loding = false;
    });
  }

  _FuctionNewTap(BuildContext context) async {
    final providerService = Provider.of<ProviderService>(context, listen: false);
    String? refresh = await Navigator.push(context, MaterialPageRoute(builder: (context) => const TimeSheetNew()));

    if (refresh == "true") {
      // setDataCalendarWorkRe();
      providerService.setStartWorkAll();
      setData();
      stdLoad = "true";
    }
  }

  @override
  void initState() {
    setData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final providerService = Provider.of<ProviderService>(context, listen: false);
    final timesheetListDetial = providerService.timesheetListDetial?.ioList;

    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        // systemOverlayStyle: SystemUiOverlayStyle.dark,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: black,
          ),
          onPressed: () {
            Navigator.pop(context, stdLoad
                // MYHomePage is another page for showcase
                // replace it with your page name
                );
          },
        ),
        title: Text(
          providerService.langs == 'la' ? "ລາຍການ Timesheet" : "Timesheet",
          style: TextStyle(
            fontSize: 16.sp,
            // fontWeight: FontWeight.bold,
            color: black,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              color: appBgColor,

              // borderRadius: BorderRadius.circular(13),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: const Offset(0, 2),
                ),
                BoxShadow(
                  color: Colors.grey.shade200,
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: const Offset(0, -2),
                ),
                BoxShadow(
                  color: Colors.grey.shade200,
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: const Offset(-2, 0),
                ),
                BoxShadow(
                  color: Colors.grey.shade200,
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: const Offset(2, 0),
                ),
              ]),
        ),
        actions: <Widget>[
          providerService.timesheetListDetial?.timesheetApproved != "1"
              ? providerService.timesheetDateDetial?.data?.length != 0
                  ? TextButton(
                      // style: style,
                      onPressed: () {
                        _FuctionNewTap(context);
                      },
                      child: const Icon(Icons.add),
                    )
                  : Container()
              : Container()
        ],
      ),
      floatingActionButton:
          providerService.StdEndworkThisDay == 1 && providerService.timesheetDateDetial?.data?.length != 0
              ? Padding(
                  padding: const EdgeInsets.all(10),
                  child: MyElevatedButtonPrimary(
                      width: MediaQuery.of(context).size.width,
                      onPressed: () async {
                        final provitime = Provider.of<TimerProvider>(context, listen: false);
                        final res = await providerService.checkOutNew(
                            "${providerService.userLocation?.latitude},${providerService.userLocation?.longitude}",
                            context);

                        if (res == true) {
                          provitime.stopTimer(context);

                          Navigator.pop(context, "CheckOut");
                        }
                      },
                      borderRadius: BorderRadius.circular(24),
                      child: const Text(
                        'ຢືນຢັນການເລິກວຽກ',
                        style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                      )),
                )
              : Container(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: _loding == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  ListTimesheetDetail(),
                  ListTimesheet(),
                ],
              ),
            ),
    );
  }

  Widget ListTimesheet() {
    final providerService = Provider.of<ProviderService>(context, listen: false);
    print(providerService.timesheetDateDetial?.data?.length);
    providerService.timesheetDateDetial?.data?.length;

    String Status = "";

    String? timesheetApproved = providerService.timesheetListDetial?.timesheetApproved;

    Status =
        "${timesheetApproved == "-1" ? providerService.langs == 'la' ? "ທາມຊີດລໍຖ້າອະນຸມັດ" : "Pending" : timesheetApproved == "1" ? providerService.langs == 'la' ? "ທາມຊີດຖືກອະນຸມັດແລ້ວ" : " Approved" : timesheetApproved == "0" ? providerService.langs == 'la' ? "ທາມຊີດບໍຖືກອະນຸມັດແລ້ວ" : "  Disapproved" : ""}";

    return providerService.timesheetDateDetial?.data?.length == 0
        ? SizedBox(
            height: MediaQuery.of(context).size.height - 350,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.search_outlined,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      providerService.langs == 'la' ? "ບໍ່ມີລາຍການ" : "No data",
                      style: const TextStyle(color: Colors.grey, fontSize: 17, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: MyElevatedButtonPrimary(
                            onPressed: () {
                              //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => TimeSheetNew()));
                              // Navigator.pushReplacement(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (BuildContext context) =>
                              //             TimeSheetNew()));

                              _FuctionNewTap(context);
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             const TimeSheetNew()));
                            },
                            borderRadius: BorderRadius.circular(24),
                            child: Text(
                              providerService.langs == 'la' ? 'ເພີ່ມ Timesheet' : "New Timesheet",
                              style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                            )),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        : SizedBox(
            height: MediaQuery.of(context).size.height - 250,
            child: Consumer<ProviderService>(
              builder: (context, model, child) {
                return ListView.builder(
                  itemCount: model.timesheetDateDetial?.data?.length,
                  itemBuilder: (context, index) {
                    final item = model.timesheetDateDetial?.data?[index];
                    return Container(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      margin: const EdgeInsets.all(10),
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
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(
                          item?.workType == "B"
                              ? providerService.langs == 'la'
                                  ? 'ວຽກໂຄງການ'
                                  : "Billable Hour"
                              : item?.workType == "NB"
                                  ? providerService.langs == 'la'
                                      ? "ວຽກບໍລິຫານອົງກອນ"
                                      : "Non-Billable Hour"
                                  : item?.workType == "Absence"
                                      ? providerService.langs == 'la'
                                          ? "ຂາດ"
                                          : "Absence"
                                      : "",
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  providerService.langs == 'la' ? 'ລະຫັດໜ້າວຽກ:' : "Project",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 14.sp, color: black),
                                ),
                                Text(
                                  providerService.langs == 'la' ? 'ໄລຍະເວລາປະຕິບັດວຽກ:' : "Hours",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 10.sp, color: black),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  providerService.langs == 'la' ? 'ສະຖານະ: ' : "Status",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 10.sp, color: black),
                                ),
                              ],
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    overflow: TextOverflow.ellipsis,
                                    '${item?.workcode}',
                                    style: TextStyle(fontSize: 10.sp, color: black),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    providerService.langs == 'la'
                                        ? '${item?.workHour}  ຊົ້ວໂມງ'
                                        : '${item?.workHour}  h',
                                    style: TextStyle(fontSize: 10.sp, color: black),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    '${Status}',
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        color: timesheetApproved == "-1"
                                            ? Color.fromRGBO(255, 153, 0, 1)
                                            : timesheetApproved == "1"
                                                ? Color.fromRGBO(76, 175, 79, 1)
                                                : Color.fromRGBO(244, 67, 54, 1)),
                                  ),
                                ],
                              ),
                            ),
                            providerService.timesheetListDetial?.timesheetApproved != "1"
                                ? providerService.timesheetDateDetial?.data?.length != 0
                                    ? Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          IconButton(
                                            onPressed: () async {
                                              print(item?.eTimesheetId);

                                              int? itemTimesheet = item?.eTimesheetId;
                                              await providerService.SetTimeSheetItemDelete(itemTimesheet);

                                              _showSuccus();
                                            },
                                            icon: const Icon(Icons.delete),
                                            color: Colors.red,
                                          ),
                                        ],
                                      )
                                    : SizedBox()
                                : SizedBox()
                          ],
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                      ]),
                    );
                  },
                );
              },
            ));
  }

  Widget ListTimesheetDetail() {
    final providerService = Provider.of<ProviderService>(context, listen: false);

    String formatcheckinTimes = "-";
    String formatcheckoutTimes = "";
    String SumInout = "";

    int Sumhour = 0;
    int Summinute = 0;

    String ShowHM = "";

    int Nday = providerService.timeSheetList!.day;
    int Nmonth = providerService.timeSheetList!.month;
    int Nyear = providerService.timeSheetList!.year;

    String Status = "";

    String? timesheetApproved = providerService.timesheetListDetial?.timesheetApproved;
    Status =
        "${timesheetApproved == "-1" ? providerService.langs == 'la' ? "ທາມຊີດລໍຖ້າອະນຸມັດ" : "Pending" : timesheetApproved == "1" ? providerService.langs == 'la' ? "ທາມຊີດຖືກອະນຸມັດແລ້ວ" : "Approved" : timesheetApproved == "0" ? providerService.langs == 'la' ? "ທາມຊີດບໍຖືກອະນຸມັດແລ້ວ" : "Disapproved" : ""}";

    if (providerService.timesheetListDetial?.ioList?.toList().length == 1) {
      print(providerService.timesheetListDetial?.ioList?.toList()[0].sumTotalMinutes);

      final Sumtotal =
          new DateTime(0, 0, 0, 0, providerService.timesheetListDetial?.ioList?.toList()[0].sumTotalMinutes ?? 0);

      Sumhour = int.parse(Sumtotal.hour.toString());
      Summinute = int.parse(Sumtotal.minute.toString());
      ShowHM = providerService.langs == 'la'
          ? "${Sumhour >= 10 ? Sumhour : "0${Sumhour}"}:${Summinute >= 10 ? Summinute : "0${Summinute}"} ຊົ່ວໂມງ "
          : "${Sumhour >= 10 ? Sumhour : "0${Sumhour}"}:${Summinute >= 10 ? Summinute : "0${Summinute}"}  ";

      final checkinTime = providerService.timesheetListDetial?.ioList?.toList()[0].checkinTime.toString() ?? 0;

      final checkinTimes = DateTime.parse('${checkinTime}');

      formatcheckinTimes = DateFormat.Hm().format(checkinTimes);

      if (providerService.timesheetListDetial?.ioList?.toList()[0].checkoutTime.toString() != '0') {
        final checkoutTime = providerService.timesheetListDetial?.ioList?.toList()[0].checkoutTime.toString() ?? 0;
        final checkoutTimes = DateTime.parse('${checkoutTime}');
        formatcheckoutTimes = DateFormat.Hm().format(checkoutTimes);
      }

      SumInout = "${formatcheckinTimes} - ${formatcheckoutTimes}";
    }

    // TimeOfDay _startTime = TimeOfDay(hour:int.parse(start![0].toString()),minute: int.parse(start[1].toString()));
    // print(_startTime);
    return SizedBox(
      height: 120,
      child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return Container(
              // padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              margin: const EdgeInsets.only(right: 30, left: 30, top: 20, bottom: 20),
              child: SizedBox(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            providerService.langs == 'la' ? 'ວັນເດືອນປີ :' : "Date",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp, color: black),
                          ),
                          Text(
                            '${Nday >= 10 ? Nday : "0${Nday}"}/${Nmonth >= 10 ? Nmonth : "0${Nmonth}"}/${Nyear}',
                            style: TextStyle(fontSize: 12.sp, color: black),
                          ),
                          Text(
                            providerService.langs == 'la' ? 'ລວມເວລາ:' : 'Total :',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp, color: black),
                          ),
                          Text(
                            '${ShowHM}',
                            style: TextStyle(fontSize: 12.sp, color: black),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            providerService.langs == 'la' ? 'ເວລາ:' : 'Time :',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp, color: black),
                          ),
                          Text(
                            '${SumInout}',
                            style: TextStyle(fontSize: 12.sp, color: black),
                          ),
                          Text(
                            providerService.langs == 'la' ? 'ສະຖານະ: ' : 'Stutas :',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp, color: black),
                          ),
                          Text(
                            '${Status}',
                            style: TextStyle(
                                fontSize: 12.sp,
                                color: timesheetApproved == "-1"
                                    ? Color.fromRGBO(255, 153, 0, 1)
                                    : timesheetApproved == "1"
                                        ? Color.fromRGBO(76, 175, 79, 1)
                                        : Color.fromRGBO(244, 67, 54, 1)),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                ]),
              ),
            );
          }),
    );
  }

  Future<void> _showSuccus() async {
    final providerService = Provider.of<ProviderService>(context, listen: false);

    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Center(
            child:
                Text('ຢືນຢັນການລົບ', style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold))),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Text("ທ່ານຕ້ອງການລົບ Timesheet ນິ້ບໍ?",
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
                        Navigator.of(context).pop();
                      },
                      borderRadius: BorderRadius.circular(24),
                      child: const Text(
                        'ຍົກເລີກ',
                        style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                      )),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: MyElevatedButtonPrimary(
                    height: 30,
                    onPressed: () async {
                      _showDialogLoding();
                      final providerService = Provider.of<ProviderService>(context, listen: false);
                      await providerService.DelectTimesheetBtId();
                      providerService.setStartWorkAll();
                      setState(() {
                        stdLoad = "true";
                      });

                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      _showDialogLodingAction();
                      //  Navigator.of(context).pop();

                      setData();
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

  Future<void> _showDialogLoding() async {
    final providerService = Provider.of<ProviderService>(context, listen: false);

    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => true,
              child: SimpleDialog(backgroundColor: Colors.white, children: <Widget>[
                Center(
                  child: Column(children: [
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      providerService.langs == 'la' ? "ກຳລັງໂຫລດ......" : "Loding......",
                      style: TextStyle(color: primary),
                    )
                  ]),
                )
              ]));
        });
  }

  Future<void> _showDialogLodingAction() async {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 0.0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'ສຳເລັດ',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 25.0),
              Icon(
                Icons.check_circle_outline,
                color: Colors.green,
                size: 70.0,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
