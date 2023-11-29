// ignore_for_file: deprecated_member_use

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fms_mobile_app/model/teamwork.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:fms_mobile_app/services/provider_service.dart';
import 'package:fms_mobile_app/shared/mydata.dart';
import 'package:fms_mobile_app/theme/color.dart';
import 'package:fms_mobile_app/widgets/MyElevatedButton_Primary.dart';
import 'package:fms_mobile_app/widgets/MyElevatedButton_Secondary.dart';
import 'package:fms_mobile_app/widgets/custom_image.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:timelines/timelines.dart';

class LeavePageDetail extends StatefulWidget {
  const LeavePageDetail({Key? key}) : super(key: key);

  @override
  _LeavePageDetailState createState() => _LeavePageDetailState();
}

class _LeavePageDetailState extends State<LeavePageDetail> {
  bool? _loding;
  double totalh = 0.0;
  Color completeColor = Colors.grey.shade500;
  Color inProgressColor = const Color(0xff5ec792);
  Color todoColor = const Color(0xffd1d2d7);

  DateTime? _fromDateStart;
  DateTime? _fromDateEnd;
  TextEditingController _remark = TextEditingController();

  String? TeamID;

  int _processIndex = 0;

  Color getColor(int index) {
    if (index == _processIndex) {
      return primary;
    } else if (index < _processIndex) {
      return primary;
    } else {
      return todoColor;
    }
  }

  void setData() async {
    final providerService = Provider.of<ProviderService>(context, listen: false);
    setState(() {
      _loding = true;
    });

    _processIndex = providerService.LeaveIdProcessIndex!;
    await providerService.setLeaveByID();

    setState(() {
      _loding = false;
    });
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
    final providerService = Provider.of<ProviderService>(context);

    final teamwork = providerService.teamwork;

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
          "ປ້ອນຂໍ້ມູນຂໍລາພັກ",
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
                        child: getDetail())
                  ],
                ),
              ),
            ),
    );
  }

  Widget getDetail() {
    final providerService = Provider.of<ProviderService>(context, listen: false);

    final leavesById = providerService.leavesById?.data![0];

    DateTime? startDate = leavesById?.startDate;
    DateTime? endDate = leavesById?.endDate;

    String? dateStart =
        providerService.langs == 'la' ? DateFormat.yMMMMd('lo').format(startDate!) : DateFormat.yMMMMd('en').format(startDate!);
    String? dateEnd =
        providerService.langs == 'la' ? DateFormat.yMMMMd('lo').format(endDate!) : DateFormat.yMMMMd('en').format(endDate!);

    

    return Row(
      children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            "ເວລາຂໍລາພັກ",
            style: TextStyle(
              fontSize: 12.sp,
              color: black,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 10,
          ),

          Text(
            "$dateStart - $dateEnd",
            style: TextStyle(
              fontSize: 14.sp,
              color: primary,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(
            height: 20,
          ),
          Text(
            "ສະຖານະໃບລາພັກ",
            style: TextStyle(
              fontSize: 12.sp,
              color: black,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Text(
            leavesById?.isApproved == -1
                ? 'ບໍ່ອະນຸມັດ'
                : leavesById?.isApproved == 1
                    ? 'ອະນຸມັດ'
                    : leavesById?.isApproved == 0
                        ? "ລໍຖ້າອະນຸມັດ"
                        : '',
            style: TextStyle(
                fontSize: 10.sp,
                color: leavesById?.isApproved == -1
                    ? const Color.fromRGBO(244, 67, 54, 1)
                    : leavesById?.isApproved == 1
                        ? const Color.fromRGBO(76, 175, 79, 1)
                        : leavesById?.isApproved == 0
                            ? const Color.fromRGBO(255, 153, 0, 1)
                            : primary),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Text(
            "ຜູ້ປະຕິບັດວຽກແທນ",
            style: TextStyle(
              fontSize: 12.sp,
              color: black,
              fontWeight: FontWeight.w600,
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: CustomImage(
                      leavesById?.profileImgSubstitute ?? '',
                      width: 60,
                      height: 57,
                      radius: 25,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    "${leavesById?.employeeSubstitute}",
                    style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: primary),
                  ),
                  Text(
                    "${leavesById?.level}",
                    style: TextStyle(fontSize: 10.sp),
                  ),
                  Text(
                    "${leavesById?.departmentName}",
                    style: TextStyle(fontSize: 10.sp),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(
            height: 20.0,
          ),
          Text(
            "ເຫດຜົນຂໍລາພັກ",
            style: TextStyle(
              fontSize: 12.sp,
              color: black,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              "${leavesById?.details}",
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w300, color: primary),
            ),
          ),

          const SizedBox(
            height: 20.0,
          ),

          //     ],
          //   ),
          // )
        ]),
      ],
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
        ..quadraticBezierTo(size.width, size.height / 2, size.width + radius, radius) // TODO connector end & gradient
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
