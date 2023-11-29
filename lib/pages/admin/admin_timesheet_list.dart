// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names, unnecessary_string_interpolations, prefer_is_empty, use_build_context_synchronously, unused_local_variable

import 'package:flutter/material.dart';
import 'package:fms_mobile_app/pages/timesheets/timesheet_new.dart';
import 'package:fms_mobile_app/services/provider_service.dart';
import 'package:fms_mobile_app/shared/mydata.dart';
import 'package:fms_mobile_app/theme/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fms_mobile_app/widgets/MyElevatedButton_Primary.dart';
import 'package:fms_mobile_app/widgets/MyElevatedButton_Secondary.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AdminTimeSheetList extends StatefulWidget {
  const AdminTimeSheetList({Key? key}) : super(key: key);

  @override
  _AdminTimeSheetListState createState() => _AdminTimeSheetListState();
}

class _AdminTimeSheetListState extends State<AdminTimeSheetList> {
  bool? _loding;
  String stdLoad = "";
   String stdblack = "1";
    final TextEditingController _remark = TextEditingController();
  void setData() async {
    setState(() {
      _loding = true;
    });

    final providerService =
        Provider.of<ProviderService>(context, listen: false);

    await providerService.setAdminTimesheetListDetial();

    //  print("HomeStart123");
   

    setState(() {
      _loding = false;
    });

    //  await providerService.setWorkcodeAll();
    //  await providerService.setProject("");
  }

  _FuctionNewTap(BuildContext context) async {
    String refresh = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => const TimeSheetNew()));

    if (refresh == "true") {
      // setDataCalendarWorkRe();
      setData();
      stdLoad = "true";
    }
  }

  @override
  void initState() {
    setData();
    // WidgetsBinding.instance.addPostFrameCallback((_) {

    // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final providerService =
        Provider.of<ProviderService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        // systemOverlayStyle: SystemUiOverlayStyle.dark,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: black,
          ),
          onPressed: () {
            Navigator.pop(context, stdblack
                // MYHomePage is another page for showcase
                // replace it with your page name
                );
          },
        ),
        title: Text(
           providerService.langs == 'la' ? "ລາຍການ Timesheet" : "List Timesheet",
          style: TextStyle(
              fontSize: 16.sp,
              // fontWeight: FontWeight.bold,
              color: black),
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

      ),
  
  floatingActionButton:    MyData.levelID == 3
                      ?   Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyElevatedButtonSecondary(
                width: MediaQuery.of(context).size.width / 2 - 30,
                onPressed: () async {
                 _showUnSuccus();

                },
                borderRadius: BorderRadius.circular(24),
                child:  Text(
                  providerService.langs == 'la' ?  'ບໍ່ອະນຸມັດ' : "Disapproved",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                )),
            const SizedBox(
              width: 20,
            ),
            MyElevatedButtonPrimary(
                width: MediaQuery.of(context).size.width / 2 - 30,
                onPressed: () async {
                 _showSuccus();
                },
                borderRadius: BorderRadius.circular(24),
                child:  Text(
                  providerService.langs == 'la' ? 'ອະນຸມັດ': "Approved",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                )),
          ],
        ),
      ): const SizedBox(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: _loding == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [ListTimesheetDetail(), ListTimesheet()],
              ),
            ),
    );
  }

  Widget ListTimesheet() {
    final providerService =
        Provider.of<ProviderService>(context, listen: false);
   
    providerService.adminTimesheetDateDetial?.data?.length;

    String Status = "";

    String? timesheetApproved =
        providerService.adminTimesheetListDetial?.timesheetApproved;
    Status =
        "${timesheetApproved == "-1" ?      providerService.langs == 'la' ? "ລໍຖ້າອະນຸມັດ": "Pending" : timesheetApproved == "1" ? providerService.langs == 'la' ? "ຖືກອະນຸມັດແລ້ວ" : "Approved":  providerService.langs == 'la' ?  "ບໍຖືກອະນຸມັດແລ້ວ" : "Disapproved"}";

    return providerService.adminTimesheetDateDetial?.data?.length == 0
        ? SizedBox(
            height: MediaQuery.of(context).size.height - 350,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search_outlined,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "ບໍ່ມີລາຍການ",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
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
                            child: const Text(
                              'ເພີ່ມ Timesheet',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
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
                  itemCount: model.adminTimesheetDateDetial?.data?.length,
                  itemBuilder: (context, index) {
                    final item = model.adminTimesheetDateDetial?.data?[index];
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: appBgColor,
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
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item?.workType == "B"
                                  ? 'ວຽກໂຄງການ'
                                  : item?.workType == "NB"
                                      ? "ວຽກບໍລິຫານອົງກອນ"
                                      : item?.workType == "Absence"
                                          ? "ຂາດ"
                                          : "",
                              style: TextStyle(
                                fontSize: 18.sp,
                                color: primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'ລະຫັດໜ້າວຽກ:',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 14.sp, color: black),
                                    ),
                                    Text(
                                      'ໄລຍະເວລາປະຕິບັດວຽກ:',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 10.sp, color: black),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      'ສະຖານະ: ',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 10.sp, color: black),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                      Text(
                                        overflow: TextOverflow.ellipsis,
                                        '${item?.workcode}',
                                        style: TextStyle(
                                            fontSize: 10.sp, color: black),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        '${item?.workHour} ຊົ້ວໂມງ',
                                        style: TextStyle(
                                            fontSize: 10.sp, color: black),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        '$Status',
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            color: timesheetApproved == "-1"
                                                ? const Color.fromRGBO(255, 153, 0, 1)
                                                : timesheetApproved == "1"
                                                    ? const Color.fromRGBO(
                                                        76, 175, 79, 1)
                                                      : timesheetApproved == "0" ? const Color.fromRGBO(
                                                        244, 67, 54, 1)
                                                        :  primary),
                                      ),
                                    ],
                                  ),
                                ),
                               
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
    final providerService =
        Provider.of<ProviderService>(context, listen: false);

    String formatcheckinTimes = "-";
    String formatcheckoutTimes = "";
    String SumInout = "";

    int Sumhour = 0;
    int Summinute = 0;

    String ShowHM = "";

    int Nday = providerService.AdmintimeSheetList!.day;
    int Nmonth = providerService.AdmintimeSheetList!.month;
    int Nyear = providerService.AdmintimeSheetList!.year;

    String Status = "";

    String? timesheetApproved =
        providerService.adminTimesheetListDetial?.timesheetApproved;

    Status =
        "${timesheetApproved == "-1" ? "ທາມຊີດລໍຖ້າອະນຸມັດ" : timesheetApproved == "1" ? "ທາມຊີດຖືກອະນຸມັດແລ້ວ" : "ທາມຊີດບໍຖືກອະນຸມັດແລ້ວ"}";

    if (providerService.adminTimesheetListDetial?.ioList?.toList().length == 1) {

      final Sumtotal =  DateTime(
          0,
          0,
          0,
          0,
          providerService.adminTimesheetListDetial?.ioList
                  ?.toList()[0]
                  .sumTotalMinutes ??
              0);

      Sumhour = int.parse(Sumtotal.hour.toString());
      Summinute = int.parse(Sumtotal.minute.toString());
      ShowHM =
          "${Sumhour >= 10 ? Sumhour : "0$Sumhour"}:${Summinute >= 10 ? Summinute : "0$Summinute"} ຊົ່ວໂມງ ";

      final checkinTime = providerService.adminTimesheetListDetial?.ioList
              ?.toList()[0]
              .checkinTime
              .toString() ??
          0;

      final checkinTimes = DateTime.parse('$checkinTime');

      formatcheckinTimes = DateFormat.Hm().format(checkinTimes);

      if (providerService.adminTimesheetListDetial?.ioList
              ?.toList()[0]
              .checkoutTime
              .toString() !=
          '0') {
        final checkoutTime = providerService.adminTimesheetListDetial?.ioList
                ?.toList()[0]
                .checkoutTime
                .toString() ??
            0;
        final checkoutTimes = DateTime.parse('$checkoutTime');
        formatcheckoutTimes = DateFormat.Hm().format(checkoutTimes);
      }

      SumInout = "$formatcheckinTimes - $formatcheckoutTimes";
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
              margin: const EdgeInsets.only(
                  right: 30, left: 30, top: 20, bottom: 20),
              child: SizedBox(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'ວັນເດື່ອນປີ:',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.sp,
                                    color: black),
                              ),
                              Text(
                                '${Nday >= 10 ? Nday : "0$Nday"}/${Nmonth >= 10 ? Nmonth : "0$Nmonth"}/$Nyear',
                                style: TextStyle(fontSize: 12.sp, color: black),
                              ),
                              Text(
                                'ລວມເວລາ:',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.sp,
                                    color: black),
                              ),
                              Text(
                                '$ShowHM',
                                style: TextStyle(fontSize: 12.sp, color: black),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'ເວລາ:',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.sp,
                                    color: black),
                              ),
                              Text(
                                '$SumInout',
                                style: TextStyle(fontSize: 12.sp, color: black),
                              ),
                              Text(
                                'ສະຖານະ: ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.sp,
                                    color: black),
                              ),
                              Text(
                                '$Status',
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    color: timesheetApproved == "-1"
                                        ? const Color.fromRGBO(255, 153, 0, 1)
                                        : timesheetApproved == "1"
                                            ? const Color.fromRGBO(76, 175, 79, 1)
                                            : const Color.fromRGBO(244, 67, 54, 1)),
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
    final providerService =
        Provider.of<ProviderService>(context, listen: false);

    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Center(
            child: Text('ຢືນຢັນການ Approval',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold))),
        content: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Text("ທ່ານຕ້ອງການ Approval OT ນີ້ບໍ?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: primary,
                      fontSize: 12,
                      fontWeight: FontWeight.w300)),
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
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
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
                      _showDialogLoding();
                       final Approval = await providerService.ApprovalTimeSheet(
                        '1',
                        '',
                      );

                     

                      if (Approval == true) {
                        _showDialogLodingAction();
                        setState(() {
                          stdblack = "true";
                        });

                        await Future.delayed(const Duration(seconds: 1), (() async {
                          setState(() async {
                            // await providerService.SetAdminOTId(
                            //     providerService.OTAdminId, 3);
                            Navigator.pop(context, "true");
                            Navigator.pop(context, "true");
                            Navigator.pop(context, "true");

                            setData();
                          });
                          // Navigator.pop(context, "true");
                        }));
                      } else {
                        _showDialogUnsuccus('');
                      }
                    },
                    borderRadius: BorderRadius.circular(24),
                    child: const Text(
                      'ຕົກລົງ',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    )),
              )
            ],
          ),
        ],
      ),
    );
  }


Future<void> _showUnSuccus() async {
    final providerService =
        Provider.of<ProviderService>(context, listen: false);

    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Center(
            child: Text('ຢືນຢັນການ UnApproval ',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold))),
        content: TextField(
                          keyboardType: TextInputType.multiline,
                          maxLines: 4,
                          controller: _remark,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 20.0),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(
                                  color: const Color(0xff1C9A7F).withOpacity(0.50),
                                  width: 2.0,
                                ),
                              ),
                              fillColor: const Color(0xfff3f3f4),
                              filled: true,
                              hintText: "ເຫດຜົນທີ່ ບໍອະນຸມັດ"),
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
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
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
                      _showDialogLoding();
                        final Approval = await providerService.ApprovalTimeSheet(
                        '0',
                         '${_remark.text}',
                      );

                     

                      if (Approval == true) {
                        _showDialogLodingAction();
                        setState(() {
                          stdblack = "true";
                        });

                        await Future.delayed(const Duration(seconds: 1), (() async {
                          setState(() async {
                            await providerService.SetAdminOTId(
                                providerService.OTAdminId, 3);
                            Navigator.pop(context, "true");
                            Navigator.pop(context, "true");
                            Navigator.pop(context, "true");

                            setData();
                          });
                          // Navigator.pop(context, "true");
                        }));
                      } else {
                        _showDialogUnsuccus('');
                      }
                    },
                    borderRadius: BorderRadius.circular(24),
                    child: const Text(
                      'ຕົກລົງ',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    )),
              )
            ],
          ),
        ],
      ),
    );
  }
 Future<void> _showDialogUnsuccus(String? Msg) async {
    final providerService =
        Provider.of<ProviderService>(context, listen: false);

    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('ຂໍ້ຄວາມ'),
        content: Text("${Msg == '' ? 'ລອງໃໝ່ອີກຄັ້ງ' : Msg}"),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
  


  Future<void> _showDialogLoding() async {
    final providerService =
        Provider.of<ProviderService>(context, listen: false);

    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return  WillPopScope(
              onWillPop: () async => true,
              child: const SimpleDialog(
                  backgroundColor: Colors.white,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "ກຳລັງໂຫລດ......",
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
        return const AlertDialog(
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
              SizedBox(height: 60.0),
            ],
          ),
        );
      },
    );
  }
}
