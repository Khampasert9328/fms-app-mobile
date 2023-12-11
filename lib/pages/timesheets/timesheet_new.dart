// ignore_for_file: deprecated_member_use

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fms_mobile_app/model/projectall.dart';
import 'package:fms_mobile_app/pages/home/provider/timer_provider.dart';

import 'package:fms_mobile_app/services/provider_service.dart';
import 'package:fms_mobile_app/theme/color.dart';
import 'package:fms_mobile_app/widgets/MyElevatedButton_Primary.dart';
import 'package:fms_mobile_app/widgets/MyElevatedButton_Secondary.dart';
import 'package:provider/provider.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

class TimeSheetNew extends StatefulWidget {
  const TimeSheetNew({Key? key}) : super(key: key);

  @override
  _TimeSheetNewState createState() => _TimeSheetNewState();
}

class _TimeSheetNewState extends State<TimeSheetNew> {
  String workCodeId = "";
  String workTypeId = "";
  String projectId = "";

  List<dynamic> WorkTypeItem = [];
  List<dynamic> WorkCodeItem = [];
  List<dynamic> WorkAllItemAll = [];

  bool? _loding;
  double totalh = 0.0;
  String? totalhShow;

  bool? _lodingBtn;

  final _timestart = TextEditingController();
  final _timeend = TextEditingController();
  final _timeTotal = TextEditingController();

  TextEditingController _remark = TextEditingController();

  TimeOfDay timeStart = TimeOfDay.now().replacing(hour: 0, minute: 0);
  TimeOfDay timeEnd = TimeOfDay.now().replacing(hour: 0, minute: 0);

  void _selectTimeStart() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: timeStart,
    );
    if (newTime != null) {
      setState(() {
        timeStart = newTime;

        final now = DateTime.now();
        final startNew = DateTime(now.year, now.month, now.day, timeStart.hour, timeStart.minute);
        final startEnd = DateTime(now.year, now.month, now.day, timeEnd.hour, timeEnd.minute);

        if (startNew.isAfter(startEnd)) {
          startEnd.add(const Duration(days: 1));
          Duration diff = startEnd.difference(startNew);
          final hours = diff.inHours;
          final minutes = diff.inMinutes % 60;
          // print('$hours hours $minutes minutes');
          totalhShow = '$hours ຊົ່ວໂມງ $minutes ນາທີ';
          //  print('$hours.$minutes');
          totalh = double.parse('$hours.$minutes');
        } else if (startEnd.isAfter(startNew)) {
          Duration diff = startEnd.difference(startNew);

          final hours = diff.inHours;
          final minutes = diff.inMinutes % 60;

          totalhShow = '$hours ຊົ່ວໂມງ $minutes ນາທີ';
          totalh = double.parse('$hours.$minutes');
        }
      });
    }
  }

  void _selectTimeEnd() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: timeEnd,
    );
    if (newTime != null) {
      setState(() {
        timeEnd = newTime;

        final now = DateTime.now();
        final startNew = DateTime(now.year, now.month, now.day, timeStart.hour, timeStart.minute);
        final startEnd = DateTime(now.year, now.month, now.day, timeEnd.hour, timeEnd.minute);

        if (startNew.isAfter(startEnd)) {
          startEnd.add(const Duration(days: 1));
          Duration diff = startEnd.difference(startNew);
          final hours = diff.inHours;
          final minutes = diff.inMinutes % 60;
          // print('$hours hours $minutes minutes');
          totalhShow = '$hours ຊົ່ວໂມງ $minutes ນາທີ';
          //  print('$hours.$minutes');
          totalh = double.parse('$hours.$minutes');
        } else if (startEnd.isAfter(startNew)) {
          Duration diff = startEnd.difference(startNew);

          final hours = diff.inHours;
          final minutes = diff.inMinutes % 60;
          //   print('$hours hours $minutes minutes');
          totalhShow = '$hours ຊົ່ວໂມງ $minutes ນາທີ';
          //   print('$hours.$minutes');
          totalh = double.parse('$hours.$minutes');

          //  print(totalh);
        }
      });
    }
  }

  void setData() async {
    setState(() {
      _loding = true;
    });

    final providerService = Provider.of<ProviderService>(context, listen: false);
    await providerService.setTimesheet();
    final workType = providerService.workType;
    final workCode = providerService.workcode;
    //  print(workType.length);
    //  print(workCode.length);
    for (var i = 0; i < workType.length; i++) {
      //  print(1);
      WorkTypeItem.add(
        {"work_type_id": workType[i].workTypeId, "name": workType[i].name, "code": workType[i].code},
      );
    }

    for (var i = 0; i < workCode.length; i++) {
      // print(2);
      WorkCodeItem.add(
        {
          "workcode_id": workCode[i].workcodeId,
          "workcode": workCode[i].workcode,
          "division_id": workCode[i].divisionId,
          "work_type_id": workCode[i].workTypeId,
        },
      );
    }

    setState(() {
      _loding = false;
    });

    //  await providerService.setWorkcodeAll();
    //  await providerService.setProject("");
  }

  @override
  void initState() {
    setData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final providerService = Provider.of<ProviderService>(context, listen: false);
    final timer = Provider.of<TimerProvider>(context, listen: false);
    //final workType = providerService.workType;

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
            Navigator.pop(
              context,
              // MYHomePage is another page for showcase
              // replace it with your page name
            );
          },
        ),
        title: Text(
          providerService.langs == 'la' ? "ການປ້ອນ Timesheet" : " Timesheet ",
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
      body: _loding == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FormHelper.dropDownWidgetWithLabel(
                        context,
                        providerService.langs == 'la' ? "ປະເພດວຽກ" : " Work Type ",
                        providerService.langs == 'la' ? "ເລືອກປະເພດວຽກ" : " Select Work Type ",
                        workTypeId,
                        WorkTypeItem, (onChangedVal) {
                      setState(() {
                        workTypeId = onChangedVal.toString();

                        WorkAllItemAll = WorkCodeItem.where(
                            (element) => element["work_type_id"].toString() == onChangedVal.toString()).toList();
                      });
                    }, (onValidate) {
                      return null;
                    },
                        borderColor: primary,
                        borderFocusColor: primary,
                        optionLabel: "name",
                        optionValue: "work_type_id",
                        paddingLeft: 0,
                        paddingRight: 0,
                        paddingTop: 0,
                        paddingBottom: 0,
                        labelFontSize: 15,
                        borderRadius: 20),

                    const SizedBox(
                      height: 10.0,
                    ),

                    workTypeId == "1"
                        ? Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
                            child: Text(
                              providerService.langs == 'la' ? "ໂຄງການ" : " Project",
                              // ignore: prefer_const_constructors
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          )
                        : Container(),
                    workTypeId == "1"
                        ? Padding(
                            padding: const EdgeInsets.only(right: 8, left: 8, top: 3, bottom: 2),
                            child: DropdownSearch<ProjectAll>(
                              popupProps: const PopupProps.modalBottomSheet(
                                showSearchBox: true,
                              ),
                              filterFn: (user, filter) => user.userFilterByCreationDate(filter),
                              //  selectedItem: "Brazil",
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),

                                  //border: OutlineInputBorder(),
                                  contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(
                                      color: const Color(0xff1C9A7F).withOpacity(0.50),
                                      width: 2.0,
                                    ),
                                  ),
                                  fillColor: const Color(0xfff3f3f4),
                                  filled: true,
                                  labelText: providerService.langs == 'la' ? 'ເລືອກໂຄງການ' : "Select Project",
                                ),
                              ),

                              asyncItems: (String filter) async {
                                providerService.setProject(filter);
                                return providerService.projectAll;
                              },
                              itemAsString: (ProjectAll u) => u.projectName.toString(),
                              onChanged: (ProjectAll? data) {
                                projectId = data?.projectId.toString() ?? "";
                              },
                              items: providerService.projectAll,
                            ),
                          )
                        : Container(),

                    // ignore: prefer_const_constructors
                    workTypeId != ""
                        ? FormHelper.dropDownWidgetWithLabel(
                            context,
                            providerService.langs == 'la' ? "ລະຫັດໜ້າວຽກ" : "Work Code",
                            providerService.langs == 'la' ? "ເລືອກໜ້າວຽກ" : "Select Work Code",
                            workCodeId,
                            WorkAllItemAll, (onChangedVal) {
                            setState(() {
                              workCodeId = onChangedVal.toString();
                            });
                          }, (onValidate) {
                            return null;
                          },
                            borderColor: primary,
                            borderFocusColor: primary,
                            optionLabel: "workcode",
                            optionValue: "workcode_id",
                            paddingLeft: 0,
                            paddingRight: 0,
                            paddingTop: 0,
                            paddingBottom: 0,
                            labelFontSize: 15,
                            borderRadius: 20)
                        : Container(),

                    const SizedBox(
                      height: 10.0,
                    ),
                    workTypeId != "3" && workTypeId != ""
                        ? Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
                            child: Text(
                              providerService.langs == 'la' ? "ຊົ່ວໂມງເຮັດວຽກ" : "Total",
                              // ignore: prefer_const_constructors
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          )
                        : Container(),

                    const SizedBox(height: 10),
                    workTypeId != "3" && workTypeId != ""
                        ? SizedBox(
                            height: 50,
                            child: TextField(
                              readOnly: true,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(
                                      color: const Color(0xff1C9A7F).withOpacity(0.50),
                                      width: 2.0,
                                    ),
                                  ),
                                  fillColor: const Color(0xfff3f3f4),
                                  filled: true,
                                  hintText: "${timer.duration.inHours}: ${timer.duration.inMinutes.remainder(60)}: ${timer.duration.inSeconds.remainder(60)}"),
                              controller: _timeTotal,
                            ),
                          )
                        : Container(),

                    workTypeId != "3" && workTypeId != ""
                        ? const SizedBox(
                            height: 20.0,
                          )
                        : Container(),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
                      child: Text(
                        providerService.langs == 'la' ? "ໝາຍເຫດ" : "Remark",
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ),

                    TextField(
                      keyboardType: TextInputType.multiline,
                      maxLines: 4,
                      controller: _remark,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: const Color(0xff1C9A7F).withOpacity(0.50),
                              width: 2.0,
                            ),
                          ),
                          fillColor: const Color(0xfff3f3f4),
                          filled: true,
                          hintText: "ພິມຂໍ້ຄວາມ"),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: MyElevatedButtonPrimary(
                                onPressed: () {
                                  if (workTypeId != "") {
                                    if (workTypeId == '1' && projectId != "" && workCodeId != "") {
                                      _showSuccus();
                                    } else if (workTypeId == '2' && workCodeId != "" ) {
                                      _showSuccus();
                                    } else if (workTypeId == '3' && workCodeId != "") {
                                      _showSuccus();
                                    } else {
                                      _showDialogUnsuccus();
                                    }
                                  } else {
                                    _showDialogUnsuccus();
                                  }
                                },
                                borderRadius: BorderRadius.circular(24),
                                child: const Text(
                                  'ເພີ່ມ',
                                  style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                                )),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
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
              child: Text("ທ່ານຕ້ອງການເພີ່ມ Timesheet ບໍ?",
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
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: MyElevatedButtonPrimary(
                    height: 30,
                    onPressed: () async {
                       final timer = Provider.of<TimerProvider>(context, listen: false);
                      // setState(() {

                      // //  _loding = true;

                      // });
                      _showDialogLoding();
                      final providerService = Provider.of<ProviderService>(context, listen: false);

                      int Nday = providerService.timeSheetList!.day;
                      int Nmonth = providerService.timeSheetList!.month;
                      int Nyear = providerService.timeSheetList!.year;

                      String date = "${Nyear}-$Nmonth-$Nday";
                      String remark = _remark.text;
                      String work_type = workTypeId;
                      String workcode = workCodeId;
                      String work_hour = work_type == '3' ? "0.0" : totalh.toString();
                      String project_id = work_type == '1' ? projectId : "";


                      final AddTimesheeSelect = await providerService.AddTimesheeSelect(
                          date, project_id, work_type, workcode, '${timer.duration.inHours}.${timer.duration.inMinutes.remainder(60)}', remark, context);

                      // await Future.delayed(const Duration(seconds: 3));

                      if (AddTimesheeSelect == true) {
                        _showDialogLodingAction();
                        await Future.delayed(const Duration(seconds: 1), (() async {
                          Navigator.pop(context, "true");
                          Navigator.pop(context, "true");
                          Navigator.pop(context, "true");
                          Navigator.pop(context, "true");
                        }));
                      }
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

  Future<void> _showDialogUnsuccus() async {
    final providerService = Provider.of<ProviderService>(context, listen: false);

    return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) => const AlertDialog(
        title: Text('ຂໍ້ຄວາມ'),
        content: Text("ກະລຸນາຕື່ມຂໍ້ມູນໃຫ້ຄົບຖ້ວນ"),
        actions: <Widget>[
          // TextButton(
          //   onPressed: () => Navigator.pop(context, 'OK'),
          //   child: const Text('OK'),
          // ),
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
              child: const SimpleDialog(backgroundColor: Colors.white, children: <Widget>[
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

          // actions: <Widget>[
          //   TextButton(
          //     child: Text('OK'),
          //     onPressed: () {
          //       Navigator.of(context).pop();
          //     },
          //   ),
          // ],
        );
      },
    );
  }
}
