// ignore_for_file: deprecated_member_use

import 'dart:math';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fms_mobile_app/model/projectall.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:fms_mobile_app/model/worktype.dart';
import 'package:fms_mobile_app/pages/calendar/models/worktype/work_type_models.dart';
import 'package:fms_mobile_app/pages/home/OT/service/worktype_service.dart';
import 'package:fms_mobile_app/services/provider_service.dart';
import 'package:fms_mobile_app/theme/color.dart';
import 'package:fms_mobile_app/widgets/MyElevatedButton_Primary.dart';
import 'package:fms_mobile_app/widgets/MyElevatedButton_Secondary.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:timelines/timelines.dart';

class OverTimeOT extends StatefulWidget {
  const OverTimeOT({Key? key}) : super(key: key);

  @override
  _OverTimeOTState createState() => _OverTimeOTState();
}

class _OverTimeOTState extends State<OverTimeOT> {
  bool? _btnStartisLoading = false;
  bool? _loding;
  double totalh = 0.0;
  Color completeColor = Colors.grey.shade500;
  Color inProgressColor = const Color(0xff5ec792);
  Color todoColor = const Color(0xffd1d2d7);

  DateTime? _fromDateStart;
  DateTime? _fromDateEnd;
  final TextEditingController _remark = TextEditingController();
  TextEditingController DateStartNow = TextEditingController();

  List<dynamic> WorkCodeItem = [];
  List<dynamic> WorkAllItemAll = [];

  String? projectId;
  String? workCodeId;
  String? workType;

  final int _processIndex = 0;

  final _timestart = TextEditingController();
  final _timeend = TextEditingController();
  final _timeTotal = TextEditingController();

  TimeOfDay timeStart = TimeOfDay.now().replacing(hour: 0, minute: 0);
  TimeOfDay timeEnd = TimeOfDay.now().replacing(hour: 0, minute: 0);
  String? totalhShow;

  // String TeamID = categories.first.id.toString();
  Color getColor(int index) {
    if (index == _processIndex) {
      return primary;
    } else if (index < _processIndex) {
      return primary;
    } else {
      return todoColor;
    }
  }

  void _selectTimeStart() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: timeStart,
    );
    if (newTime != null) {
      setState(() {
        timeStart = newTime;

        final now = new DateTime.now();
        final startNew = new DateTime(now.year, now.month, now.day, timeStart.hour, timeStart.minute);
        final startEnd = new DateTime(now.year, now.month, now.day, timeEnd.hour, timeEnd.minute);

        if (startNew.isAfter(startEnd)) {
          startEnd.add(const Duration(days: 1));
          Duration diff = startEnd.difference(startNew);
          final hours = diff.inHours;
          final minutes = diff.inMinutes % 60;
          print(DateTime.now());
          // print('$hours hours $minutes minutes');
          totalhShow = '$hours ຊົ່ວໂມງ $minutes ນາທີ';
          //  print('$hours.$minutes');
          totalh = double.parse('$hours.$minutes');
        } else if (startEnd.isAfter(startNew)) {
          Duration diff = startEnd.difference(startNew);

          final hours = diff.inHours;
          final minutes = diff.inMinutes % 60;

          totalhShow = '$hours ຊົ່ວໂມງ $minutes ນາທີ';
          print('$hours.$minutes');
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
    final providerService = Provider.of<ProviderService>(context, listen: false);
    setState(() {
      _loding = true;
    });

    DateTime dateTime = DateTime.now();

    String dateNows = dateTime.toLocal().toString().split(' ')[0];

    DateStartNow.text = dateNows;

    await providerService.setTimesheet();

    final workCode = providerService.workcode;

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

      WorkAllItemAll = WorkCodeItem.where((element) => element["work_type_id"].toString() == "1").toList();
    }

    setState(() {
      _loding = false;
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final providerService = Provider.of<ProviderService>(context);

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
            Navigator.pop(context, '');
          },
        ),
        title: Text(
          "ປ້ອນຂໍ້ມູນຂໍ OT",
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
                padding: const EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 80,
                      padding: const EdgeInsets.only(),
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
                      child: Timeline.tileBuilder(
                        theme: TimelineThemeData(
                          direction: Axis.horizontal,
                          connectorTheme: const ConnectorThemeData(
                            space: 30.0,
                            thickness: 5.0,
                          ),
                        ),
                        builder: TimelineTileBuilder.connected(
                          connectionDirection: ConnectionDirection.before,
                          itemExtentBuilder: (_, __) => MediaQuery.of(context).size.width / _processes.length,
                          contentsBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 2.0),
                              child: Text(
                                _processes[index],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: getColor(index),
                                ),
                              ),
                            );
                          },
                          indicatorBuilder: (_, index) {
                            var color;
                            var child;
                            if (index == _processIndex) {
                              color = primary;
                              child = const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: CircularProgressIndicator(
                                  strokeWidth: 3.0,
                                  valueColor: AlwaysStoppedAnimation(Colors.white),
                                ),
                              );
                            } else if (index < _processIndex) {
                              color = primary;
                              child = const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 24.0,
                              );
                            } else {
                              color = todoColor;
                            }

                            if (index <= _processIndex) {
                              return Stack(
                                children: [
                                  CustomPaint(
                                    size: const Size(2.0, 2.0),
                                    painter: _BezierPainter(
                                      color: color,
                                      drawStart: index > 0,
                                      drawEnd: index < _processIndex,
                                    ),
                                  ),
                                  DotIndicator(
                                    size: 30.0,
                                    color: color,
                                    child: child,
                                  ),
                                ],
                              );
                            } else {
                              return Stack(
                                children: [
                                  CustomPaint(
                                    size: const Size(15.0, 15.0),
                                    painter: _BezierPainter(
                                      color: color,
                                      drawEnd: index < _processes.length - 1,
                                    ),
                                  ),
                                  OutlinedDotIndicator(
                                    borderWidth: 4.0,
                                    color: color,
                                  ),
                                ],
                              );
                            }
                          },
                          connectorBuilder: (_, index, type) {
                            if (index > 0) {
                              if (index == _processIndex) {
                                final prevColor = getColor(index - 1);
                                final color = getColor(index);
                                List<Color> gradientColors;
                                if (type == ConnectorType.start) {
                                  gradientColors = [Color.lerp(prevColor, color, 0.5)!, color];
                                } else {
                                  gradientColors = [prevColor, Color.lerp(prevColor, color, 0.5)!];
                                }
                                return DecoratedLineConnector(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: gradientColors,
                                    ),
                                  ),
                                );
                              } else {
                                return SolidLineConnector(
                                  color: getColor(index),
                                );
                              }
                            } else {
                              return null;
                            }
                          },
                          itemCount: _processes.length,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 10),
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
                      child: Column(children: [
                        const SizedBox(height: 10),
                        const Padding(
                          padding: EdgeInsets.only(left: 10, right: 10, bottom: 5),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "ປະເພດວຽກ",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.only(right: 8, left: 8, top: 3, bottom: 2),
                          child: DropdownSearch<DataModels>(
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
                                labelText: 'ເລືອກປະເພດວຽກ',
                              ),
                            ),

                            asyncItems: (String filter) async {
                              return providerService.workType;
                            },
                            itemAsString: (DataModels u) => u.name.toString(),
                            onChanged: (DataModels? data) {
                              workType = data?.code ?? "";
                            },
                            items: providerService.workType,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 10, right: 10, bottom: 5),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "ໂຄງການ",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Padding(
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
                                labelText: 'ເລືອກໂຄງການ',
                              ),
                            ),

                            asyncItems: (String filter) async {
                              providerService.setProject(filter);
                              return providerService.projectAll;
                            },
                            itemAsString: (ProjectAll u) => u.projectName.toString(),
                            onChanged: (ProjectAll? data) {
                              print(data?.projectId.toString());
                              projectId = data?.projectId.toString() ?? "";
                            },
                            items: providerService.projectAll,
                          ),
                        ),
                        FormHelper.dropDownWidgetWithLabel(
                            context, "ລະຫັດໜ້າວຽກ", "ເລືອກລະຫັດໜ້າວຽກ", workCodeId, WorkAllItemAll, (onChangedVal) {
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
                            borderRadius: 20),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: MyElevatedButtonPrimary(
                                  onPressed: () async {
                                    String detail = _remark.text;
                                    String workcode = workCodeId.toString();
                                    String project_id = projectId.toString();
                                    String workType_id = workType.toString();

                                    print(detail);
                                    print(workcode);
                                    print(project_id);
                                    print(workType_id);
                                    print("${providerService.userLocation?.latitude},${providerService.userLocation?.longitude}");
                                    final now = new DateTime.now();

                                 

                                    if (_fromDateStart != null &&
                                        _remark.text != "" &&
                                        workCodeId != null &&
                                        projectId != null) {
                                      // final startNew = DateTime(_fromDateStart!.year, _fromDateStart!.month,
                                      //     _fromDateStart!.day, timeStart.hour, timeStart.minute);
                                      // final startEnd = DateTime(_fromDateStart!.year, _fromDateStart!.month,
                                      //     _fromDateStart!.day, timeEnd.hour, timeEnd.minute);

                                      print(detail);
                                      print(workcode);
                                      print(project_id);

                                      await WorkTypeService()
                                          .startOT(
                                              context,
                                              project_id,
                                              workcode,
                                              workcode,
                                              '${providerService.userLocation?.latitude},${providerService.userLocation?.longitude}',
                                              detail)
                                          .then((value) {
                                        providerService.setCheckButtonOT(true);
                                      });
                                    }
                                  },
                                  borderRadius: BorderRadius.circular(24),
                                  child: const Text(
                                    'ເພີ່ມ',
                                    style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ]),
                    )
                  ],
                ),
              ),
            ),
    );
  }

  Future<void> _showDialogUnsuccus(String? Msg) async {
    // final providerService =
    //     Provider.of<ProviderService>(context, listen: false);

    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('ຂໍ້ຄວາມ'),
        content: Text("${Msg == '' ? 'ກະລຸນາຕື່ມຂໍ້ມູນໃຫ້ຄົບຖ້ວນ' : Msg}"),
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
              child: Text("ທ່ານຕ້ອງການຂໍ OT ບໍ?",
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
                      // final startNew = DateTime(_fromDateStart!.year, _fromDateStart!.month, _fromDateStart!.day,
                      //     timeStart.hour, timeStart.minute);
                      // final startEnd = DateTime(_fromDateStart!.year, _fromDateStart!.month, _fromDateStart!.day,
                      //     timeEnd.hour, timeEnd.minute);

                      // String date = _fromDateStart.toString();
                      // String start_time = startNew.toString();
                      // String end_time = startEnd.toString();

                      // final AddOTSelect = await providerService.AddOTNew(
                      //   date,
                      //   start_time,
                      //   end_time,
                      //   detail,
                      //   project_id,
                      //   workcode,
                      // );
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
          return WillPopScope(
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
              ],
            ),
          );
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

class _BezierPainter extends CustomPainter {
  const _BezierPainter({
    required this.color,
    this.drawStart = true,
    this.drawEnd = true,
  });

  final Color color;
  final bool drawStart;
  final bool drawEnd;

  Offset _offset(double radius, double angle) {
    return Offset(
      radius * cos(angle) + radius,
      radius * sin(angle) + radius,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = color;

    final radius = size.width / 2;

    var angle;
    var offset1;
    var offset2;

    var path;

    if (drawStart) {
      angle = 3 * pi / 4;
      offset1 = _offset(radius, angle);
      offset2 = _offset(radius, -angle);
      path = Path()
        ..moveTo(offset1.dx, offset1.dy)
        ..quadraticBezierTo(0.0, size.height / 2, -radius, radius) // TODO connector start & gradient
        ..quadraticBezierTo(0.0, size.height / 2, offset2.dx, offset2.dy)
        ..close();

      canvas.drawPath(path, paint);
    }
    if (drawEnd) {
      angle = -pi / 4;
      offset1 = _offset(radius, angle);
      offset2 = _offset(radius, -angle);

      path = Path()
        ..moveTo(offset1.dx, offset1.dy)
        ..quadraticBezierTo(size.width, size.height / 2, size.width + radius, radius)
        ..quadraticBezierTo(size.width, size.height / 2, offset2.dx, offset2.dy)
        ..close();

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(_BezierPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.drawStart != drawStart || oldDelegate.drawEnd != drawEnd;
  }
}

final _processes = [
  'ປ້ອນຂໍ້ມູນ',
  'ລໍຖ້າກວດສອບ',
  'ສຳເລັດ',
];
