// ignore_for_file: deprecated_member_use, use_build_context_synchronously, unused_field, library_private_types_in_public_api

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fms_mobile_app/model/teamwork.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:fms_mobile_app/pages/leave/models/leave_type_models.dart';
import 'package:fms_mobile_app/services/provider_service.dart';
import 'package:fms_mobile_app/theme/color.dart';
import 'package:fms_mobile_app/widgets/MyElevatedButton_Primary.dart';
import 'package:fms_mobile_app/widgets/MyElevatedButton_Secondary.dart';
import 'package:fms_mobile_app/widgets/loading/loading_widget.dart';
import 'package:fms_mobile_app/widgets/login/showdialogLoading/showDialogLoading.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:timelines/timelines.dart';

class LeaveNew extends StatefulWidget {
  const LeaveNew({Key? key}) : super(key: key);

  @override
  _LeaveNewState createState() => _LeaveNewState();
}

class _LeaveNewState extends State<LeaveNew> {
  bool? _loding;
  double totalh = 0.0;
  Color completeColor = Colors.grey.shade500;
  Color inProgressColor = const Color(0xff5ec792);
  Color todoColor = const Color(0xffd1d2d7);

  DateTime? _fromDateStart;
  DateTime? _fromDateEnd;
  TextEditingController _remark = TextEditingController();

  String? TeamID;
  String? lavetype;

  int _processIndex = 0;

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

  @override
  void initState() {
    context.read<ProviderService>().setLeaveType();
    context.read<ProviderService>().setTeamWork();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final providerService = Provider.of<ProviderService>(context);

    final teamwork = providerService.teamwork;
    final leavetype = providerService.leavetype;

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
              Navigator.pop(context, ''
                  // MYHomePage is another page for showcase
                  // replace it with your page name
                  );
            },
          ),
          title: Text(
            providerService.langs == 'la' ? "ປ້ອນຂໍ້ມູນຂໍລາພັກ" : "Leave",
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
        body: Consumer<ProviderService>(builder: (ctn, value, ch) {
          if (value.leavetype == null) {
            const LoadingWidget();
          } else {
            return SingleChildScrollView(
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
                            Color color;
                            Widget? child;
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
                        const SizedBox(height: 20),
                        const Padding(
                          padding: EdgeInsets.only(left: 10, right: 10, bottom: 5),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "ປະເພດການລາພັກ",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ),
                        ),
                        DropdownButtonFormField(
                          value: lavetype,
                          items: leavetype!.data.map((LeaveType item) {
                            return DropdownMenuItem(
                                onTap: () {
                                  //set Data to local
                                },
                                value: item.leaveTypeId.toString(),
                                child: Text(
                                  item.leaveTypeName,
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                ));
                          }).toList(),
                          onChanged: (String? value) {
                            lavetype = value.toString();
                            
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(
                                  color: const Color(0xff1C9A7F).withOpacity(0.50),
                                  width: 2.0,
                                ),
                              ),
                              fillColor: const Color(0xfff3f3f4),
                              filled: true,
                              hintText: "ເລືອກເຫດຜົນການລາພັກ"),
                        ),
                        const SizedBox(height: 20),
                        const Padding(
                          padding: EdgeInsets.only(left: 10, right: 10, bottom: 5),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "ຜູ້ປະຕິບັດວຽກແທນ",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ),
                        ),
                        DropdownButtonFormField(
                          value: TeamID,
                          items: teamwork.map((TeamWork item) {
                            return DropdownMenuItem(
                                value: item.employeeId.toString(),
                                child: Text(
                                  item.fullname.toString(),
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                ));
                          }).toList(),
                          onChanged: (String? value) {
                            TeamID = value.toString();
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(
                                  color: const Color(0xff1C9A7F).withOpacity(0.50),
                                  width: 2.0,
                                ),
                              ),
                              fillColor: const Color(0xfff3f3f4),
                              filled: true,
                              hintText: "ເລືອກສະມາຊິກໃນທີມ"),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              providerService.langs == 'la' ? "ມື້ເລີ່ມພັກ" : "Start",
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ),
                        ),
                        DateTimeField(
                          format: DateFormat("yyyy-MM-dd"),
                          onSaved: (val) => setState(() => _fromDateStart = val),
                          keyboardType: TextInputType.datetime,
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
                              hintText: "ເລືອກມື້ເລີ່ມພັກ"),
                          onChanged: (DateTime? newValue) async {
                            setState(() {
                              _fromDateStart = newValue;
                              
                            });
                          },
                          onShowPicker: (context, currentValue) {
                            final date = DateTime.now();
                            return showDatePicker(
                                context: context,
                                firstDate: DateTime(1900),
                                initialDate: currentValue ?? DateTime.now(),
                                lastDate: DateTime(date.year + 10));
                          },
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              providerService.langs == 'la' ? "ຈົນເຖິງ" : "End ",
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ),
                        ),
                        DateTimeField(
                          format: DateFormat("yyyy-MM-dd"),
                          onSaved: (val) => setState(() => _fromDateEnd = val),
                          keyboardType: TextInputType.datetime,
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
                              hintText: "ເລືອກມື້ພັກສຸດທ້າຍ"),
                          onChanged: (DateTime? newValue) async {
                            setState(() {
                              _fromDateEnd = newValue;

                              
                            });
                          },
                          onShowPicker: (context, currentValue) {
                            final date = DateTime.now();
                            return showDatePicker(
                                context: context,
                                firstDate: DateTime(1900),
                                initialDate: currentValue ?? DateTime.now(),
                                lastDate: DateTime(date.year + 10));
                          },
                        ),
                        const SizedBox(height: 20),
                        const Padding(
                          padding: EdgeInsets.only(left: 10, right: 10, bottom: 5),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "ເຫດຜົນຂໍລາພັກ",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                            ),
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
                                    onPressed: () async {
                                      if (_fromDateStart != null &&
                                          _fromDateEnd != null &&
                                          _remark.text != "" &&
                                          TeamID != null) {
                                        if (_fromDateStart!.isAfter(_fromDateEnd!)) {
                                          ShowDialoadingWidget().showDialogUnsuccus(
                                              'Error: Start date cannot be after end date.', context);
                                        } else {
                                          _showSuccus();
                                        }
                                      } else {
                                        ShowDialoadingWidget().showDialogUnsuccus("", context);
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
                      ]),
                    )
                  ],
                ),
              ),
            );
          }
          return const Center(
            child: LoadingWidget(),
          );
        }));
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
              child: Text("ທ່ານຕ້ອງການຂໍລາພັກ ບໍ?",
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
                      ShowDialoadingWidget().showDialogLoding(context, 'ກຳລັງໂຫລດ...');
                      final addLeaveSelect = await providerService.AddLeaveNew(
                        _fromDateStart.toString(),
                        _fromDateEnd.toString(),
                        lavetype.toString(),
                        _remark.text,
                        TeamID.toString(),
                      );

                      if (addLeaveSelect == true) {
                        ShowDialoadingWidget().showDialogLodingAction(context);
                        await Future.delayed(const Duration(seconds: 1));
                        Navigator.pop(context, "true");
                        Navigator.pop(context, "true");
                        Navigator.pop(context, "true");
                        Navigator.pop(context, "true");
                      } else {
                        ShowDialoadingWidget().showDialogUnsuccus("", context);
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

    double angle;
    Offset offset1;
    Offset offset2;

    Path path;

    if (drawStart) {
      angle = 3 * pi / 4;
      offset1 = _offset(radius, angle);
      offset2 = _offset(radius, -angle);
      path = Path()
        ..moveTo(offset1.dx, offset1.dy)
        ..quadraticBezierTo(0.0, size.height / 2, -radius, radius) 
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
